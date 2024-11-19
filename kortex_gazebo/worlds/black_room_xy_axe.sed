<?xml version="1.0"?>

<world name="default" xmlns:xacro="http://www.ros.org/wiki/xacro" >

  <!-- To generate a room with floor, walls and hexagons:
       1- Convert (x,y) hexa position into (x,y) cm position and edit into this file (replace x and y by hexa coordinates)
          Also specify maximum arm reach (0.9) in this case:
          sh gazebo_hexa.sh 3 3 | xargs -l bash -c 'sed -e "s+@x+$0+g" -e "s+@y+$1+g" -e "s+@w+0.9+g" black_room_xy.sed > black_room_xy.xacro'
       2- Convert xacro file to urdf:
          xacro black_room_xy.xacro > black_room_xy.sdf
       3- Convert URDF to SDF:
          sed -e 's\\"<world"\\"<sdf version='1.4'> <world"\\g' -e 's\\"</world>"\\"</world> </sdf>"\\g' > black_room_xy.world
  -->
      
          <include> <uri>model://sun</uri> </include>
          
          <model name="floor">
            <static>true</static>
            <link name="floor">
              <collision name="collision">
                <geometry>
                  <plane>
                    <normal>0 0 1</normal>
                    <size>20 20</size>
                  </plane>
                </geometry>
                <surface>
                  <contact>
                    <collide_bitmask>0xffff</collide_bitmask>
                  </contact>
                  <friction>
                    <ode>
                      <mu>100</mu>
                      <mu2>50</mu2>
                    </ode>
                  </friction>
                </surface>
              </collision>
              <visual name="visual">
                <cast_shadows>false</cast_shadows>
                <geometry>
                  <plane>
                    <normal>0 0 1</normal>
                    <size>20 20</size>
                  </plane>
                </geometry>
                <material>
                  <script>
                    <uri>file://media/materials/scripts/gazebo.material</uri>
                    <name>Gazebo/Black</name>
                  </script>
                </material>
              </visual>
            </link>
          </model>

          <model name='wall1'>
            <static>1</static>
            <link name='link_wall1'>
              <visual name='wall1_visual'>
                <cast_shadows>0</cast_shadows>
                <pose> 9.99 0 2 0 1.5708 0 </pose>
                <geometry>
                  <box> <size> 4 20 0.01 </size> </box>
                </geometry>
                <material>
                  <script>
                    <name>Gazebo/Black</name>
                  </script>
                </material>
              </visual>
              <self_collide>0</self_collide>
              <kinematic>0</kinematic>
              <gravity>1</gravity>
            </link>
          </model>

          <model name='wall2'>
            <static>1</static>
            <link name='link_wall2'>
              <visual name='wall2_visual'>
                <cast_shadows>0</cast_shadows>
                <pose> -9.99 0 2 0 1.5708 0 </pose>
                <geometry>
                  <box> <size> 4 20 0.01 </size> </box>
                </geometry>
                <material>
                  <script>
                    <name>Gazebo/Black</name>
                  </script>
                </material>
              </visual>
              <self_collide>0</self_collide>
              <kinematic>0</kinematic>
              <gravity>1</gravity>
            </link>
          </model>

          <model name='wall3'>
            <static>1</static>
            <link name='link_wall3'>
              <visual name='wall3_visual'>
                <cast_shadows>0</cast_shadows>
                <pose> 0 9.99 2 0 1.5708 1.5708 </pose>
                <geometry>
                  <box> <size> 4 20 0.01 </size> </box>
                </geometry>
                <material>
                  <script>
                    <name>Gazebo/Black</name>
                  </script>
                </material>
              </visual>
              <self_collide>0</self_collide>
              <kinematic>0</kinematic>
              <gravity>1</gravity>
            </link>
          </model>

          <model name='wall4'>
            <static>1</static>
            <link name='link_wall4'>
              <visual name='wall4_visual'>
                <cast_shadows>0</cast_shadows>
                <pose> 0 -9.99 2 0 1.5708 1.5708 </pose>
                <geometry>
                  <box> <size> 4 20 0.01 </size> </box>
                </geometry>
                <material>
                  <script>
                    <name>Gazebo/Black</name>
                  </script>
                </material>
              </visual>
              <self_collide>0</self_collide>
              <kinematic>0</kinematic>
              <gravity>1</gravity>
            </link>
          </model>

          <!-- platform on real robot is at 36cm, must add radius of ball, thus 0.42 -->
          <!--model name="sphere_red_1">
            <pose>-0.6 -0.1 0.41 0 0 0</pose>
            <static>true</static>
            <link name="red_link">
              <visual name="red_visual">
                <geometry>
	          <sphere> <radius>0.05</radius> </sphere>
                </geometry>
                <material>
                  <script>
              <name>Gazebo/Red</name>
                  </script>
                </material>
              </visual>
            </link>
          </model-->
    
          <scene> <grid>0</grid> </scene>

          <xacro:property name="reach" value="${@w}"/>
          <xacro:property name="r" value="${reach/7.0}"/>
          <xacro:property name="a" value="${r/2.0}"/>    
          <xacro:property name="size" value="${r/1.7321}"/>
          <xacro:property name="size_side" value="${r/3.4642+0.01}"/>
          <xacro:property name="xreach" value="${reach-size/2.0}"/>
          <xacro:property name="yreach" value="${size*1.5}"/>
          <xacro:property name="offset" value="${0.02}"/>

          <xacro:macro name="hexa" params="hexa_name color_name x y rx ry rz geo">
            <model name='${hexa_name}'>
              <pose> ${x+offset} ${y} ${size_side/2.0+size_side/20.0+0.06}  ${rx} ${ry} ${rz} </pose>
              <static>1</static>
              <link name="${hexa_name}">
                <inertial> <mass> 1.0 </mass> <inertia> <ixx>1000.0</ixx> <ixy>0.0</ixy> <ixz>0.0</ixz> <iyy>1000.0</iyy><iyz>0.0</iyz> <izz>1000.0</izz> </inertia> </inertial>
                <visual name="${hexa_name}">
                  <xacro:if value="${geo == 'box'}">
                    <geometry> <box> <size> ${size_side/1.5} 0.001 ${size_side/1.5} </size> </box> </geometry>
                  </xacro:if>
                  <xacro:if value="${geo == 'box2'}">
                    <geometry> <box> <size> ${size_side/1.5} 0.001 ${size_side/1.5} </size> </box> </geometry>
                  </xacro:if>
                  <xacro:if value="${geo == 'circle'}">
                    <geometry> <cylinder> <radius> ${size_side/3} </radius> <length> 0.001 </length> </cylinder> </geometry>
                  </xacro:if>
                  <xacro:if value="${geo == 'star'}">
                    <geometry> <box> <size> ${size_side/1.5} 0.001 ${size_side/1.5} </size> </box> </geometry>
                  </xacro:if>
                  <material> <script> <name>Gazebo/${color_name}</name> </script> </material>
                  <diffuse>0.3 0.3 0.3</diffuse>
                  <specular>0.3 0.3 0.3</specular>
                </visual>
                <xacro:if value="${geo == 'box2'}">
                  <visual name="${hexa_name}_box2">
                    <pose> ${x+offset} ${y} ${size_side/2.0+size_side/20.0+0.06}  ${rx} ${ry+0.7854} ${rz} </pose>
                    <geometry> <box> <size> ${size_side/1.5} 0.001 ${size_side/1.5} </size> </box> </geometry>
                    <diffuse>0.3 0.3 0.3</diffuse>
                    <specular>0.3 0.3 0.3</specular>
                  </visual>
                </xacro:if>
                <xacro:if value="${geo == 'star'}">
                  <visual name="${hexa_name}_star">
                    <pose> ${x+offset} ${y} ${size_side/2.0+size_side/20.0+0.06}  1.5708 0.0 ${rz} </pose>
                    <geometry> <cylinder> <radius> ${size_side/2.6} </radius> <length> 0.001 </length> </cylinder> </geometry>
                    <diffuse>0.3 0.3 0.3</diffuse>
                    <specular>0.3 0.3 0.3</specular>
                  </visual>
                </xacro:if>
              </link>
            </model>
          </xacro:macro>

          <xacro:macro name="hexa_top" params="hexa_name x y rz">
            <model name='${hexa_name}'>
              <static>1</static>
              <link name="${hexa_name}">
                <inertial> <mass> 1.0 </mass> <inertia> <ixx>1.0</ixx> <ixy>0.0</ixy> <ixz>0.0</ixz> <iyy>1.0</iyy><iyz>0.0</iyz> <izz>1.0</izz> </inertia> </inertial>
                <visual name="${hexa_name}">
                  <pose> ${x+offset} ${y} ${size/2+size/20+0.02}  0 0 ${rz} </pose>
                  <geometry> <box> <size> ${size-0.001} ${size-0.001} ${2.0*size} </size> </box> </geometry>
                  <material> <script> <name>Gazebo/Black</name> </script> </material>
                  <diffuse>0.3 0.3 0.3</diffuse>
                  <specular>0.3 0.3 0.3</specular>
                </visual>
              </link>
            </model>
          </xacro:macro>

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
          <!-- Put hexa on base (if hides target) -->
          <xacro:hexagon h_name="h0" x="${-size-0.015}" y= "0.0" col4="Purple" col5="Purple" col6="Purple" col1="Purple" col2="Purple" col3="Purple" rx="1.5708" ry="0" geo="circle"/>
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

        </world>
