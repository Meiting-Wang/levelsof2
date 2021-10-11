clear
cls
input id year x y z strL name
	1 2000 3 5 6 "aa"
	1 2001 5 6 8 "bb"
	1 2002 3 9 7 "bb"
	2 2001 7 11 12 ""
	2 2002 7 16 9 ""
	2 2003 7 11 15 "dd ee"
	2 2004 9 11 12 "dd ee"
	3 2000 12 16 14 "hh"
	3 2001 19 22 11 "hh"
	4 . 3 6 10 "hh"
end
keep year name
l, sep(10)


* 数值型变量的普通使用
cls
l, sep(10)
matrix drop _all
levelsof year //获得 year 的唯一值，储存在返回值 r() 的展元中 
levelsof year, missing //同上，但也将缺漏值看做唯一值之一
levelsof year, local(macyear) //同上，但同样将唯一值储存在展元 macyear 中
levelsof year, separate(",") //同上，但将唯一值之间的间隔改为逗号（在Stata界面报告结果和将其储存在 r() 的展元中时）
levelsof year, matrow(row) //同上，但额外将系列唯一值储存在矩阵 row 中
levelsof year, matcell(cell) //同上，但额外将系列唯一值对应的频数储存在矩阵 cell 中
return list

* 字符型变量的普通使用
cls
l, sep(10)
matrix drop _all
levelsof name
levelsof name, missing
levelsof name, local(macname)
levelsof name, separate(",")
levelsof name, matcell(cell)
return list

* 数值型变量的扩展使用
cls
l, sep(10)
matrix drop _all
levelsof year, matrow(year_uni) matcell(year_freq)
mat coln year_uni = year_uni
mat coln year_freq = year_freq
mat list year_uni
mat list year_freq
svmat year_uni, name(col)
svmat year_freq, name(col)
l, sep(10) abb(10)

* 字符型变量的扩展使用
cls
l, sep(10) abb(10)
matrix drop _all
levelsof name, matcell(name_freq)

local temp `"`r(levels)'"'
gen strL name_uni = ""
local i = 1
foreach s of local temp {
	qui replace name_uni = `"`s'"' in `i'
	local i = `i' + 1
}

mat coln name_freq = name_freq
mat list name_freq
svmat name_freq, name(col)
l, sep(10) abb(10)


*----------------------------------------------------
clear
cls
input id year x y z strL name
	1 2000 3 5 6 "aa"
	1 2001 5 6 8 "bb"
	1 2002 3 9 7 "bb"
	2 2001 7 11 12 ""
	2 2002 7 16 9 ""
	2 2003 7 11 15 "dd ee"
	2 2004 9 11 12 "dd ee"
	3 2000 12 16 14 "hh"
	3 2001 19 22 11 "hh"
	4 . 3 6 10 "hh"
end
keep year name
l, sep(10)

* 数值型变量的扩展使用(包含missing)
cls
l, sep(10)
matrix drop _all
levelsof year, matrow(year_uni) matcell(year_freq) missing
mat coln year_uni = year_uni
mat coln year_freq = year_freq
mat list year_uni
mat list year_freq
svmat year_uni, name(col)
svmat year_freq, name(col)
l, sep(10) abb(10)


* 字符型变量的扩展使用(包含missing)
cls
l, sep(10) abb(10)
matrix drop _all
levelsof name, matcell(name_freq) missing

local temp `"`r(levels)'"'
gen strL name_uni = ""
local i = 1
foreach s of local temp {
	qui replace name_uni = `"`s'"' in `i'
	local i = `i' + 1
}

mat coln name_freq = name_freq
mat list name_freq
svmat name_freq, name(col)
l, sep(10) abb(10)
