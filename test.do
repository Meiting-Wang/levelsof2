****** 示例数据构建
clear all
cls
input year strL name
	2000 "aa"
	2001 "bb"
	2002 "bb"
	2001 ""
	2002 ""
	2003 "dd ee"
	2004 "dd ee"
	2000 "hh"
	2001 "hh"
	.    "hh"
end
l, sep(10)


****** 命令使用
*- 数值型变量
levelsof2 year //在Stata界面上报告变量 year 的系列唯一值(同levelsof year)
levelsof2 year if _n<=4 //同上，但额外使用了 if 语句
levelsof2 year in 7/10 //同上，但额外使用了 in 语句
levelsof2 year, missing //同上，但额外也将缺漏值看做唯一值的一种
levelsof2 year, local(year_uni) //同上，但额外将系列唯一值也储存在展元 year_uni 中
levelsof2 year, unique(year_uni) //同上，但额外将系列唯一值储存在新变量以及返回值 r() 的矩阵中（命名均为year_uni）
levelsof2 year, unique(year_uni) frequency(year_freq) //同上，但额外将系列唯一值所对应的频数储存在新变量以及返回值 r() 的矩阵中（命名均为year_freq）
return list //查看返回值


*- 字符型变量
levelsof2 name
levelsof2 name if _n<=4
levelsof2 name in 7/10
levelsof2 name, missing
levelsof2 name, local(name_uni)
levelsof2 name, unique(name_uni) //同上，但由于Stata不支持字符型的矩阵，所以这里返回值r()中没有系列唯一值所对应的矩阵，下同
levelsof2 name, unique(name_uni) frequency(name_freq)
return list
