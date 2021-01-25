\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{weeklyslides}[ECE 497 Weekly Report Slides]

\LoadClass[x11names]{beamer}
\usetheme{default} % Default slide/frame theme
\usecolortheme{seahorse} % Use the seahorse color variant of default theme

%Stuff Alex added, might be redundent
\usepackage{enumitem}
\usepackage{hyperref}

\hypersetup{ 		% yes, I like colored links
    colorlinks=true,
    linkcolor=blue,
    filecolor=magenta,      
    urlcolor=cyan,
}
%end Alex Stuff

\useoutertheme{default} % Use the default layout theme for frames/slides
\setbeamertemplate{footline}[frame number] % Put "frame/totalframes" in footline
\beamertemplatenavigationsymbolsempty{}

\RequirePackage[utf8]{inputenc} % Define the input encoding
\RequirePackage[USenglish]{babel} % Define language used
\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage{amsthm} % Gives us plain, definition, and remark to use in \theoremstyle{style}
\RequirePackage{mathtools} % Allow for text and math in align* environment.
\RequirePackage{thmtools}

\RequirePackage{graphicx}

\RequirePackage[
backend=biber,
style=alphabetic,
citestyle=authoryear]{biblatex} % Must include citation somewhere in document to print bibliography
\RequirePackage{hyperref} % Generate hyperlinks to referenced items
% \RequirePackage[nottoc]{tocbibind} % Prints the Reference/Bibliography in TOC as well
\RequirePackage[noabbrev,nameinlink]{cleveref} % Fancy cross-references in the document everywhere
\RequirePackage{nameref} % Can make references by name to places
\RequirePackage{caption} % Allows for greater control over captions in figure, algorithm, table, etc. environments
\RequirePackage{subcaption} % Allows for multiple figures in one Figure environment
\RequirePackage[binary-units=true]{siunitx} % Gives us ways to typeset units for stuff
\RequirePackage{csquotes} % Context-sensitive quotation facilities
\RequirePackage{chngcntr} % Allows us to tamper with the counter a little more
\RequirePackage{empheq} % Allow boxing of equations in special math environments
\RequirePackage{xcolor} % Gives access to coloring text in environments or just text, MUST be before tikz
\RequirePackage{tikz} % Allows us to create TikZ and PGF Pictures


\RequirePackage{ctable} % Greater control over tables and how they look
\RequirePackage{diagbox} % Allow us to have shared diagonal cells in tables
\RequirePackage{multirow} % Allow us to have a single cell in a table span multiple rows
\RequirePackage[linesnumbered,ruled,vlined]{algorithm2e} % Allows us to write algorithms in a nice style.
\RequirePackage{nth} % Programmtically give ordinal numbers.

\counterwithin{figure}{section}
\counterwithin{table}{section}
\counterwithin{equation}{section}
\counterwithin{algocf}{section}
\crefname{algocf}{algorithm}{algorithms}
\Crefname{algocf}{Algorithm}{Algorithms}
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4} % Include \paragraph in toc
\crefname{paragraph}{paragraph}{paragraphs}
\Crefname{paragraph}{Paragraph}{Paragraphs}

% Create an unnumbered remark environment for general use
% NOTE: This version of remark has NO restrictions on placement
\newtheorem*{remark*}{Remark}

% Logical Operators
\DeclareMathOperator{\XOR}{\oplus}

% x86 CPU Registers
\newcommand{\rbpRegister}{\texttt{\%rbp}}
\newcommand{\rspRegister}{\texttt{\%rsp}}
\newcommand{\ripRegister}{\texttt{\%rip}}
\newcommand{\raxRegister}{\texttt{\%rax}}
\newcommand{\rbxRegister}{\texttt{\%rbx}}

%%% Local Variables:
%%% mode: latex
%%% TeX-master: shared
%%% End:
