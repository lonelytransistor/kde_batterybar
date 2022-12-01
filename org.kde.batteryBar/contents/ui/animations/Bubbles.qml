/*
 * Copyright 2022 lonelytransistor
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import QtGraphicalEffects 1.0
import ".."

Rectangle {
    id: root
    anchors.fill: parent
    color: "transparent"
    opacity: Global.batteryIsCharging ? 0.0 : 0.75
    visible: Global.bubblesVisible
    readonly property var speed: [1.5, 1.8, 0.7, 1.2, 1.4, 0.6, 1.0, 0.8, 1.2, 0.9, 0.8, 1.2, 1.1].map(function(x) { return x*1.5*Global.maxLen })

    Item {
        x: (Global.batteryIsCharging ? -200 : Global.maxLen+200)
        y: 0
        height: parent.height
        width: parent.width

        Behavior on x {
            NumberAnimation {
                duration: root.speed[0]
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: root.speed[0]
                easing.type: Easing.InOutQuad
            }
        }
        Bubble {
            speed: root.speed[1]

            x: parent.children[1].width*6
            y: (root.charging ? parent.height/2-height/2 : parent.height/2-height/4)
            width: parent.height/2
        }
        Bubble {
            speed: root.speed[2]

            x: parent.children[2].width*2
            y: (root.charging ? height : parent.height/2)
            width: parent.height/4
        }
        Bubble {
            speed: root.speed[3]

            y: (root.charging ? parent.height-height : 0)
            width: parent.height/8
        }
    }
    Item {
        x: (Global.batteryIsCharging ? -200 : Global.maxLen+200)
        y: 0
        height: parent.height
        width: parent.width

        Behavior on x {
            NumberAnimation {
                duration: root.speed[4]
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: root.speed[4]
                easing.type: Easing.InOutQuad
            }
        }
        Bubble {
            speed: root.speed[5]

            y: (root.charging ? height : height/4)
            width: parent.height/3
        }
        Bubble {
            speed: root.speed[6]

            x: parent.children[0].width*3
            y: (root.charging ? height/2 : height*2)
            width: parent.height/4
        }
        Bubble {
            speed: root.speed[7]

            y: (root.charging ? height/3 : parent.height-2*height/3)
            width: parent.height/6
        }
    }
    Item {
        x: (Global.batteryIsCharging ? -200-Global.maxLen*0.5 : Global.maxLen+200)
        y: 0
        height: parent.height
        width: parent.width

        Behavior on x {
            NumberAnimation {
                duration: root.speed[8]
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: root.speed[8]
                easing.type: Easing.InOutQuad
            }
        }
        Bubble {
            speed: root.speed[9]

            y: (root.charging ? height : height/3)
            width: parent.height/3
        }
        Bubble {
            speed: root.speed[10]

            x: parent.children[0].width*3
            y: (root.charging ? height/2 : height*2)
            width: parent.height/4
        }
        Bubble {
            speed: root.speed[11]

            y: (root.charging ? height/3 : parent.height-2*height/3)
            width: parent.height/4
        }
    }
}
