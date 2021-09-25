* Description: An enhanced version of command levelsof. In addition to what levelsof can do, this command can also Extract the unique value in the variable and convert it into a matrix and new variables.
* Author: Meiting Wang, Ph.D. Candidate, Institute for Economic and Social Research, Jinan University
* Email: wangmeiting92@gmail.com
* Created on Sep 24, 2021



program define levelsof2, rclass
version 16.0

syntax varlist(numeric) [, PREfix(string) POSTfix(string) NOVAR NOMAT]

* 错误信息判定
if ustrregexm("`prefix'","\s+") {
	dis as error "{opt prefix} cannot contain spaces"
	error 9999
}

if ustrregexm("`postfix'","\s+") {
	dis as error "{opt postfix} cannot contain spaces"
	error 9999
}


* 设置 postfix 选项默认值
if ("`prefix'" == "") & ("`postfix'" == "") {
	local postfix "_uni" //设置postfix选项的默认值
}


*---------------------------主程序-----------------------------
local i = 1
while "`varlist'" != "" {
	gettoken varname varlist : varlist //依次提取变量
	qui levelsof `varname'
	tempname mat`i'
	mat `mat`i'' = (`=ustrregexra("`r(levels)'","\s+","\\")') //依次生成包含变量唯一值的向量(矩阵)
	mat coln `mat`i'' = `prefix'`varname'`postfix'

	* 屏幕上输出结果
	dis as text "Unique values in {bf:`varname'}: {result:`r(levels)'}"

	* 返回值或生成对应变量
	return local `prefix'`varname'`postfix' "`r(levels)'"
	if ("`nomat'" == "") & ("`novar'" == "") {
		svmat `mat`i'', names(col)
		return matrix `prefix'`varname'`postfix' = `mat`i''
	}
	else if ("`nomat'" == "") & ("`novar'" != "") {
		return matrix `prefix'`varname'`postfix' = `mat`i''
	}
	else if ("`nomat'" != "") & ("`novar'" == "") {
		svmat `mat`i'', names(col)
	}
	
	local i = `i' + 1
}

end
