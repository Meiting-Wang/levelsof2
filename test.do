cls
pr drop _all
sysuse auto.dta, clear

levelsof2 rep78 //提取变量x的唯一值，并将其储存于新变量以及返回值 local 和 matrix 中
levelsof2 rep78 foreign //对多个变量进行如上操作
levelsof2 rep78 foreign, novar //不生成用于储存唯一值的新变量
levelsof2 rep78 foreign, nomat //不生成用于储存唯一值的返回值 matrix
levelsof2 rep78 foreign, pre(pre_) post(_post) //通过添加前后缀的形式自定义生成新变量以及返回值 local 和 matrix 的名称（在原有变量名的基础上添加前后缀）
return list //展示返回值
