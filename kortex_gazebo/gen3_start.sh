#!/usr/bin/env sh
rostopic pub -1 /my_gen3/joint_1_position_controller/command std_msgs/Float64 0 &
rostopic pub -1 /my_gen3/joint_2_position_controller/command std_msgs/Float64 1.75 &
rostopic pub -1 /my_gen3/joint_3_position_controller/command std_msgs/Float64 0.0 &
rostopic pub -1 /my_gen3/joint_4_position_controller/command std_msgs/Float64 5.7 &
rostopic pub -1 /my_gen3/joint_5_position_controller/command std_msgs/Float64 3.1416 &
rostopic pub -1 /my_gen3/joint_6_position_controller/command std_msgs/Float64 0.85 &
rostopic pub -1 /my_gen3/joint_7_position_controller/command std_msgs/Float64 4.15 &
rostopic pub -1 /my_gen3/finger_tip_1_position_controller/command std_msgs/Float64 2 &
rostopic pub -1 /my_gen3/finger_tip_2_position_controller/command std_msgs/Float64 0.5 &
rostopic pub -1 /my_gen3/finger_tip_3_position_controller/command std_msgs/Float64 0.5 &
rostopic pub -1 /my_gen3/finger_1_position_controller/command std_msgs/Float64 1.5 &
rostopic pub -1 /my_gen3/finger_2_position_controller/command std_msgs/Float64 0 &
rostopic pub -1 /my_gen3/finger_3_position_controller/command std_msgs/Float64 0
