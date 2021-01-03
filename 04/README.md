# 对偶单纯形法求解LP问题
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
- ### **fDSimplex_eye.m**
    以单位矩阵作为初始解，验证其对 DP 问题的可行性，利用对偶单纯性表求解 LP 问题，原理见[原理模块](#jump4)。

&emsp;

## <span id="jump3">使用方法</span>
- 运行 **fDSimplex_eye.m** 脚本即可。

&emsp;

## <span id="jump4">原理说明</span>
> ![对偶单纯形法流程图](https://note.youdao.com/yws/api/personal/file/A8019EAD9CE243609846F601362214AE?method=download&shareKey=9c7dee0636f42e6f2d3ef863d21d3e9d)
> <p align="right">（以上内容摘自上海大学玛丽艳老师PPT）</p>

&emsp;

## <span id="jump5">输入</span>

```math
A=\left[\begin{array}{lllll}
-1 & -2 & -1 & 1 & 0 \\
-2 & 1 & -3 & 0 & 1 
\end{array}\right],
b=\left[\begin{array}{l}
-3 \\
-4 
\end{array}\right],
c=\left[\begin{array}{l}
-2 \\
-3 \\
-4 \\
0 \\
0 \\
\end{array}\right]
```
- ### 参数说明
    **A：** LP 问题化为标准型后的系数矩阵，一般行数小于等于列数。

    **b：** LP 问题化为标准型后的方程右端系数向量，列向量。
    
    **c：** LP 问题化为标准型后的目标函数系数，列向量。
    
&emsp;

## <span id="jump6">输出</span>
- ### 存在有限最优解  
    输出 [ x_opt ,  fx_opt ,  iter ]。
- ### 无解
    由弱对偶定理，若对偶问题存在无界解，则原问题无解。
- ### 存在无界解或多解
    待完善。
- ### 参数说明
    **x_opt：** LP 问题最优解，列向量，没有有限最优解时为 -1 。

    **fx_opt：** LP 问题最优函数值，没有有限最优解时为 -1 。
    
    **iter：** LP 问题求解迭代次数，没有有限最优解时为 -1 。