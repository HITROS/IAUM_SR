#! /bin/bash
# 本bash文件可以自动生成多cpp文件的工程项目,配合vscode插件code-runner和C/C++使用
# 对vscode的配置:
# "code-runner.executorMap": {
#        "cpp": "cd $dir && cd .. && make && cd ./Output/bin && ./main && cd ../../"
#    },

# 输入一个文件名 $projectname
echo "请输入工程名:"
read projectname

# 添加前缀
filename="VSC_CPP_"$projectname

# 源文件目录
Src="$filename/Sources"

# 头文件目录
Inc="$filename/Headers"

# vscode用户目录
vscode="$filename/.vscode"

# 创建项目树
mkdir -p $Src $Inc $filename/Output/bin $vscode

# 创建makefile文件
touch $filename/makefile

# 创建调试配置文件
touch $vscode/launch.json

# 创建 main.cpp文件
touch $Src/main.cpp

# 文件名小写转换
#declare -l lfilename=$projectname
lfilename="${projectname,,}"

# 源文件
cpp_file=$Src"/"${lfilename}".cpp"
# 头文件
hpp_file=$Inc"/"${lfilename}".hpp"

# 创建一对项目文件
touch $cpp_file $hpp_file

# 向main.cpp中写入内容
echo "#include <iostream> " >> $Src/main.cpp
echo "#include \"$lfilename.hpp\"" >> $Src/main.cpp
echo "" >> $Src/main.cpp
echo "using namespace std;" >> $Src/main.cpp
echo "" >> $Src/main.cpp
echo "int main()" >> $Src/main.cpp
echo "{" >> $Src/main.cpp
echo "    cout << \"Hello VSC\" << endl;" >> $Src/main.cpp
echo "    return 0;" >> $Src/main.cpp
echo "}" >> $Src/main.cpp

# 向*.hpp中写入内容
echo "#pragma once" >> $Inc/$lfilename.hpp
echo "#include <iostream>" >> $Inc/$lfilename.hpp
echo "using namespace std;" >> $Inc/$lfilename.hpp
echo "" >> $Inc/$lfilename.hpp
echo "class $projectname" >> $Inc/$lfilename.hpp
echo "{" >> $Inc/$lfilename.hpp
echo "public:" >> $Inc/$lfilename.hpp
echo "    $projectname();" >> $Inc/$lfilename.hpp
# echo "    $projectname($projectname &&) = default;" >> $Inc/$lfilename.hpp
# echo "    $projectname(const $projectname &) = default;" >> $Inc/$lfilename.hpp
# echo "    $projectname &operator=($projectname &&) = default;" >> $Inc/$lfilename.hpp
# echo "    $projectname &operator=(const $projectname &) = default;" >> $Inc/$lfilename.hpp
echo "    ~$projectname();" >> $Inc/$lfilename.hpp
echo "" >> $Inc/$lfilename.hpp
echo "protected:" >> $Inc/$lfilename.hpp
echo "" >> $Inc/$lfilename.hpp
echo "private:" >> $Inc/$lfilename.hpp
echo "" >> $Inc/$lfilename.hpp
echo "};" >> $Inc/$lfilename.hpp

# 向*.cpp中写入内容
echo "#include \"$lfilename.hpp\"" >> $Src/$lfilename.cpp
echo "" >> $Src/$lfilename.cpp
echo "$projectname::$projectname()" >> $Src/$lfilename.cpp
echo "{" >> $Src/$lfilename.cpp
echo "}" >> $Src/$lfilename.cpp
echo "" >> $Src/$lfilename.cpp
echo "$projectname::~$projectname()" >> $Src/$lfilename.cpp
echo "{" >> $Src/$lfilename.cpp
echo "}" >> $Src/$lfilename.cpp

