#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold

= 曼哈顿距离

设两个点坐标分别为 $(x_1,y_1),(x_2,y_2)$，则这两个点的曼哈顿距离为 $|x_1-x_2|+|y_1-y_2|$。

= 切比雪夫距离

设两个点的坐标分别为 $(x_1,y_1),(x_2,y_2)$，则这两个点的切比雪夫距离为 $max(|x_1-x_2|,|y_1-y_2|)$

#breakline

这两种距离看似没有什么关系，一个是横纵坐标差之和，一个是取较大值。但是，其实他们是可以相互转化的。下面给出结论：

若 $(x_1,y_1)$ 与 $(x_2,y_2)$ 的曼哈顿距离为 $x$，则 $(x_1+y_1,x_1-y_1)$ 和 $(x_2+y_2,x_2-y_2)$ 的切比雪夫距离仍为 $x$。证明是显然的，我们只需要对按照定义作差后比较就能发现两者相同。

我们可以认为切比雪夫坐标系实际上是曼哈顿坐标系旋转 $45 degree$ 后再扩大 $sqrt(2)$ 倍形成的。

*这两种距离常常可以相互转化，对于在考虑某种距离困难的时候，不妨思考另一种距离会不会简单一些。*