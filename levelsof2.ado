* Description: An enhanced version of command levelsof. In addition to what levelsof can do, the command can also extract unique values in the variable and convert it into a new variable.
* Author: Meiting Wang, Ph.D. Candidate, Institute for Economic and Social Research, Jinan University
* Email: wangmeiting92@gmail.com
* Created on Sep 24, 2021
* Updated on Oct 11, 2021


program define levelsof2, rclass
version 16.0

syntax varname [if] [in] [, Unique(name) Frequency(name) Local(name local) Missing]

* 设置tempname
tempname local_temp


* 错误设定
if ("`unique'"=="") & ("`frequency'"!="") {
	dis as error "{opt frequency} cannot exist without {opt unique}"
	error 9999
} //frequency不能在没有unique时存在


* 核心程序
local var_type: type `varlist'
if ustrregexm("`var_type'","^str") { //1. 字符型变量的情况
	if "`unique'" == "" { //1.1 unique frequency 为空
		levelsof `varlist' `if' `in', `missing'
	}
	else if "`frequency'" == "" { //1.2 unique 不为空，frequency 为空
		levelsof `varlist' `if' `in', `missing'
		local `local_temp' "`r(levels)'"
		qui generate strL `unique' = ""
		local i = 1
		foreach s of local `local_temp' {
			qui replace `unique' = `"`s'"' in `i'
			local i = `i' + 1
		}
	}
	else { //1.3 unique 不为空，frequency 不为空
		levelsof `varlist' `if' `in', `missing' matcell(`frequency')
		local `local_temp' "`r(levels)'"
		qui generate strL `unique' = ""
		local i = 1
		foreach s of local `local_temp' {
			qui replace `unique' = `"`s'"' in `i'
			local i = `i' + 1
		}

		mat coln `frequency' = `frequency'
		svmat `frequency', name(col)
	}
}
else { //2. 数值型变量的情况
	if "`unique'" == "" { //2.1 unique frequency 为空
		levelsof `varlist' `if' `in', `missing'
	}
	else if "`frequency'" == "" { //2.2 unique 不为空，frequency 为空
		levelsof `varlist' `if' `in', `missing' matrow(`unique')
		mat coln `unique' = `unique'
		svmat `unique', name(col)
	}
	else { //2.3 unique 不为空，frequency 不为空
		levelsof `varlist' `if' `in', `missing' matrow(`unique') matcell(`frequency')
		mat coln `unique' = `unique'
		mat coln `frequency' = `frequency'
		svmat `unique', name(col)
		svmat `frequency', name(col)
	}
}

if "`local'" != "" { //等同于 levelsof 的 local() 选项
	c_local `local' "`r(levels)'"
}


* 返回值
ret local levels "`r(levels)'"
ret scalar total_num = r(N)
ret scalar unique_num = r(r)
if ustrregexm("`var_type'","^str") & ("`unique'"!="") & ("`frequency'"!="") {
	ret mat `frequency' = `frequency'
}
if ~ustrregexm("`var_type'","^str") & ("`unique'"!="") & ("`frequency'"=="") {
	ret mat `unique' = `unique'
}
if ~ustrregexm("`var_type'","^str") & ("`unique'"!="") & ("`frequency'"!="") {
	ret mat `unique' = `unique'
	ret mat `frequency' = `frequency'
}
end