# 导入makefile
# cat "./makefile" >> $filename/makefile
echo "# 描述： C++ 项目 makefile文件" >> $filename/makefile
echo "# 版本： v3.0" >> $filename/makefile
echo "# 修改记录:  1.先测试普通的cpp文件的编译运行" >> $filename/makefile
echo "#		    2.使用变量来改进我们的makefile文件" >> $filename/makefile
echo "#			3.新加了一个源文件" >> $filename/makefile
echo "#			4.使用伪目标，加上clean规则" >> $filename/makefile
echo "#			5.使用wildcard函数，自动扫描当前目录下的源文件" >> $filename/makefile
echo "#			6.加入了自动规则依赖" >> $filename/makefile
echo "#			7.改变依赖关系的生成模式" >> $filename/makefile
echo "#			8.提供多目录文件编译" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 头文件存放目录" >> $filename/makefile
echo "INC_DIR=./Headers" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 可执行文件存放目录" >> $filename/makefile
echo "BIN_DIR=./Output/bin" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 源文件存放目录" >> $filename/makefile
echo "SRC_DIR=./Sources" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 其它中间文件存放目录" >> $filename/makefile
echo "OBJ_DIR=./Output" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 源文件列表" >> $filename/makefile
echo "SRC	:= \${wildcard \${SRC_DIR}/*.cpp}" >> $filename/makefile
echo "" >> $filename/makefile
echo "# obj文件列表" >> $filename/makefile
echo "OBJ	:= \${patsubst %.cpp, \$(OBJ_DIR)/%.o, \${notdir \${SRC}}}" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 定义编译命令变量" >> $filename/makefile
echo "CC	:= g++" >> $filename/makefile
echo "RM	:= rm -rf" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 定义可执行文件变量" >> $filename/makefile
echo "executable	:= main" >> $filename/makefile
echo "BIN_TARGET=\${BIN_DIR}/\${executable}" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 终极目标规则：生成可执行文件" >> $filename/makefile
echo "\${BIN_TARGET}:\${OBJ}" >> $filename/makefile
echo "	\${CC} \${OBJ} -o \$@" >> $filename/makefile
echo "" >> $filename/makefile
echo "# 子目标规则：生成链接文件" >> $filename/makefile
echo "# g++ -c 编译,汇编到目标代码,不进行链接" >> $filename/makefile
echo "# g++ -g 生成调试信息,此处是后面代码调试的关键" >> $filename/makefile
echo "\${OBJ_DIR}/%.o:\${SRC_DIR}/%.cpp" >> $filename/makefile
echo "	\${CC} -o \$@ -g -c $< -I\${INC_DIR}" >> $filename/makefile
echo "" >> $filename/makefile
echo "#clean规则" >> $filename/makefile
echo "#.PHONY: clean" >> $filename/makefile
echo "clean:" >> $filename/makefile
echo "#清除编译生成的所有文件" >> $filename/makefile
echo "	\$(RM) \$(BIN_TARGET) \$(OBJ_DIR)/*.o" >> $filename/makefile
echo "#清除编译生成的所有文件,不包括可执行文件" >> $filename/makefile
echo "	\$(RM) \$(OBJ_DIR)/*.o" >> $filename/makefile
# 向配置文件写入命令
echo "{" >> $vscode/launch.json
echo "    // 使用 IntelliSense 了解相关属性。 " >> $vscode/launch.json
echo "    // 悬停以查看现有属性的描述。" >> $vscode/launch.json
echo "    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387" >> $vscode/launch.json
echo "    \"version\": \"0.2.0\"," >> $vscode/launch.json
echo "    \"configurations\": [" >> $vscode/launch.json
echo "        {" >> $vscode/launch.json
echo "            \"name\": \"(gdb) Launch\"," >> $vscode/launch.json
echo "            \"type\": \"cppdbg\"," >> $vscode/launch.json
echo "            \"request\": \"launch\"," >> $vscode/launch.json
echo "            \"program\": \"\${workspaceFolder}/Output/bin/main\"," >> $vscode/launch.json
echo "            \"args\": []," >> $vscode/launch.json
echo "            \"stopAtEntry\": false," >> $vscode/launch.json
echo "            \"cwd\": \"\${workspaceFolder}\"," >> $vscode/launch.json
echo "            \"environment\": []," >> $vscode/launch.json
echo "            \"externalConsole\": true," >> $vscode/launch.json
echo "            \"MIMode\": \"gdb\"," >> $vscode/launch.json
echo "            \"setupCommands\": [" >> $vscode/launch.json
echo "                {" >> $vscode/launch.json
echo "                    \"description\": \"Enable pretty-printing for gdb\"," >> $vscode/launch.json
echo "                    \"text\": \"-enable-pretty-printing\"," >> $vscode/launch.json
echo "                    \"ignoreFailures\": true" >> $vscode/launch.json
echo "                }" >> $vscode/launch.json
echo "            ]" >> $vscode/launch.json
echo "        }" >> $vscode/launch.json
echo "    ]" >> $vscode/launch.json
echo "}" >> $vscode/launch.json