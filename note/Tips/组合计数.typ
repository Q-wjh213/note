#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Source Han Sans CN VF")
#import "@preview/cuti:0.2.1": show-cn-fakebold
#show: show-cn-fakebold

= 组合计数 Tips

+ 遇到对于一个序列/一些乱七八糟的东西进行多次操作，统计操作后不同的序列个数等问题，常见套路为：*不要去尝试对操作方式进行计数，而是转而对结果序列计数，考虑结果序列是否能通过若干次题目要求的操作得到。*