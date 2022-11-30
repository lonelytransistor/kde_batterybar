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

Item {
    id: root
    height: width
    property int speed: 0

    Rectangle {
        id: bubble
        anchors.fill: parent
        visible: false
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: parent.width*0.5

        RadialGradient {
            anchors.fill: parent
            horizontalOffset: parent.width/4
            verticalOffset: parent.width/4
            gradient: Gradient {
                GradientStop { position: 0.2; color: "#60FFFFFF" }
                GradientStop { position: 1.0; color: "#10000000" }
            }
        }
        Behavior on x {
            NumberAnimation {
                duration: root.speed
                easing.type: Easing.OutInBounce
            }
        }
        Behavior on y {
            NumberAnimation {
                duration: root.speed
                easing.type: Easing.OutInBounce
            }
        }
    }
    OpacityMask {
        anchors.fill: bubble
        source: bubble
        maskSource: Rectangle {
            width:  bubble.height
            height: bubble.width
            radius: bubble.radius
        }
    }
}
