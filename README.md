# Stata 新命令：levelsof2--加强版的 levelsof

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 一、引言

众所周知，`levelsof`命令可以将变量的唯一值储存在 local macro 中（可以通过`return list` 查看），但有时候我们还需要生成其唯一值构成的新变量，于是便诞生了这个命令。这个命令具有以下特点：

- 除了可以将指定变量的唯一值储存在 local macro 中，还可以将其储存在 **r()** 的 matrix 中以及 data set 的新变量中；
- 可以同时对多个变量进行如上操作；
- 运行程序后，Stata 界面上也会显示指定的各个变量的唯一值，以方便查看；
- 可以通过选项选择是否需要生成 **r()** 中的 matrix 或 data set 中的新变量；
- 可以自定义指定变量唯一值的储存名（通过添加前缀或后缀的方式）。

值得注意的是，该命令仅能使用于 16.0 及以上版本的 Stata 软件中。

## 二、命令的安装

`levelsof2`及本人其他命令的代码都托管于 GitHub 上，读者可随时下载安装这些命令。

你可以通过系统自带的`net`命令进行安装：

```stata
net install levelsof2, from("https://raw.githubusercontent.com/Meiting-Wang/levelsof2/main")
```

也可以通过我所写的命令 `wmt` 进行安装：

```stata
wmt install levelsof2
```

> `wmt` 命令可以查询并安装所有我写过的命令。该命令本身可以通过 `net install wmt, from("https://raw.githubusercontent.com/Meiting-Wang/wmt/main")` 进行安装。更多细节参见 [Stata 新命令：wmt——查询并安装个人写的 Stata 新命令](https://mp.weixin.qq.com/s/P2V_6et9crS5GeNNfO-6xQ)。

## 三、语法与选项

**命令语法**：

```stata
 levelsof2 varlist [, options]
```

**选项（options）**：

- `prefix(string)`: 通过添加前缀的形式自定义生成新变量以及返回值 local 和 matrix 的名称（在原有变量名的基础上添加前缀）
- `postfix(string)`: 通过添加后缀的形式自定义生成新变量以及返回值 local 和 matrix 的名称（在原有变量名的基础上添加后缀）
- `novar`: 不生成用于储存唯一值的新变量
- `nomat`: 不生成用于储存唯一值的返回值 matrix

> 注意: 如果`prefix`和`postfix`都没有设定，则默认会设定`postfix(_uni)`。

## 四、实例

```stata
sysuse auto.dta, clear
levelsof2 rep78 //提取变量x的唯一值，并将其储存于新变量以及返回值 local 和 matrix 中
levelsof2 rep78 foreign //对多个变量进行如上操作
levelsof2 rep78 foreign, novar //不生成用于储存唯一值的新变量
levelsof2 rep78 foreign, nomat //不生成用于储存唯一值的返回值 matrix
levelsof2 rep78 foreign, pre(pre_) post(_post) //通过添加前后缀的形式自定义生成新变量以及返回值 local 和 matrix 的名称（在原有变量名的基础上添加前后缀）
return list //展示返回值
```

> 以上所有实例都可以在`help levelsof2`中直接运行。
>
> ![](https://cdn.jsdelivr.net/gh/Meiting-Wang/pictures/picgo/picgo-20210925131148.png)



## 五、输出效果展示

**命令行：**

```stata
sysuse auto.dta, clear
levelsof2 rep78 foreign
list rep78 foreign rep78_uni foreign_uni in 1/10, sep(10) ab(16)
return list
```

**输出结果：**

```stata
. sysuse auto.dta, clear
(1978 Automobile Data)

. levelsof2 rep78 foreign
Unique values in rep78: 1 2 3 4 5
Unique values in foreign: 0 1

. list rep78 foreign rep78_uni foreign_uni in 1/10, sep(10) ab(16)

     +--------------------------------------------+
     | rep78    foreign   rep78_uni   foreign_uni |
     |--------------------------------------------|
  1. |     3   Domestic           1             0 |
  2. |     3   Domestic           2             1 |
  3. |     .   Domestic           3             . |
  4. |     3   Domestic           4             . |
  5. |     4   Domestic           5             . |
  6. |     3   Domestic           .             . |
  7. |     .   Domestic           .             . |
  8. |     3   Domestic           .             . |
  9. |     3   Domestic           .             . |
 10. |     3   Domestic           .             . |
     +--------------------------------------------+

. return list

macros:
        r(foreign_uni) : "0 1"
          r(rep78_uni) : "1 2 3 4 5"

matrices:
        r(foreign_uni) :  2 x 1
          r(rep78_uni) :  5 x 1
```

> 点击【阅读原文】可进入该命令的 github 项目。
