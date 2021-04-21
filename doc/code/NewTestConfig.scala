package chipyard
import freechips.rocketchip.config.{Config}
import freechips.rocketchip.diplomacy.{AsynchronousCrossing}

class NewTestConfig extends Config(
    new sha3.WithSha3Accel ++                                // Add SHA3 accelerator
    new freechips.rocketchip.subsystem.WithDefaultMemPort ++ // Default Rocket chip memory subsystem configuration
    new freechips.rocketchip.subsystem.WithNMedCores(4) ++   // 4 Medium-sized In-Order Rocket Cores
    new chipyard.config.AbstractConfig)