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

Rectangle {
    id: root
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    property double opacityCharging: (plugOutAnimation ? 0.75 : 0.0)
    opacity: (discharging ? opacityCharging : 0.0)
    color: "transparent"

    property bool plugOutAnimation: false
    property bool discharging: false
    property var bubbleDuration: [0, 0, 0, 0, 0, 0, 0, 0, 0]
    property int maxWidth: 0

    Item {
        x: (root.discharging ? root.maxWidth : -200)

        Behavior on x {
            NumberAnimation {
                duration: root.bubbleDuration[0]
                easing.type: Easing.InOutQuad
            }
        }
        Bubble {
            bubbleDuration: root.bubbleDuration[1]

            x: parent.children[1].width*6
            y: (root.discharging ? parent.height/2-height/2 : parent.height/2-height/4)
            width: parent.height/2
        }
        Bubble {
            bubbleDuration: root.bubbleDuration[2]

            x: parent.children[2].width*2
            y: (root.discharging ? height : parent.height/2)
            width: parent.height/4
        }
        Bubble {
            bubbleDuration: root.bubbleDuration[3]

            y: (root.discharging ? parent.height-height : 0)
            width: parent.height/8
        }
    }
    Item {
        x: (root.discharging ? root.maxWidth : -200)

        Behavior on x {
            NumberAnimation {
                duration: root.bubbleDuration[4]
                easing.type: Easing.InOutQuad
            }
        }
        Bubble {
            bubbleDuration: root.bubbleDuration[5]

            y: (root.discharging ? height : height/4)
            width: parent.height/3
        }
        Bubble {
            bubbleDuration: root.bubbleDuration[6]

            x: parent.children[0].width*3
            y: (root.discharging ? height/2 : height*2)
            width: parent.height/4
        }
        Bubble {
            bubbleDuration: root.bubbleDuration[7]

            y: (root.discharging ? height/3 : parent.height-2*height/3)
            width: parent.height/6
        }
    }
}
