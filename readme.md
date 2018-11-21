# 前言

相信你已经用某种方式打开了本文档,那么有两件事值得你注意:

1. 如果你不是用vscode打开,那请用[vscode](https://code.visualstudio.com/ "vscode下载网站")重新打开,你会发现[另一片天地](software/vscode/0.catalog.md "vscode安装教程");

2. 本文档的主要目的是介绍**科研工具及其使用方法**,文档本着**共享**原则,用[Markdown](ProgramingLanguage/Markdown/0.catalog.md "Markdown语法")标记语言写成.如果你有新的需要补充的东西,请按照默认的[组织规则](#RulesofThis)加以补充.

# 目录 {#CatalogofAll}

## [System]

1. [Windows](system/windows/readme.md "windows系统说明")
1. [Linux(Ubuntu)](system/ubuntu/readme.md "windows系统说明")

## [Software]

1. [vscode](software/vscode/readme.md "vscode软件使用说明")
1. [adams](software/adams/readme.md "adams软件教程")
1. [ANSYS](software/ANSYS/readme.md "ANSYS软件教程")
1. [MATLAB](software/MATLAB/readme.md "MATLAB软件教程")
1. [ROS](software/ROS/0.catalog.md "ROS软件教程")***中级***

## [ProgramingLanguage]

1. [C++](ProgramingLanguage/cpp/readme.md "c++教程")
1. [Python](ProgramingLanguage/python/0.catalog.md "python教程")***面向对象高级编程***
1. [Markdown](ProgramingLanguage/markdown/readme.md "markdown教程")

# 文档组织规则 {#RulesofThis}
```sh
.                           # 本教程根目录
├── 0.introduction.md       # 本文档,包含本教程的说明和目录结构
├── category1               # 类别目录,初始划分为系统,软件,编程语言三种类别
│   ├── project1            # 项目目录,如系统下的windows系统
│   │   ├── 0.catalog.md    # 项目索引文件,为排序方便,使用 数字.文件名.文件类型名 的命名方式
│   │   └── ... 
│   │   └── readme.md       # 本项目的说明文档
│   ├── project2
│   │   ├── 0.catalog.md
│   │   └── readme.md
│   ├── ... 
│   └── readme.md
├── category2
│   ├── ... 
... │   ├── ... 
```
!!! :sunny:思考再三,起了一个低调的名字:smile::[202实验室科研工具手册](./0.introduction.md "机器人专业百科全书").