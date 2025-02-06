#!/usr/bin/env sh

# find coreesponding (x,y) position in gazebo (times 100 because of integer only) of (x,y) hexa coordinates
# x positive axis follows red line, y positive axis follow green line
#
#        (100, 0)
# (-50,-52)    (-50,52)
#         (0 ,0)
# (50, -52)    (50, 52)
#        (-100,0)
#

xpos=0
ypos=0
xhexa=0
yhexa=0
xdest=$1
ydest=$2
zdest=$3
tdest=$4
ok=1
while [ $ok -eq 1 ]; do
    xdiff=$((xdest - xpos))
    ydiff=$((ydest - ypos))
    xabs=$((xdiff * ((xdiff > 0) - (xdiff < 0))))
    yabs=$((ydiff * ((ydiff > 0) - (ydiff < 0))))
    if [ "$xdiff" -eq 0 -a "$ydiff" -eq 0 ]
    then
        ok=0
    else
        if [ $xdiff -eq $ydiff ]
        then
            if [ $xdiff -gt 0 ]
            then
                xhexa=$((xhexa + 50))
                yhexa=$((yhexa + 52))
                xpos=$((xpos + 1))
                ypos=$((ypos + 1))
            else
                xhexa=$((xhexa - 50))
                yhexa=$((yhexa - 52))
                xpos=$((xpos - 1))
                ypos=$((ypos - 1))
            fi
        else
            if [ $xabs -gt $yabs ]
            then
                if [ $xdiff -gt 0 ]
                then
                    xhexa=$((xhexa + 100))
                    xpos=$((xpos + 1))
                else
                    xhexa=$((xhexa - 100))
                    xpos=$((xpos - 1))
                fi
            else
                if [ $ydiff -gt 0 ]
                then
                    xhexa=$((xhexa - 50))
                    yhexa=$((yhexa + 52))
                    ypos=$((ypos + 1))
                else
                    xhexa=$((xhexa + 50))
                    yhexa=$((yhexa - 52))
                    ypos=$((ypos - 1))
                fi
            fi
        fi
    fi
done
echo "$xhexa $yhexa $zdest $tdest"
