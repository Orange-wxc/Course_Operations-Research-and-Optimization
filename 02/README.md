# LP问题求解基本可行解及基矩阵
&emsp;

## 文档目录
- ### [环境](#jump1)
- ### [文件结构](#jump2)
- ### [使用方法](#jump3)
- ### [原理说明](#jump4)
- ### [输入](#jump5)
- ### [输出](#jump6)

&emsp;

## <span id="jump1">环境</span>
- MATLAB R2016b

&emsp;

## <span id="jump2">文件结构</span>
- ### **BFS.m**
    Basic Feasible Solution，内含求解基本可行解及其对应基矩阵的函数，原理见[原理模块](#jump4)。

- ### **homework_2.m**
    执行文件，内含实验样例参数，样例见[输入模块](#jump5)。

&emsp;

## <span id="jump3">使用方法</span>
- 运行 **home_work2.m** 脚本即可。

&emsp;

## <span id="jump4">原理说明</span>
> - 系数矩阵`$ A $`中任意`$m$`列所组成的`$m$`阶可逆子方阵`$B$`，称为(`$LP$`)的一个基(矩阵)，变量`$x_{j}$`，若它所对应的列`$P_{j}$`包含在基`$B$`中，则称`$x_{j}$`为基变量，否则称为非基变量。
> - 设`$A=\left[\begin{array}{ll}B& N\end{array}\right]$`，其中`$r(B)=m$`，设`$x=\left[\begin{array}{l}x_{B}\\x_{N}\end{array}\right]$`，
令`$x_{N}=0$`，则有`$LP$`的基本解`$x=\left[\begin{array}{c}B^{-1}b\\0\end{array}\right]$`。
> - 若`$B^{-1}b\geq0$`，则称`$x=\left[\begin{array}{c}B^{-1}b\\0\end{array}\right]$`为`$LP$`的基本可行解。
> <p align="right">（以上内容摘自上海大学马丽艳老师PPT）</p>

&emsp;

## <span id="jump5">输入</span>
```math
\text {s.t.}\left\{\begin{array}{r}
2 x_{1}+x_{2}+x_{3}=10 \\
x_{1}+x_{2}+x_{4}=8 \\
x_{2}+x_{5}=7 \\
x_{1}, x_{2}, x_{3}, x_{4}, x_{5} \geq 0
\end{array}\right.
```
***
![](http://latex.codecogs.com/gif.latex?\\sigma=\sqrt{\frac{1}{n}{\sum_{k=1}^n(x_i-\bar{x})^2}})
写成矩阵形式：
```math
![](http://latex.codecogs.com/gif.latex?A=\left[\begin{array}{lllll}
2 & 1 & 1 & 0 & 0 \\
1 & 1 & 0 & 1 & 0 \\
0 & 1 & 0 & 0 & 1
\end{array}\right],
b=\left[\begin{array}{l}
10 \\
8 \\
7
\end{array}\right]）
```
&emsp;

## <span id="jump6">输出</span>
- ### xs  
    解的矩阵，每行对应一组解，一行中列i的值代表xi。
- ### Bs
    基矩阵的三维矩阵，与xs中的每一行解一一对应。
- ### x_num
    基本可行解的数量。