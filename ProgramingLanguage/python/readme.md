# Learn_Python
### 1. 基本操作
```bash
$ git init # 创建版本库
$ git add readme.txt # 添加文件到仓库
$ git commit -m "message" # 文件提交到仓库,-m后面是本次提交的说明
$ git status # 查看结果
$ git diff filename # 查看文件的不同
```
### 2. 版本控制
```bash
$ git log (--pretty=oneline) # 查看历史记录,后面参数可以减少信息输出
$ git reset --hard HEAD^ # 版本回退,hard参数会使HEAD版本之后的版本不可见
$ git reflog # 此记录可记录所有的操作,使文件重新回到新状态
$ git checkout -- file # 丢弃工作区的修改
```
1. 当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令`git checkout -- file`。
2. 当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令`git reset HEAD <file>`，就回到了场景1，第二步按场景1操作。
3. 已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退一节，不过前提是没有推送到远程库。
### 3. 删除
+ 一种情况要从版本库中删除该文件，那就用命令`git rm`删掉，并且`git commit`:
```bash
$ git rm test.txt
rm 'test.txt'

$ git commit -m "remove test.txt"
[master d46f35e] remove test.txt
 1 file changed, 1 deletion(-)
 delete mode 100644 test.txt
```
+ 另一种情况是删错了，因为版本库里还有呢，所以可以很轻松地把误删的文件恢复到最新版本：
```bash
$ git checkout -- test.txt
```
`git checkout`其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。
### 4. 远程仓库
在继续阅读后续内容前，请自行注册GitHub账号。由于你的本地Git仓库和GitHub仓库之间的传输是通过SSH加密的，所以，需要一点设置：
+ 第1步：创建SSH Key。在用户主目录下，看看有没有$.ssh$目录，如果有，再看看这个目录下有没有`id_rsa`和`id_rsa.pub`这两个文件，如果已经有了，可直接跳到下一步。如果没有，打开Shell（Windows下打开Git Bash），创建SSH Key：
    ```bash
    $ ssh-keygen -t rsa -C "youremail@example.com"
    ```
    你需要把邮件地址换成你自己的邮件地址，然后一路回车，使用默认值即可，由于这个Key也不是用于军事目的，所以也无需设置密码。
    如果一切顺利的话，可以在用户主目录里找到$.ssh$目录，里面有`id_rsa`和`id_rsa.pub`两个文件，这两个就是SSH Key的秘钥对，id_rsa是私钥，不能泄露出去，id_rsa.pub是公钥，可以放心地告诉任何人。
+ 第2步：登陆GitHub，打开“Account settings”，“SSH Keys”页面：
然后，点“Add SSH Key”，填上任意Title，在Key文本框里粘贴id_rsa.pub文件的内容：

    ![4](./1.python基础/assets/4)

    点“Add Key”，你就应该看到已经添加的Key：

    ![5](./1.python基础/assets/5)

    为什么GitHub需要SSH Key呢？因为GitHub需要识别出你推送的提交确实是你推送的，而不是别人冒充的，而Git支持SSH协议，所以，GitHub只要知道了你的公钥，就可以确认只有你自己才能推送。
    当然，GitHub允许你添加多个Key。假定你有若干电脑，你一会儿在公司提交，一会儿在家里提交，只要把每台电脑的Key都添加到GitHub，就可以在每台电脑上往GitHub推送了。
    最后友情提示，在GitHub上免费托管的Git仓库，任何人都可以看到喔（但只有你自己才能改）。所以，不要把敏感信息放进去。
    如果你不想让别人看到Git库，有两个办法，一个是交点保护费，让GitHub把公开的仓库变成私有的，这样别人就看不见了（不可读更不可写）。另一个办法是自己动手，搭一个Git服务器，因为是你自己的Git服务器，所以别人也是看不见的。这个方法我们后面会讲到的，相当简单，公司内部开发必备。
    确保你拥有一个GitHub账号后，我们就即将开始远程仓库的学习。
+ 首次提交
    ```bash
    $ git config --global user.email "zhengpenglong111@hotmail.com"
    $ git config --global user.name "zapplelove"
    $ git add readme.md 1.python基础/*
    $ git commit -m "first commit"
    $ git remote add origin https://github.com/zapplelove/Learn_Python.git
    $ git push -u origin master
    ```
以后的提交都可以通过`git push origin master`来进行.
### 5. 远程仓库克隆
```bash
$ git clone git@github.com:michaelliao/gitskills.git
```
### 6. 分支管理
首先，我们创建dev分支，然后切换到dev分支：
```bash
$ git checkout -b dev
Switched to a new branch 'dev'
```
`git checkout`命令加上`-b`参数表示创建并切换，相当于以下两条命令：
```bash
$ git branch dev
$ git checkout dev
Switched to branch 'dev'
```
然后，用`git branch`命令查看当前分支：
```bash
$ git branch
* dev
  master
```
`git branch`命令会列出所有分支，当前分支前面会标一个*号。

然后，我们就可以在dev分支上正常提交，比如对readme.txt做个修改，加上一行：
```
Creating a new branch is quick.
```
然后提交：
```bash
$ git add readme.txt 
$ git commit -m "branch test"
[dev b17d20e] branch test
 1 file changed, 1 insertion(+)
```
现在，dev分支的工作完成，我们就可以切换回master分支：
```bash
$ git checkout master
Switched to branch 'master'
```
切换回master分支后，再查看一个readme.txt文件，刚才添加的内容不见了！因为那个提交是在dev分支上，而master分支此刻的提交点并没有变：
现在，我们把dev分支的工作成果合并到master分支上：
```bash
$ git merge dev
Updating d46f35e..b17d20e
Fast-forward
 readme.txt | 1 +
 1 file changed, 1 insertion(+)
```
`git merge`命令用于合并指定分支到当前分支。合并后，再查看readme.txt的内容，就可以看到，和dev分支的最新提交是完全一样的。

注意到上面的Fast-forward信息，Git告诉我们，这次合并是“快进模式”，也就是直接把master指向dev的当前提交，所以合并速度非常快。

当然，也不是每次合并都能Fast-forward，我们后面会讲其他方式的合并。

合并完成后，就可以放心地删除dev分支了：
```bash
$ git branch -d dev
Deleted branch dev (was b17d20e).
```
删除后，查看branch，就只剩下master分支了：
```bash
$ git branch
* master
```
因为创建、合并和删除分支非常快，所以Git鼓励你使用分支完成某个任务，合并后再删掉分支，这和直接在master分支上工作效果是一样的，但过程更安全。
`git log --graph`命令可以看到分支合并图。