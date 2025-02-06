<?xml version="1.0"?>

<world name="default" xmlns:xacro="http://www.ros.org/wiki/xacro" >

  <!-- To generate a room with floor, walls and 3 spheres on floor (black_room.world):
       1- Convert (x,y) hexa position into (x,y) cm position and edit into this file (replace x, y, t by hexa coordinates)
          Also specify maximum arm reach (0.84) in this case:
          sh gazebo_hexa.sh x y z t | xargs -l bash -c 'sed -e "s+@x+$0+g" -e "s+@y+$1+g" -e "s+@z+$2+g" -e "s+@w+0.84+g" black_room.sed > black_room.xacro'
       2- Convert xacro file to urdf:
          xacro black_room.xacro > black_room.sdf
       3- Convert URDF to SDF:
          sed -e 's+<world+<sdf version="1.4"> <world+g' -e 's+</world>+</world> </sdf>+g' > black_room.world
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
                      <mu>infinity</mu>
                      <mu2>infinity</mu2>
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
                    <name>Gazebo/White</name>
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
                    <name>Gazebo/White</name>
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
                    <name>Gazebo/White</name>
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
                    <name>Gazebo/White</name>
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
                    <name>Gazebo/White</name>
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
            <pose>-2.0 0.0 0.5 0 0 0</pose>
            <static>true</static>
            <link name="red_link">
              <visual name="red_visual">
                <geometry>
	          <sphere> <radius>0.06</radius> </sphere>
                </geometry>
                <material>
                  <script>
                    <name>Gazebo/Red</name>
                  </script>
                </material>
                <diffuse>0.3 0.3 0.3</diffuse>
                <specular>0.3 0.3 0.3</specular>
              </visual>
            </link>
          </model-->
    
          <scene> <grid>0</grid> </scene>

          <xacro:property name="reach" value="${@w}"/>
          <xacro:property name="r" value="${reach/14.0}"/>
          <xacro:property name="a" value="${r/2.0}"/>    
          <xacro:property name="size" value="${r/1.7321}"/>
          <xacro:property name="size_side" value="${r/3.4642+0.01}"/>
          <xacro:property name="yreach" value="${size*1.5}"/>
          <xacro:property name="offset" value="${0.02}"/>
          <xacro:property name="height" value="${0.25*(size_side/2.0+size_side/20.0+0.06)}"/>
          <xacro:property name="zhexa" value="${@z*r+0.0001}"/>

          <xacro:macro name="sphere" params="name color x y z">
            <model name='${name}'>
              <pose> ${x} ${y} ${z}  0.0 0.0 0.0 </pose>
              <gravity>0</gravity>
              <static>1</static>
              <link name="${name}">
                <inertial> <mass> 1.0 </mass> <inertia> <ixx>1000.0</ixx> <ixy>0.0</ixy> <ixz>0.0</ixz> <iyy>1000.0</iyy><iyz>0.0</iyz> <izz>1000.0</izz> </inertia> </inertial>
                <visual name="${name}">
                  <!--geometry> <sphere> <radius> ${size_side/1.5} </radius> </sphere> </geometry-->
                  <geometry> <cylinder> <radius> ${size_side/1.75} </radius> <length> 0.001 </length> </cylinder> </geometry>
                  <material> <script> <name>Gazebo/${color}</name> </script> </material>
                  <diffuse>0.3 0.3 0.3</diffuse>
                  <specular>0.3 0.3 0.3</specular>
                </visual>
              </link>
            </model>
          </xacro:macro>

          <xacro:property name="xhexa" value="${r * (@x) / 100.0 - 0.31}"/>    <!-- position of user wrist: (x, y) -->
          <xacro:property name="yhexa" value="${yreach * (@y) / 100.0}"/>
          
          <xacro:if value="${(@t) == -1}">    Purple is at postions (-2 0) (-5 -6) (1 6)
            <xacro:sphere name="ball_left"   x="${-a*3.0 - 0.31}" y="${-0.312}"            z="${zhexa}"  color="Purple"/>
            <xacro:sphere name="ball_center" x="${-a*3.0 - 0.31}" y="${0.0}"               z="${zhexa}"  color="Purple"/>
            <xacro:sphere name="ball_right"  x="${-a*3.0 - 0.31}" y="${0.312}"             z="${zhexa}"  color="Purple"/>
          </xacro:if>
          <xacro:if value="${(@t) == 0}">    Purple is at postion of arm + (-2 0)
            <xacro:sphere name="ball_purple" x="${xhexa-a*4.0}" y="${yhexa}"            z="${zhexa}"  color="Purple"/>
            <xacro:sphere name="ball_red"    x="${xhexa-a*3.0}" y="${yhexa-yreach}"     z="${zhexa}"  color="Red"/>
            <xacro:sphere name="ball_green"  x="${xhexa-a*2.0}" y="${yhexa-yreach*2.0}" z="${zhexa}"  color="Green"/>
          </xacro:if>
          <xacro:if value="${(@t) == 6}">    Purple is at postion of arm + (-2 0) but lower, green directly underneath
            <xacro:sphere name="ball_purple" x="${xhexa-a*2.0}"   y="${yhexa}"            z="${zhexa-r}"   color="Purple"/>
            <xacro:sphere name="ball_red"    x="${xhexa+a}"       y="${yhexa}"            z="${zhexa-3*a}" color="Red"/>
            <xacro:sphere name="ball_green"  x="${xhexa+a*4.0}"   y="${yhexa}"            z="${zhexa-2*r}" color="Green"/>
          </xacro:if>

        </world>
