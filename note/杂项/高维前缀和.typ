#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#import "@preview/tablem:0.2.0": tablem, three-line-table
#set text(font:"Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold
= 高维前缀和

我们先谈论最简单的二维前缀和，显然，我们可以通过以下代码求出。

```cpp
for(int i=1;i<=n;i++){
  for(int j=1;j<=n;j++){
    a[i][j]=a[i][j]+a[i-1][j]+a[i][j-1]-a[i-1][j-1];
  }
}
```

不过，若我们使用容斥原理，显然对高维不太好处理。所以我们在求二维前缀和的时候，还存在着另一种方法：

```cpp
for(int i=1;i<=n;i++){
  for(int j=1;j<=n;j++){
    a[i][j]=a[i][j-1]+a[i][j];
  }
}
for(int i=1;i<=n;i++){
  for(int j=1;j<=n;j++){
    a[i][j]=a[i-1][j]+a[i][j];
  }
}
```

即我们先对每一行做前缀和，再对每一列做前缀和，容易发现这是正确的。显然，我们先对行还是先对列做前缀和对最终的答案是无影响的。类似的，我们可以这样求出三维前缀和：

```cpp
for(int i=1;i<=n;i++){
  for(int j=1;j<=n;j++){
    for(int k=1;k<=n;k++){
      a[i][j][k]+=a[i-1][j][k];
    }
  }
}
for(int i=1;i<=n;i++){
  for(int j=1;j<=n;j++){
    for(int k=1;k<=n;k++){
      a[i][j][k]+=a[i][j-1][k];
    }
  }
}
for(int i=1;i<=n;i++){
  for(int j=1;j<=n;j++){
    for(int k=1;k<=n;k++){
      a[i][j][k]+=a[i][j][k-1];
    }
  }
}
```
现在，我们有这么一个问题：

#quote[
有 $n$ 个互不相同元素，任取其中元素构成集合，容易证明共存在着 $2^n$ 个不同的集合。现在给集合 $T$ 赋一个权值 $a_T$，求解对 $2^n$ 种集合 $S$，分别求出 $sum_(T subset.eq S) a_T$ 的值。

$1 <= n <= 20$。
]
发现这道题目可以使用 $cal(O)(n^3)$ 的子集枚举轻松地解决，但是发现 $n$ 有点大，我们似乎无法完成，这时候该怎么办呢？

如果把一个集合用状压的思想压成一个二进制数，我们同样也可以把它转化成一个在更高维度的节点的坐标。这么讲有点抽象，举一个例子：
\
假如现在状压出的二进制数为 `0011010`，我们可以让他对应一个坐标，即 $(0,0,1,1,0,1,0)$，那么我们要求的答案实际上是这个坐标在七维空间下的前缀和，那么类似之前的二维、三维前缀和，我们可以写出以下代码：

```cpp
for(int i=0;i<n;i++){
  for(int j=0;j<(1<<n);j++){
    if(j&(1<<i))pre[j]+=pre[j&(1<<i)];
  }
}
```
对 $i$ 的枚举表示我们当前枚举到了哪一维，类似于三维前缀和的第一遍做、第二遍做、第三遍做。而对 $j$ 的枚举即对所有元素进行枚举，类似于之前对每一遍做前缀和的过程。而判断则是类似于在做前缀和的时候避免下标为 $-1$ 溢出。

通过前缀和的思想，我们就轻松地将这道题目优化到 $cal(O)(n 2^n)$。