ros-install-osx   
===============
Source: 
https://github.com/mikepurvis/ros-install-osx
http://wiki.ros.org/kinetic/Installation/OSX/Homebrew/Source

在MacOS上安装ROS（以源码的方式），你需要的知识：
1.C++, C++库
2.Python，Pip Install
3.Catkin_make/Cmake
4.Homebrew的操作
5.简单的Ruby（不重要）

特别建议：采用一个Clean的电脑，不从官网下载Python（或者卸载除了系统内的python之外的所有版本）。
如果有Homebrew，建议卸载后-rm rf然后重新安装homebrew。
建议安装版本：MacOS 10.12 / 10.13
Melodic: Mac 10.14

在安装中你可能会遇到的问题：
1.包的版本不对，例如python，opencv，sip等。
2.C++11,14等版本的库文件的问题。

建议：如果出错的是不重要，不必要的包，把src中的源文件删去，节省时间。

Usage
-----

```shell
git clone https://github.com/mikepurvis/ros-install-osx.git
cd ros-install-osx
./install
```

注：Mikepurvis提供的是Melodic的版本。
如果要更改版本，请用IDE打开.install文件，将版本从-melodic改为-kinetic或者-indigo、-lunar等等。
建议把脚本文件仔细看一遍。

如果Xquartz（一个在Mac中运行Unix界面窗口的开源软件，由于Apple从前几个版本更改了界面，Mac的界面已经独立出传统的Unix）没有安装，
你会在安装这个软件之后被强迫 log out and in ，然后你需要re-run安装脚本。

请将--skip-keys xxxxx之后，再添加一条--skip-keys google-mock

你需要sudo（输入你的密码），在以下环节：

   - Homebrew installation.
   - Caskroom installation.
   - XQuartz installation.
   - Initializing rosdep.
   - Creating and chowning your `/opt/ros/[distro]` folder.


Step by Step
------------

如果有build fail， 你可以继续从fail的包中进行，在src的上层文件夹，也就是catkin_make的文件夹，运行：

    catkin build --start-with rviz（build fail的包）

或者从头进行catkin build（建议）。（运行脚本中catkin build那一行）


## Troubleshooting

### OpenCV3

 最近一次发现的问题，opencv3又更新了一次。如果采用默认的opencv，会出现cv_bridge build fail的问题。
 请安装opencv3.4.3_2版本。
 使用brew uninstall /brew unlink /brew force link...

### ROS Control
 一个重要的问题，似乎Ros下载时没有ros control的库文件。
 需要你下载ros_control的包，请：

cd CATKIN_WORKSPACE/src
wstool init
wstool merge https://raw.github.com/ros-controls/ros_control/kinetic-devel/ros_control.rosinstall
wstool update
cd ..
rosdep install --from-paths . --ignore-src --rosdistro kinetic -y

似乎Gazebo_Ros中的gazebo_ros_control包也没有，需要去github上下载这个包，同下。
rosdep初始化的时候，会搜索需要的包，此时可能会出现不了这些包的问题（因为是在mac中，不是ubuntu）。
解决办法：百度terminal中提示的包，然后下载src文件，然后重复rosdep install这一步，直到初始化成功。
将所有的src的包复制到安装脚本的src文件夹下。


### Boost uint32_t
Boost库文件会出现位数的问题，将每一个调用的函数的变量前都加上 uint32_t()可解决这个问题。

return pt::from_time_t(sec) + pt::microseconds(nsec/1000.0);
change to:
return pt::from_time_t(sec) + pt::microseconds(uint32_t(nsec/1000.0));

已知的有：
roscpp_core uint32 fixes:
roscpp_core/rostime/include/impl/duration.h
roscpp_core/rostime/include/impl/time.h

bondcpp uint32 fix:
bond_core/bondcpp/src/bond.cpp

actionlib uint32 fixes:
actionlib/src/connection_monitor.cpp
actionlib/include/actionlib/destruction_guard.h
actionlib/include/actionlib/server/simple_action_server_imp.h
actionlib/include/actionlib/client/simple_action_client.h

laser_assembler uint32 fixes:
laser_assembler/test/test_assembler.cpp

### cv_bridge and camera_calibration_parsers

替换CmakeLists.txt,
https://github.com/ros-perception/vision_opencv/pull/239
https://github.com/ros-perception/image_common/pull/85


### tf2

模仿
https://github.com/ros/geometry2/pull/279
更改调用的子函数名。

End
------------
由于版本的更新，可能会出现很多build的bug，建议没有必要，不要更新库文件。

俊屹 2019.01