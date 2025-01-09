#!/usr/bin/env sh
rostopic pub -1 /my_gen3/joint_1_position_controller/command std_msgs/Float64 "data: $1" &
rostopic pub -1 /my_gen3/joint_2_position_controller/command std_msgs/Float64 "data: 0.0" &
rostopic pub -1 /my_gen3/joint_3_position_controller/command std_msgs/Float64 "data: 3.14159" &
rostopic pub -1 /my_gen3/joint_4_position_controller/command std_msgs/Float64 "data: $3" &
rostopic pub -1 /my_gen3/joint_5_position_controller/command std_msgs/Float64 "data: $4" &
rostopic pub -1 /my_gen3/joint_6_position_controller/command std_msgs/Float64 "data: $5" &
rostopic pub -1 /my_gen3/joint_7_position_controller/command std_msgs/Float64 "data: $6" &
sleep 5; rostopic pub -1 /my_gen3/joint_2_position_controller/command std_msgs/Float64 "data: $2" &
sleep 4
