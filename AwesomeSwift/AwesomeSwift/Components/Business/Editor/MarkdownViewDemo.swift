//
//  MarkdownViewDemo.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/28.
//

import Foundation
import SwiftUI
//import Ink

/// md 解析器
struct MarkdownViewDemo: View {
    var body: some View {
        VStack {
            MarkdownRenderView(md: MD_SAMPLE_TEXT)
        }
    }
}

#Preview {
    MarkdownViewDemo()
}

let MD_SAMPLE_TEXT = """
---
title: 欢迎使用言叶！
date: 2023-01-19 19:27:23
---
# 欢迎使用言叶！欢迎😊

![banner](https://meiyan.tech/rest/file/get/cloud_sync_made.png)

**嗨，朋友！欢迎使用言叶！**
**言叶是一款通过云同步多端协作的私人 Markdown 和笔记软件。它基于 Material 风格设计，支持多种主题，有丰富的功能和特性。** 下面，让我为你介绍言叶的功能。

## 1、作为笔记软件

☆ 言叶提供了**自动保存机制，绝不允许丢失**。
☆ 言叶是**真正属于自己的笔记软件**：用户可以通过云同步把笔记存储到私有云盘。
☆ 言叶允许将笔记**导出为 HTML、PDF、图片和文本**。
☆ 言叶提供了强大的搜索功能，允许关键字**全局搜索和高亮**。
☆ 言叶支持**图片笔记**来记录点滴生活，并提供了图片裁剪、变换和处理程序。
☆ 言叶提供了**桌面小控件、快捷方式等安卓特性**。

## 2、对 Markdown 的支持

测试一下

~~什么啊~~

卧槽

这个感觉还行

☆ 言叶支持 Markdown 全部语法，比如**加粗**、*倾斜*, [链接](https://meiyan.tech/note_home), ~~横划线~~ 和 `符号`。
☆ 此外，你可以在笔记中使用**内联的数学公式**：$C_n^2$, $\\vec a$, $\\overrightarrow{xy}$, $\\mathbb{A}$, $10^10+10^{10}$, $\\left(\\frac{x}{y}\right)$；
☆ 也可以使用下面这样的**块数学公式**，

$$\\begin{cases}
a_1x+b_1y+c_1z=d_1\\
a_2x+b_2y+c_2z=d_2\\
\\end{cases}
$$

☆ 言叶还允许用户在笔记中插入**表格**，

| 居左 | 居中 | 居右 |
|:------------ |:---------------:|-----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |
| zebra stripes | are neat        |    $1 |

☆ 你也可以在言叶中使用**列表和 TODO 事件**，比如，

- [ ] 任务事项
- [x] 任务事项（勾选）
- 普通的列表

☆ 言叶允许在笔记中插入**代码块**，

```Java
/** This is the Java code sample with highlight. */
public static void main(String[] args, int a, int b) {
    int c = cal(a, b);
    System.out.println(c);
}
```

或者**普通的文本块**，

```
使用两个 ``` 在文本中应用普通的文本块
```

    或者使用一个 tab 或者 4 个空格的形式使用普通的文本块
    如果需要在文本块内换行，可以在行后面追加 4 个空格来实现

☆ 你可以使用 `>` 来在文本中使用**引用**，

> 这是一个引用
> 这是一个换行的引用

☆ 如果普通的 markdown 标签无法满足你的需求，你还可以直接使用 **HTML**，比如下面的图片就是一个内嵌的 `<img>` 标签，

<div align="center">
<img src="https://meiyan.tech/rest/file/get/leaf_bg.jpg" style="height:200px">
</div>

☆ 言叶提供了多种**代码主题和编辑器主题**。
☆ 言叶支持通过**分类和标签**管理笔记。

## 3、多端协作

☆ 言叶支持 **WebDAV 同步**（后续会考虑支持其他网盘）。
☆ 言叶内置了**同步冲突解决机制**。
☆ 言叶基于相对路径设计，无需图床就可以在笔记中插入图片。

## 总结

**生命就是一种表达**。我们希望通过优雅的设计与强大的功能，为用户提供一个更好的笔记软件。敬请期待~
"""
