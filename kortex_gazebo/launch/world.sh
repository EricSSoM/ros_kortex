#!/usr/bin/bash
# creates wrold for gazebo simulator where purple ball is at position <x y z t>
pushd "$HOME/catkin_ws/src/ros_kortex/kortex_gazebo/worlds"
sh gazebo_hexa.sh $1 $2 $3 $4 | xargs -l bash -c 'sed -e "s+@x+$0+g" -e "s+@y+$1+g" -e "s+@z+$2+g" -e "s+@w+0.84+g" -e "s+@t+$3+g" black_room_xy.sed > black_room_xy.xacro'
xacro black_room_xy.xacro > black_room_xy.sdf
sed -e 's+<world+<sdf version="1.4"> <world+g' -e 's+/world>+/world> </sdf>+g' black_room_xy.sdf > black_room_xy.world
popd
