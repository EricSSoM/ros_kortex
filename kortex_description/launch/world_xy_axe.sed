<?xml version="1.0"?>

<robot xmlns:xacro="http://www.ros.org/wiki/xacro" >

  <!-- Replace @x\4 and @y\7 with the hexagon position of target arm head is the following sed command and run it:
      sed -e 's\@x\4\g' -e 's\@y\7\g' model_arm_camera_xy.sed > model_arm_camera_xy.xacro -->

    <xacro:macro name="model_kinova" params="reach">

    <!-- divide floor into 4 tiles so that it doesn't touch the base of the arm (and create collision) -->
    <link name="floor1">
      <inertial>
        <mass value="1.0" />
        <!--origin xyz="2.48 2.52 0.01" /-->
        <origin xyz="0 0 -2" />
        <!--inertia ixx="1.0" ixy="0.0" ixz="0.0" iyy="1.0" iyz="0.0" izz="1.0" /-->
        <inertia ixx="1.0" ixy="1.0" ixz="1.0" iyy="1.0" iyz="1.0" izz="1.0" />
      </inertial>
      <visual name="floor1">
        <origin xyz="0 0 -2" />
        <geometry> <box size="20 20 0.01" /> </geometry>
        <!--material name="Black"> <color rgba="0.0 0.0 0.0 1.0"/> </material-->
      </visual>
    </link>
    <joint name="floor1_world" type="fixed">
        <parent link="world"/>
        <child link="floor1"/>
        <origin xyz="0 0 -2" />
    </joint>
    <gazebo reference="floor1">
      <material>Gazebo/Black</material>
    </gazebo>

    <link name="wall1">
      <inertial>
        <mass value="1.0" />
        <origin xyz="9.9 0 0" rpy="0 1.5708 0"/>
        <geometry> <box size="8 20 0.01" /> </geometry>
        <inertia ixx="1.0" ixy="1.0" ixz="1.0" iyy="1.0" iyz="1.0" izz="1.0" />
      </inertial>
      <visual name="wall1">
        <origin xyz="9.9 0 0" rpy="0 1.5708 0"/>
        <geometry> <box size="8 20 0.01"/> </geometry>
      </visual>
    </link>
    <joint name="wall1_world" type="fixed">
        <parent link="world"/>
        <child link="wall1"/>
        <origin xyz="0 0 0.01" rpy="0 0 0"/>
    </joint>
    <gazebo reference="wall1">
      <material>Gazebo/Black</material>
    </gazebo>
    
    <link name="wall2">
      <inertial>
        <mass value="1.0" />
        <origin xyz="-9.9 0 0" rpy="0 1.5708 0"/>
        <geometry> <box size="8 20 0.01" /> </geometry>
        <inertia ixx="1.0" ixy="1.0" ixz="1.0" iyy="1.0" iyz="1.0" izz="1.0" />
      </inertial>
      <visual name="wall2">
        <origin xyz="-9.9 0 0" rpy="0 1.5708 0"/>
        <geometry> <box size="8 20 0.01"/> </geometry>
      </visual>
    </link>
    <joint name="wall2_world" type="fixed">
        <parent link="world"/>
        <child link="wall2"/>
        <origin xyz="0 0 0.01" rpy="0 0 0"/>
    </joint>
    <gazebo reference="wall2">
      <material>Gazebo/Black</material>
    </gazebo>

    <link name="wall3">
      <inertial>
        <mass value="1.0" />
        <origin xyz="0 9.9 0" rpy="0 1.5708 1.5708"/>
        <geometry> <box size="8 20 0.01" /> </geometry>
        <inertia ixx="1.0" ixy="1.0" ixz="1.0" iyy="1.0" iyz="1.0" izz="1.0" />
      </inertial>
      <visual name="wall3">
        <origin xyz="0 9.9 0" rpy="0 1.5708 1.5708"/>
        <geometry> <box size="8 20 0.01"/> </geometry>
      </visual>
    </link>
    <joint name="wall3_world" type="fixed">
        <parent link="world"/>
        <child link="wall3"/>
        <origin xyz="0 0 0.01" rpy="0 0 0"/>
    </joint>
    <gazebo reference="wall3">
      <material>Gazebo/Black</material>
    </gazebo>

    <link name="wall4">
      <inertial>
        <mass value="1.0" />
        <origin xyz="0 -9.9 0" rpy="0 1.5708 1.5708"/>
        <geometry> <box size="8 20 0.01" /> </geometry>
        <inertia ixx="1.0" ixy="1.0" ixz="1.0" iyy="1.0" iyz="1.0" izz="1.0" />
      </inertial>
      <visual name="wall4">
        <origin xyz="0 -9.9 0" rpy="0 1.5708 1.5708"/>
        <geometry> <box size="8 20 0.01"/> </geometry>
      </visual>
    </link>
    <joint name="wall4_world" type="fixed">
        <parent link="world"/>
        <child link="wall4"/>
        <origin xyz="0 0 0.01" rpy="0 0 0"/>
    </joint>
    <gazebo reference="wall4">
      <material>Gazebo/Black</material>
    </gazebo>

    <xacro:property name="r" value="${reach/7.0}"/>
    <xacro:property name="a" value="${r/2.0}"/>    
    <xacro:property name="size" value="${r/1.7321}"/>
    <xacro:property name="size_side" value="${r/3.4642+0.01}"/>
    <xacro:property name="xreach" value="${reach-size/2.0}"/>
    <xacro:property name="yreach" value="${size*1.5}"/>
    <xacro:property name="offset" value="${0.02}"/>

    <xacro:macro name="hexa" params="hexa_name color_name x y rx ry rz geo">
      <link name="${hexa_name}">
        <static>true</static>
        <!--inertial> <mass value="1.0" /> <inertia ixx="1.0" ixy="0.0" ixz="0.0" iyy="1.0" iyz="0.0" izz="1.0" /> </inertial-->
        <inertial> <mass value="1.0" /> <inertia ixx="1000.0" ixy="0.0" ixz="0.0" iyy="1000.0" iyz="0.0" izz="1000.0" /> </inertial>
        <visual name="${hexa_name}">
          <!--origin xyz="${x-0.05} ${y} ${size/2.0+size/20.0+0.02}" rpy="0 0 ${rz}"/-->
          <origin xyz="${x+offset} ${y} ${size_side/2.0+size_side/20.0+0.06}" rpy="${rx} ${ry} ${rz}"/>
          <xacro:if value="${geo == 'box'}">
            <geometry> <box size="${size_side/1.5} 0.001 ${size_side/1.5}"/> </geometry>
          </xacro:if>
          <xacro:if value="${geo == 'box2'}">
            <geometry> <box size="${size_side/1.5} 0.001 ${size_side/1.5}"/> </geometry>
          </xacro:if>
          <xacro:if value="${geo == 'circle'}">
            <geometry> <cylinder radius="${size_side/3}" length="0.001" /> </geometry>
          </xacro:if>
          <xacro:if value="${geo == 'star'}">
            <geometry> <box size="${size_side/1.5} 0.001 ${size_side/1.5}"/> </geometry>
          </xacro:if>
          <diffuse>0.3 0.3 0.3</diffuse>v
          <specular>0.3 0.3 0.3</specular>
        </visual>
        <xacro:if value="${geo == 'box2'}">
          <visual name="${hexa_name}_box2">
            <origin xyz="${x+offset} ${y} ${size_side/2.0+size_side/20.0+0.06}" rpy="${rx} ${ry+0.7854} ${rz}"/>
            <geometry> <box size="${size_side/1.5} 0.001 ${size_side/1.5}"/> </geometry>
            <diffuse>0.3 0.3 0.3</diffuse>v
            <specular>0.3 0.3 0.3</specular>
          </visual>
        </xacro:if>
        <xacro:if value="${geo == 'star'}">
          <visual name="${hexa_name}_star">
            <origin xyz="${x+offset} ${y} ${size_side/2.0+size_side/20.0+0.06}" rpy="1.5708 0.0 ${rz}"/>
            <geometry> <cylinder radius="${size_side/2.6}" length="0.001" /> </geometry>
            <diffuse>0.3 0.3 0.3</diffuse>v
            <specular>0.3 0.3 0.3</specular>
          </visual>
        </xacro:if>
      </link>
      <joint name="${hexa_name}_world" type="fixed">
        <parent link="world"/>
        <child link="${hexa_name}"/>
      </joint>
      <gazebo reference="${hexa_name}">
        <mu1>10</mu1>
        <mu2>10</mu2>
        <turnGravityOff>true</turnGravityOff>
        <material value="Gazebo/${color_name}"/>
      </gazebo>
    </xacro:macro>

    <xacro:macro name="hexa_top" params="hexa_name x y rz">
      <link name="${hexa_name}">
      <inertial> <mass value="1.0" /> <inertia ixx="1.0" ixy="0.0" ixz="0.0" iyy="1.0" iyz="0.0" izz="1.0" /> </inertial>
      <visual name="${hexa_name}">
        <!--origin xyz="${x-0.05} ${y} ${size/2+size/20+0.02}" rpy="0 0 ${rz}"/-->
        <origin xyz="${x+offset} ${y} ${size/2+size/20+0.02}" rpy="0 0 ${rz}"/>
        <geometry> <box size="${size-0.001} ${size-0.001} ${2.0*size}"/> </geometry>
        <diffuse>0.3 0.3 0.3</diffuse>
        <specular>0.3 0.3 0.3</specular>
      </visual>
    </link>
    <joint name="${hexa_name}_world" type="fixed">
        <parent link="world"/>
        <child link="${hexa_name}"/>
    </joint>
    <gazebo reference="${hexa_name}">
      <mu1>10</mu1>
      <mu2>10</mu2>
      <turnGravityOff>true</turnGravityOff>
      <!-- put white to see hexas material value="Gazebo/White"/-->
      <material value="Gazebo/Black"/>
    </gazebo>
    </xacro:macro>

    <!-- google gazebo media materials scripts for colors -->

    <xacro:macro name="hexagon" params="h_name x y col1:='Black' col2:='Black' col3:='Black' col4:='Black' col5:='Black' col6:='Black' rx:='0' ry:='0' geo:='box'">
      <xacro:hexa hexa_name="${h_name}_1" color_name="${col1}" x="${x}" y="${y}" rx="${rx}" ry="${ry}" rz="1.5709" geo="${geo}"></xacro:hexa>
      <xacro:hexa hexa_name="${h_name}_2" color_name="${col2}" x="${x+a/2.0}" y="${y+0.75*size}" rx="${rx}" ry="${ry}" rz="0.5236" geo="${geo}"></xacro:hexa>
      <xacro:hexa hexa_name="${h_name}_3" color_name="${col6}" x="${x+a/2.0}" y="${y-0.75*size}" rx="${rx}" ry="${ry}" rz="-0.5236" geo="${geo}"></xacro:hexa>
      <xacro:hexa hexa_name="${h_name}_4" color_name="${col3}" x="${x+r*0.75}" y="${y+0.75*size}" rx="${rx}" ry="${ry}" rz="-0.5236" geo="${geo}"></xacro:hexa>
      <xacro:hexa hexa_name="${h_name}_5" color_name="${col5}" x="${x+r*0.75}" y="${y-0.75*size}" rx="${rx}" ry="${ry}" rz="0.5236" geo="${geo}"></xacro:hexa>
      <xacro:hexa hexa_name="${h_name}_6" color_name="${col4}" x="${x+r}" y="${y}" rx="${rx}" ry="${ry}" rz="1.5709" geo="${geo}"></xacro:hexa>

      <xacro:hexa_top hexa_name="${h_name}_Top_1" x="${x+size/2.0}" y="${y}" rz="1.5709"></xacro:hexa_top>
      <xacro:hexa_top hexa_name="${h_name}_Top_2" x="${x+a/2.0+size/4.0}" y="${y+0.75*size-size/2.0*0.866}" rz="0.5236"></xacro:hexa_top>
      <xacro:hexa_top hexa_name="${h_name}_Top_3" x="${x+a/2.0+size/4.0}" y="${y-0.75*size+size/2.0*0.866}" rz="-0.5236"></xacro:hexa_top>
      <xacro:hexa_top hexa_name="${h_name}_Top_4" x="${x+r*0.75-size/4.0}" y="${y+0.75*size-size/2.0*0.866}" rz="-0.5236"></xacro:hexa_top>
      <xacro:hexa_top hexa_name="${h_name}_Top_5" x="${x+r*0.75-size/4.0}" y="${y-0.75*size+size/2.0*0.866}" rz="0.5236"></xacro:hexa_top>
      <xacro:hexa_top hexa_name="${h_name}_Top_6" x="${x+r-size/2.0}" y="${y}" rz="1.5709"></xacro:hexa_top>
    </xacro:macro>

    // Put hexagon on base:
    <xacro:hexagon h_name="h0" x="${-size-0.015}" y= "0.0" col4="Purple" col5="Purple" col6="Purple" col1="Purple" col2="Purple" col3="Purple" rx="1.5708" ry="0" geo="circle"/>

    // colors
    // col1="Red" col2="Yellow" col3="Green" col4="Turquoise" col5="Blue" col6="Purple"

    <!--xacro:property name="xhexa" value="${r * (7.0 - @x) - 0.19 * r}"/>
    <xacro:property name="yhexa" value="${yreach * (7.0 - @y)}"/-->
    <xacro:property name="xhexa" value="${r * (@x) / 10.0 - 0.19 * r}"/>
    <xacro:property name="yhexa" value="${yreach * (@y) / 10.0}"/>

    
    <xacro:hexagon h_name="hh1"  x="${xhexa+a*7.0}" y="${yhexa}"            col1="Purple"                     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh2"  x="${xhexa+a*6.0}" y="${yhexa-yreach}"     col1="Turquoise" col2="Blue"      rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh3"  x="${xhexa+a*5.0}" y="${yhexa-yreach*2.0}" col1="Yellow"    col2="Green"     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh4"  x="${xhexa+a*4.0}" y="${yhexa-yreach*3.0}" col1="Orange"    col2="Red"       rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh5"  x="${xhexa+a*3.0}" y="${yhexa-yreach*4.0}" col2="Purple"                     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh6"  x="${xhexa+a*1.0}" y="${yhexa-yreach*4.0}" col2="Turquoise" col3="Blue"      rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh7"  x="${xhexa-a*1.0}" y="${yhexa-yreach*4.0}" col2="Yellow"    col3="Green"     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh8"  x="${xhexa-a*3.0}" y="${yhexa-yreach*4.0}" col2="Orange"    col3="Red"       rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh9"  x="${xhexa-a*5.0}" y="${yhexa-yreach*4.0}" col3="Purple"                     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh10" x="${xhexa-a*6.0}" y="${yhexa-yreach*3.0}" col3="Turquoise" col4="Blue"      rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh11" x="${xhexa-a*7.0}" y="${yhexa-yreach*2.0}" col3="Yellow"    col4="Green"     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh12" x="${xhexa-a*8.0}" y="${yhexa-yreach}"     col3="Orange"    col4="Red"       rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh13" x="${xhexa-a*9.0}" y="${yhexa}"            col4="Purple"                     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh14" x="${xhexa-a*8.0}" y="${yhexa+yreach}"     col4="Turquoise" col5="Blue"      rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh15" x="${xhexa-a*7.0}" y="${yhexa+yreach*2.0}" col4="Yellow"    col5="Green"     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh16" x="${xhexa-a*6.0}" y="${yhexa+yreach*3.0}" col4="Orange"    col5="Red"       rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh17" x="${xhexa-a*5.0}" y="${yhexa+yreach*4.0}" col5="Purple"                     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh18" x="${xhexa-a*3.0}" y="${yhexa+yreach*4.0}" col5="Turquoise" col6="Blue"      rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh19" x="${xhexa-a*1.0}" y="${yhexa+yreach*4.0}" col5="Yellow"    col6="Green"     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh20" x="${xhexa+a*1.0}" y="${yhexa+yreach*4.0}" col5="Orange"    col6="Red "      rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh21" x="${xhexa+a*3.0}" y="${yhexa+yreach*4.0}" col6="Purple"                     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh22" x="${xhexa+a*4.0}" y="${yhexa+yreach*3.0}" col6="Turquoise" col1="Blue"      rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh23" x="${xhexa+a*5.0}" y="${yhexa+yreach*2.0}" col6="Yellow"    col1="Green"     rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="hh24" x="${xhexa+a*6.0}" y="${yhexa+yreach*1.0}" col6="Orange"    col1="Red"       rx="1.5708"   geo="circle"/>

    // First orange hexagon
    <!--xacro:hexagon h_name="h1" x="${xreach+a*4.0}" y= "0.0"           col1="Orange"                 rx="1.5708"   geo="circle"/>
    // side 1 \
    <xacro:hexagon h_name="h2" x="${xreach+a*3.0}" y="${-yreach}"     col1="Blue"  col2="Purple"    rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="h3" x="${xreach+a*2.0}" y="${-yreach*2.0}" col1="Green" col2="Turquoise" rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="h4" x="${xreach+a}" y="${-yreach*3.0}"     col1="Red"   col2="Yellow"    rx="1.5708"   geo="circle"/>
    <xacro:hexagon h_name="h5" x="${xreach}" y="${-yreach*4.0}"       col1="Blue"  col2="Purple"    ry="0"        geo="box"/>
    <xacro:hexagon h_name="h6" x="${xreach-a}" y="${-yreach*5.0}"     col1="Green" col2="Turquoise" ry="0"        geo="box"/>
    <xacro:hexagon h_name="h7" x="${xreach-a*2.0}" y="${-yreach*6.0}" col1="Red"   col2="Yellow"    ry="0"        geo="box"/>
    <xacro:hexagon h_name="h8" x="${xreach-a*3.0}" y="${-yreach*7.0}" col1="Blue"  col2="Purple"    ry="0.19635"  geo="star"/>
    <xacro:hexagon h_name="h8_1" x="${xreach-a*4.0}" y="${-yreach*8.0}" col1="Green" col2="Turquoise" ry="0.19635" geo="star"/>
    <xacro:hexagon h_name="h8_2" x="${xreach-a*5.0}" y="${-yreach*9.0}" col2="Yellow"               ry="0.19635"  geo="star"/>
    // side 2 |
    <xacro:property name="x2" value="${xreach-a*5.0-r}"/>
    <xacro:property name="y2" value="${-yreach*9.0}"/>
    <xacro:hexagon h_name="h9"  x="${x2}"  y="${y2}"       col2="Purple"     col3="Red"      ry="0.3927"  geo="box2"/>
    <xacro:hexagon h_name="h10" x="${x2-r}"  y="${y2}"     col2="Turquoise"  col3="Blue"     ry="0.3927"  geo="box2"/>
    <xacro:hexagon h_name="h11" x="${x2-r*2.0}"  y="${y2}" col2="Yellow"     col3="Green"    ry="0.3927"  geo="box2"/>
    <xacro:hexagon h_name="h12" x="${x2-r*3.0}" y="${y2}"  col3="Red"        col2="Purple"   ry="0.58905" geo="box"/>
    <xacro:hexagon h_name="h13" x="${x2-r*4.0}" y="${y2}"  col2="Turquoise"  col3="Blue"     ry="0.58905" geo="box"/>
    <xacro:hexagon h_name="h14" x="${x2-r*5.0}" y="${y2}"  col2="Yellow"     col3="Green"    ry="0.58905" geo="box"/>
    <xacro:hexagon h_name="h15" x="${x2-r*6.0}" y="${y2}"  col3="Red"        col2="Purple"   ry="0.0"     geo="star"/>
    <xacro:hexagon h_name="h15_1" x="${x2-r*7.0}" y="${y2}" col2="Turquoise" col3="Blue"     ry="0.0"     geo="star"/>
    <xacro:hexagon h_name="h15_2" x="${x2-r*8.0}" y="${y2}" col3="Green"                     ry="0.0"     geo="star"/>
    // side 3 /
    <xacro:property name="x3" value="${x2-r*8.0-a}"/>
    <xacro:property name="y3" value="${y2+yreach}"/>
    <xacro:hexagon h_name="h16" x="${x3}" y="${y3}"                    col3="Red"       col4="Yellow"    ry="0.19635"  geo="box2"/>
    <xacro:hexagon h_name="h17" x="${x3-a}" y="${y3+yreach}"           col3="Blue"      col4="Purple"    ry="0.19635"  geo="box2"/>
    <xacro:hexagon h_name="h18" x="${x3-a*2.0}" y="${y3+yreach*2.0}"   col3="Green"     col4="Turquoise" ry="0.19635"  geo="box2"/>
    <xacro:hexagon h_name="h19" x="${x3-a*3.0}" y="${y3+yreach*3.0}"   col3="Red"       col4="Yellow"    ry="0.3927"   geo="box"/>
    <xacro:hexagon h_name="h20" x="${x3-a*4.0}" y="${y3+yreach*4.0}"   col3="Blue"      col4="Purple"    ry="0.3927"   geo="box"/>
    <xacro:hexagon h_name="h21" x="${x3-a*5.0}" y="${y3+yreach*5.0}"   col3="Green"     col4="Turquoise" ry="0.3927"   geo="box"/>
    <xacro:hexagon h_name="h22" x="${x3-a*6.0}" y="${y3+yreach*6.0}"   col3="Red"       col4="Yellow"    ry="0.58905"  geo="star"/>
    <xacro:hexagon h_name="h22_1" x="${x3-a*7.0}" y="${y3+yreach*7.0}" col3="Blue"      col4="Purple"    ry="0.58905"  geo="star"/>
    <xacro:hexagon h_name="h22_2" x="${x3-a*8.0}" y="0.0"              col4="Turquoise"                  ry="0.58905"  geo="star"/>
    // side 4 \
    <xacro:property name="x4" value="${x3-a*7.0}"/>
    <xacro:hexagon h_name="h23" x="${x4}" y="${yreach}"                col4="Yellow"    col5="Green"     rx="1.5708"  geo="circle"/>
    <xacro:hexagon h_name="h24" x="${x4+a}" y="${yreach*2.0}"          col5="Red"       col4="Purple"    rx="1.5708"  geo="circle"/>
    <xacro:hexagon h_name="h25" x="${x4+a*2.0}" y="${yreach*3.0}"      col4="Turquoise" col5="Blue"      rx="1.5708"  geo="circle"/>
    <xacro:hexagon h_name="h26" x="${x4+a*3.0}" y="${yreach*4.0}"      col4="Yellow"    col5="Green"     ry="0.0" geo="box"/>
    <xacro:hexagon h_name="h27" x="${x4+a*4.0}" y="${yreach*5.0}"      col5="Red"       col4="Purple"    ry="0.0" geo="box"/>
    <xacro:hexagon h_name="h28" x="${x4+a*5.0}" y="${yreach*6.0}"      col4="Turquoise" col5="Blue"      ry="0.0" geo="box"/>
    <xacro:hexagon h_name="h29" x="${x4+a*6.0}" y="${yreach*7.0}"      col4="Yellow"    col5="Green"     ry="0.19635" geo="star"/>
    <xacro:hexagon h_name="h29_1" x="${x4+a*7.0}" y="${yreach*8.0}"    col5="Red"       col4="Purple"    ry="0.19635" geo="star"/>
    <xacro:hexagon h_name="h29_2" x="${x4+a*8.0}" y="${yreach*9.0}"    col5="Blue"                       ry="0.19635" geo="star"/>
    // side 5 |
    <xacro:property name="x5" value="${x4+a*8.0+r}"/>
    <xacro:property name="y5" value="${yreach*9.0}"/>
    <xacro:hexagon h_name="h30" x="${x5}" y="${y5}"                    col5="Green"     col6="Turquoise" ry="0.3927"  geo="box2"/>
    <xacro:hexagon h_name="h31" x="${x5+r}" y="${y5}"                  col5="Red"       col6="Yellow"    ry="0.3927"  geo="box2"/>
    <xacro:hexagon h_name="h32" x="${x5+r*2.0}" y="${y5}"              col5="Blue"      col6="Purple"    ry="0.3927"  geo="box2"/>
    <xacro:hexagon h_name="h33" x= "${x5+r*3.0}" y="${y5}"             col5="Green"     col6="Turquoise" ry="0.58905" geo="box"/>
    <xacro:hexagon h_name="h34" x= "${x5+r*4.0}" y="${y5}"             col5="Red"       col6="Yellow"    ry="0.58905" geo="box"/>
    <xacro:hexagon h_name="h35" x= "${x5+r*5.0}" y="${y5}"             col5="Blue"      col6="Purple"    ry="0.58905" geo="box"/>
    <xacro:hexagon h_name="h36" x= "${x5+r*6.0}" y="${y5}"             col5="Green"     col6="Turquoise" ry="0.0"     geo="star"/>
    <xacro:hexagon h_name="h36_1" x= "${x5+r*7.0}" y="${y5}"           col5="Red"       col6="Yellow"    ry="0.0"     geo="star"/>
    <xacro:hexagon h_name="h36_2" x= "${x5+r*8.0}" y="${y5}"           col6="Purple"                     ry="0.0"     geo="star"/>
    // side 6 /
    <xacro:property name="x6" value="${x5+r*7.0-a}"/>
    <xacro:hexagon h_name="h37" x= "${x6+a*4.0}" y="${yreach*8.0}"    col6="Turquoise"  col1="Blue"      ry="0.19635" geo="box2"/>
    <xacro:hexagon h_name="h38" x= "${x6+a*5.0}" y="${yreach*7.0}"    col6="Yellow"     col1="Green"     ry="0.19635" geo="box2"/>
    <xacro:hexagon h_name="h39" x= "${x6+a*6.0}" y="${yreach*6.0}"    col1="Red"        col6="Purple"    ry="0.19635" geo="box2"/>
    <xacro:hexagon h_name="h40" x= "${x6+a*7.0}" y="${yreach*5.0}"    col6="Turquoise"  col1="Blue"      ry="0.3927"  geo="box"/>
    <xacro:hexagon h_name="h41" x= "${x6+a*8.0}" y="${yreach*4.0}"    col6="Yellow"     col1="Green"     ry="0.3927"  geo="box"/>
    <xacro:hexagon h_name="h42" x= "${x6+a*9.0}" y="${yreach*3.0}"    col1="Red"        col6="Purple"    ry="0.3927"  geo="box"/>
    <xacro:hexagon h_name="h42_1" x= "${x6+a*10.0}" y="${yreach*2.0}" col6="Turquoise"  col1="Blue"      ry="0.58905" geo="star"/>
    <xacro:hexagon h_name="h42_2" x= "${x6+a*11.0}" y="${yreach}"     col6="Yellow"     col1="Green"     ry="0.58905" geo="star"/-->
    </xacro:macro>
    
</robot>
