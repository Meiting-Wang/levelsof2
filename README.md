# Stata 命令 levelsof2 的更新——加强版 levelsof

> 作者：王美庭  
> Email: wangmeiting92@gmail.com

## 一、引言

为了保留命令`levelsof`的特色以及进一步增加其他功能，我们几乎重写了这个命令（语法与选项与之前写的版本大不一样）。如果读者还是比较习惯之前的版本，则可以在该命令的 GitHub 项目中找到早期的 release 进行下载并手动安装，对应的旧推文参见[Stata 新命令：levelsof2--加强版 levelsof](https://mp.weixin.qq.com/s/99YEiViH9fSAa6cXKYESNg)。重写的命令具有以下特点：

- 保留了命令`levelsof`的核心内容（去除了那些平常几乎不会用到的内容），读者可以像使用`levelsof`命令一样使用`levelsof2`命令
- `levelsof2`能提取指定变量的系列唯一值，然后可将其分别储存在返回值 **r()** 的 local、matrices 中以及数据集的新变量中
- `levelsof2`能提取上面这些系列唯一值所对应的频数，然后可将其储存在返回值 **r()** 的 matrices 中以及数据集的新变量中
- `levelsof2`能将这些系列唯一值储存在用户设定的 local 中，以便于用户接下来使用`foreach` 循环
- 用户可选择是否将缺漏值也纳入唯一值的统计中
- 该命令同时支持数值型变量和字符型变量

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

> `wmt` 命令可以查询并安装所有我写过的命令。该命令本身可以通过 `net install wmt, from("https://raw.githubusercontent.com/Meiting-Wang/wmt/main")` 进行安装。更多细节参见[Stata 命令 wmt 的更新——查询并安装个人写的 Stata 新命令](https://mp.weixin.qq.com/s/kXtYQX-dX5ELH8KNar9Vnw)。

## 三、语法与选项

**命令语法**：

```stata
levelsof2 varname [if] [in] [, unique(newvarname) frequency(newvarname) local(macname) missing]
```

**选项（options）**：

- `unique(newvarname)`: 设置用于储存指定变量系列唯一值的新变量
- `frequency(newvarname)`: 设置用于储存以上系列唯一值所对应的频数的新变量
- `local(macname)`: 设置用于储存以上系列唯一值的局部展元（local macro）
- `missing`: 设置将缺漏值也纳入唯一值的统计中

> 对于该命令，还有以下要注意的点：
>
> - `unique(newvarname)`和`frequency(newvarname)`选项同时也会将系列唯一值及其频数储存在返回值 **r()** 的 matrices 中（与设定的变量同名）。一个例外是，对于字符型变量，其无法在返回值 **r()** 中生成系列唯一值的矩阵，原因在于 Stata 不支持字符型矩阵（当然，Mata 是支持的，但其是属于另外一个体系了）。
> - 无论怎么样，系列唯一值都会储存在返回值 **r()** 的局部展元`r(levels)`中（同`levelsof`命令）
> - 无论怎么样，命令都会将指定变量的系列唯一值展示在 Stata 界面上（同`levelsof`命令）
> - 唯一值的储存顺序为升序（同`levelsof`命令）
> - 选项都可以缩写，详情可以安装命令后`help levelsof2`

## 四、实例

```stata
* 数据导入
sysuse auto.dta, clear

* 对于数值型变量
levelsof2 rep78
levelsof2 rep78, missing
levelsof2 rep78, local(rep78_uni)
levelsof2 rep78, unique(rep78_uni)
levelsof2 rep78, unique(rep78_uni) frequency(rep78_freq)
return list

* 对于字符型变量
levelsof2 make
levelsof2 make, missing
levelsof2 make, local(make_uni)
levelsof2 make, unique(make_uni)
levelsof2 make, unique(make_uni) frequency(make_freq)
return list
```

> 以上实例都可以在`help levelsof2`中直接运行。
>
> ![image-20211011230302787](https://cdn.jsdelivr.net/gh/Meiting-Wang/pictures/picgo/picgo-202110112303863.png)



## 五、输出效果展示

**命令行：**

```stata
cls
sysuse auto.dta, clear
levelsof2 rep78, unique(rep78_uni) frequency(rep78_freq)
return list
list rep78* in 1/10, abb(20)
```

**输出结果：**

```stata
. sysuse auto.dta, clear
(1978 automobile data)

. levelsof2 rep78, unique(rep78_uni) frequency(rep78_freq)
1 2 3 4 5

. return list

scalars:
         r(unique_num) =  5
          r(total_num) =  69

macros:
             r(levels) : "1 2 3 4 5"

matrices:
         r(rep78_freq) :  5 x 1
          r(rep78_uni) :  5 x 1

. list rep78* in 1/10, sep(10) abb(20)

     +--------------------------------+
     | rep78   rep78_uni   rep78_freq |
     |--------------------------------|
  1. |     3           1            2 |
  2. |     3           2            8 |
  3. |     .           3           30 |
  4. |     3           4           18 |
  5. |     4           5           11 |
  6. |     3           .            . |
  7. |     .           .            . |
  8. |     3           .            . |
  9. |     3           .            . |
 10. |     3           .            . |
     +--------------------------------+
```

> 点击【阅读原文】可进入该命令的 github 项目。
