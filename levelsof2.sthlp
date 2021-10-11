{smcl}
{right:Created time: Sep 24, 2021}
{right:Updated time: Oct 11, 2021}
{* -----------------------------title------------------------------------ *}{...}
{p 0 20 2}
{bf:[W-17] levelsof2} {hline 2} An enhanced version of command {help levelsof}. You can view the source code in {browse "https://github.com/Meiting-Wang/levelsof2":github}.


{* -----------------------------Syntax------------------------------------ *}{...}
{title:Syntax}

{p 8 10 2}
{cmd:levelsof2} {varname} {ifin} [, {opth u:nique(newvarname)} {opth f:requency(newvarname)} {opt l:ocal(macname)} {opt m:issing}]


{* -----------------------------Contents------------------------------------ *}{...}
{title:Contents}

{p 4 4 2}
{help levelsof2##Description:Description}{break}
{help levelsof2##Options:Options}{break}
{help levelsof2##Stored:Stored results}{break}
{help levelsof2##Examples:Examples}{break}
{help levelsof2##Author:Author}{break}
{help levelsof2##Also_see:Also see}{break}


{* -----------------------------Description------------------------------------ *}{...}
{marker Description}{title:Description}

{p 4 4 2}
In addition to what {help levelsof} can do, {cmd:levelsof2} can also extract unique values of the specified variable and convert it into a new variable in ascending order.

{p 4 4 2}
Moreover, user can choose whether to generate a variable containing frequencies corresponding to unique values of the specified variable.

{p 4 4 2}
It is worth noting that this command can only be used in version 16.0 or later.


{* -----------------------------Options------------------------------------ *}{...}
{marker Options}{title:Options}

{synoptset 22}{...}
{synopthdr}
{synoptline}
{synopt :{opth u:nique(newvarname)}}Set a new variable to store unique values{p_end}
{synopt :{opth f:requency(newvarname)}}Set a new variable to store frequencies corresponding to unique values{p_end}
{synopt :{opt l:ocal(macname)}}Insert the list of unique values into the local macro {it:macname}{p_end}
{synopt :{opt m:issing}}Include missing values of the specified variable in calculation{p_end}
{synoptline}


{* -----------------------------Stored results------------------------------------ *}{...}
{marker Stored}{title:Stored results}

{synoptset 22 tabbed}{...}
{synopthdr:return values}
{synoptline}
{syntab:Scalars}
{synopt :{bf:r(unique_num)}}Number of unique values{p_end}
{synopt :{bf:r(total_num)}}Number of observations{p_end}

{syntab:Macros}
{synopt :{bf:r(levels)}}List of unique values{p_end}

{syntab:Matrices}
{synopt :{bf:r(`unique')}}Column vector of unique values(only exists when the specified variable is numeric){p_end}
{synopt :{bf:r(`frequency')}}Column vector of frequencies corresponding to unique values{p_end}
{synoptline}


{* -----------------------------Examples------------------------------------ *}{...}
{marker Examples}{title:Examples}

{p 4 4 2}Setup{p_end}
{p 8 10 2}. {stata sysuse auto.dta, clear}{p_end}

{p 4 4 2}For the numeric variable{p_end}
{p 8 10 2}. {stata levelsof2 rep78}{p_end}
{p 8 10 2}. {stata levelsof2 rep78, missing}{p_end}
{p 8 10 2}. {stata levelsof2 rep78, local(rep78_uni)}{p_end}
{p 8 10 2}. {stata levelsof2 rep78, unique(rep78_uni)}{p_end}
{p 8 10 2}. {stata levelsof2 rep78, unique(rep78_uni) frequency(rep78_freq)}{p_end}
{p 8 10 2}. {stata return list}{p_end}

{p 4 4 2}For the string variable{p_end}
{p 8 10 2}. {stata levelsof2 make}{p_end}
{p 8 10 2}. {stata levelsof2 make, missing}{p_end}
{p 8 10 2}. {stata levelsof2 make, local(make_uni)}{p_end}
{p 8 10 2}. {stata levelsof2 make, unique(make_uni)}{p_end}
{p 8 10 2}. {stata levelsof2 make, unique(make_uni) frequency(make_freq)}{p_end}
{p 8 10 2}. {stata return list}{p_end}


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

