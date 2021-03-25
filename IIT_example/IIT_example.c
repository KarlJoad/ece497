/* Copyright 2019 SiFive, Inc */
/* SPDX-License-Identifier: Apache-2.0 */

#include <stdio.h>
#include <metal/cpu.h>
#include <metal/led.h>
#include <metal/button.h>
#include <metal/switch.h>
#include <metal/uart.h>
#include <string.h>
#define RTC_FREQ    32768

struct metal_cpu *cpu;
struct metal_interrupt *cpu_intr, *tmr_intr;
int tmr_id;
volatile uint32_t timer_isr_flag;

void display_banner (void) {

    char mainMSG[] = "\r\n    Illinois Tech ECE\
    \r\nAlex Lukens and Karl Hallsby\
    \r\n\
    \r\nIIIII    IIIII   IIIIIIII\
    \r\n  I        I         I\
    \r\n  I        I         I\
    \r\n  I        I         I\
    \r\n  I        I         I\
    \r\nIIIII    IIIII       I\
    \r\n\
    \r\nRunning on RISCV!\
    \r\nABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=`";
    for(int i=0; i<(sizeof(mainMSG)/sizeof(char)); i++) metal_tty_putc(mainMSG[i]);

}

void timer_isr (int id, void *data) {

    // Disable Timer interrupt
    metal_interrupt_disable(tmr_intr, tmr_id);

    // Flag showing we hit timer isr
    timer_isr_flag = 1;
}

void wait_for_timer(struct metal_led *which_led) {

    // clear global timer isr flag
    timer_isr_flag = 0;

    // Turn on desired LED
    metal_led_on(which_led);

    // Set timer
    metal_cpu_set_mtimecmp(cpu, metal_cpu_get_mtime(cpu) + RTC_FREQ);

    // Enable Timer interrupt
    metal_interrupt_enable(tmr_intr, tmr_id);

    // wait till timer triggers and isr is hit
    while (timer_isr_flag == 0){};

    timer_isr_flag = 0;

    // Turn off this LED
    metal_led_off(which_led);
}

int main (void)
{
    int rc;

    // Lets get the CPU and and its interrupt
    cpu = metal_cpu_get(metal_cpu_get_current_hartid());
    if (cpu == NULL) {
        printf("CPU null.\n");
        return 2;
    }
    cpu_intr = metal_cpu_interrupt_controller(cpu);
    if (cpu_intr == NULL) {
        printf("CPU interrupt controller is null.\n");
        return 3;
    }
    metal_interrupt_init(cpu_intr);

    // display welcome banner
    display_banner();
    
    // Setup Timer and its interrupt so we can toggle LEDs on 1s cadence
    tmr_intr = metal_cpu_timer_interrupt_controller(cpu);
    if (tmr_intr == NULL) {
        printf("TIMER interrupt controller is  null.\n");
        return 4;
    }
    metal_interrupt_init(tmr_intr);
    tmr_id = metal_cpu_timer_get_interrupt_id(cpu);
    rc = metal_interrupt_register_handler(tmr_intr, tmr_id, timer_isr, cpu);
    if (rc < 0) {
        printf("TIMER interrupt handler registration failed\n");
        return (rc * -1);
    }

    // Lastly CPU interrupt
    if (metal_interrupt_enable(cpu_intr, 0) == -1) {
        printf("CPU interrupt enable failed\n");
        return 6;
    }
 
    struct metal_gpio *gpio_21 = metal_gpio_get_device(0);
    if(gpio_21 == NULL)
    {
        printf("GPIO NO WORK\n");
        return 3;
    }
    struct metal_gpio *gpio_11 = metal_gpio_get_device(0);
    struct metal_led *blue_led0 = &gpio_11;

    if(blue_led0 == NULL)
    {
        printf("LED NO WORK\n");
        return 1;
    }
    

    static char cmd[50] = "";
    static int frontPointer = 0;
    static int currentChar=-1;
    char monitor[] = "\r\nRISCV-IIT>";
    char hello[] = "Hello, World!";
    char whoami[] = "I am an FPGA running RISCV";
    char help[] = ("---RISCV MONITOR---\
    \r\nHELP -          Display this message\
    \r\nHELLO -         Show Hello, World message\
    \r\nWHOAMI -        Show message to terminal");

    
    while(1)
    {
        if(frontPointer==0) {

            for(int i = 0; i<(sizeof(monitor)/sizeof(char)); i++) metal_tty_putc(monitor[i]);
            
        }
        while(metal_tty_getc(&currentChar)==-1) { }
        

        switch (currentChar) {
        case ('\r'):
            printf("\r\n");
            //end of line, process command 

            if (strncmp(cmd,"HELLO",5)==0)
            {
                for(int i = 0; i<(sizeof(hello)/sizeof(char)); i++) metal_tty_putc(hello[i]);
            }
            else if(strncmp(cmd, "WHOAMI",6)==0)
            {
                for(int i = 0; i<(sizeof(whoami)/sizeof(char)); i++) metal_tty_putc(whoami[i]);
            }
            
            else if(strncmp(cmd, "HELP",4)==0)
            {
                for(int i = 0; i<(sizeof(help)/sizeof(char)); i++) metal_tty_putc(help[i]);
            }
            else if(strncmp(cmd, "ECHO",4)==0)
            {
                              
                char *tmpStr = strchr(cmd, ' ');
                if(tmpStr==NULL) {
                    printf("nothing to echo\r\n");
                    break;
                }
                int i = 1;
                while(i<50 && tmpStr[i] != '\n') {
                    metal_tty_putc(tmpStr[i]);
                    i++;
                }

                
                
            }
            frontPointer = 0;
            memset(cmd," ",strlen(cmd));
            break;
        case('\b'):
            break;
        default:
            metal_tty_putc(currentChar);
            cmd[frontPointer]=(char)currentChar;
            frontPointer++;
            break;
        }
        
        
    }
    

    
    return 0;
}
