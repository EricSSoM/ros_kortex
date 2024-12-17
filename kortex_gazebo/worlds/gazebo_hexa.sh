#!/usr/bin/env sh

# find coreesponding (x,y) position in gazebo (times 10 because of integer only) of (x,y) hexa coordinates
# x positive axis follows red line, y positive axis follow green line
#
#        (10, 0)
# (-10, 10)    (10, 10)
#         (0 ,0)
# (-10,-10)    (10,-10)
#        (-10,0)
#

xpos=0
ypos=0
xhexa=0
yhexa=0
xdest=$1
ydest=$2
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
                xhexa=$((xhexa + 10))
                yhexa=$((yhexa + 10))
                xpos=$((xpos + 1))
                ypos=$((ypos + 1))
            else
                xhexa=$((xhexa - 10))
                yhexa=$((yhexa - 10))
                xpos=$((xpos - 1))
                ypos=$((ypos - 1))
            fi
        else
            if [ $xabs -gt $yabs ]
            then
                if [ $xdiff -gt 0 ]
                then
                    xhexa=$((xhexa + 10))
                    xpos=$((xpos + 1))
                else
                    xhexa=$((xhexa - 10))
                    xpos=$((xpos - 1))
                fi
            else
                if [ $ydiff -gt 0 ]
                then
                    xhexa=$((xhexa - 10))
                    yhexa=$((yhexa + 10))
                    ypos=$((ypos + 1))
                else
                    xhexa=$((xhexa + 10))
                    yhexa=$((yhexa - 10))
                    ypos=$((ypos - 1))
                fi
            fi
        fi
    fi
done
echo "$xhexa $yhexa"
