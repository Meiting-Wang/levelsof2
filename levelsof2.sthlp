{smcl}
{right:Created time: Sep 24, 2021}
{* -----------------------------title------------------------------------ *}{...}
{p 0 20 2}
{bf:[W-17] levelsof2} {hline 2} An enhanced version of command {help levelsof}. You can view the source code in {browse "https://github.com/Meiting-Wang/levelsof2":github}.


{* -----------------------------Syntax------------------------------------ *}{...}
{title:Syntax}

{p 8 8 2}
{cmd:levelsof2} {varlist} [, {it:{help levelsof2##Options:options}}]


{* -----------------------------Contents------------------------------------ *}{...}
{title:Contents}

{p 4 4 2}
{help levelsof2##Description:Description}{break}
{help levelsof2##Options:Options}{break}
{help levelsof2##Examples:Examples}{break}
{help levelsof2##Author:Author}{break}
{help levelsof2##Also_see:Also see}{break}


{* -----------------------------Description------------------------------------ *}{...}
{marker Description}{title:Description}

{p 4 4 2}
In addition to what {help levelsof} can do, {cmd:levelsof2} can also Extract the unique value in the variable and convert it into a matrix and new variables.

{p 4 4 2}
{cmd:levelsof2} will generate new variables containing the unique value of the given variables, respectively, if option {opt novar} not set.

{p 4 4 2}
{cmd:levelsof2} will generate new matrices in {bf:r()} containing the unique value of the given variables, respectively, if option {opt nomat} not set.

{p 4 4 2}
{cmd:levelsof2} will always generate new local macros in {bf:r()} containing the unique value of the given variables, respectively.

{p 4 4 2}
It is worth noting that this command can only be used in version 16.0 or later.


{* -----------------------------Options------------------------------------ *}{...}
{marker Options}{title:Options}

{synoptset 20}{...}
{synopthdr:install options}
{synoptline}
{synopt :{opth pre:fix(strings:string)}}Customize the names of local macros and matrix in {bf:r()} and new variables by adding prefix.{p_end}
{synopt :{opth post:fix(strings:string)}}Customize the names of local macros and matrix in {bf:r()} and new variables by adding postfix.{p_end}
{synopt :{opt novar}}Do not generate new variables containing the unique value of the given variables.{p_end}
{synopt :{opt nomat}}Do not generate new matrices in {bf:r()} containing the unique value of the given variables.{p_end}
{synoptline}
{p 4 4 2}{it:notes}: If {opt prefix} and {opt postfix} not set, {opt postfix(_uni)} will be specified by default.{p_end}


{* -----------------------------Examples------------------------------------ *}{...}
{marker Examples}{title:Examples}

{p 4 4 2}Setup{p_end}
{p 8 10 2}. {stata sysuse auto.dta, clear}{p_end}

{p 4 4 2}Extract the unique values of a single variable{p_end}
{p 8 10 2}. {stata levelsof2 rep78}{p_end}

{p 4 4 2}Extract the unique values of multiple variables{p_end}
{p 8 10 2}. {stata levelsof2 rep78 foreign}{p_end}

{p 4 4 2}Do not generate new variables{p_end}
{p 8 10 2}. {stata levelsof2 rep78 foreign, novar}{p_end}

{p 4 4 2}Do not generate new matrices in {bf:r()}{p_end}
{p 8 10 2}. {stata levelsof2 rep78 foreign, nomat}{p_end}

{p 4 4 2}Customize the names of local macros and matrix in {bf:r()} and new variables by adding prefix or postfix{p_end}
{p 8 10 2}. {stata levelsof2 rep78 foreign, pre(pre_) post(_post)}{p_end}


{* -----------------------------Author------------------------------------ *}{...}
{marker Author}{title:Author}

{p 4 4 2}
Meiting Wang{break}
Institute for Economic and Social Research, Jinan University{break}
Guangzhou, China{break}
wangmeiting92@gmail.com


{* -----------------------------Also see------------------------------------ *}{...}
{marker Also_see}{title:Also see}

{space 4}{help levelsof}

