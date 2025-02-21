#import "/book.typ": book-page
#show: book-page.with()
#import "/css.typ": *
#set par(leading: 1.25em,spacing: 1.75em)
#set text(font:"Microsoft YaHei",lang:"zh")
= pb_ds&rope: C++ 中强大的扩展库

pb_ds 中内封装了多种强大的数据结构，虽然效率可能并不算很高，但是若在有些时候知道怎么用或许可以解燃眉之急。

= 导入

pb_ds&rope 存在万能头，只需要使用 ```cpp  #include <bits/extc++.h>``` 即可。

pb_ds 中的内容处于命名空间 `__gnu_pbds` 内。

= 哈希表
在 pb_ds 中，封装了 hash_table。这种哈希表相较于 unordered_map 速度更加快，效率更高，更难被卡。

通常在 pb_ds 中常用的哈希表为 gp_hash_table,我们可以通过以下代码创建：
```cpp
// 以下 T1,T2 代表两种类型。
#include<bits/stdc++.h>
__gnu_pbds::gp_hash_table <T1, T2> H1;
```
不难发现其构建方式类似于 `map` 和 `unordered_map`。

#quote()[
  + 相比于 unordered_map，其速度更快。
  + 空间复杂度略大于 unordered_map。
]

todo：自定义哈希函数
233

