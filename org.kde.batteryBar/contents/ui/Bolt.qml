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
    property double opacityCharging: (plugInAnimation ? 1.0 : 0.0)
    opacity: (discharging ? 0.0 : opacityCharging)
    color: "transparent"

    property bool plugInAnimation: false
    property bool discharging: false
    property int boltDuration: 0
    property int maxWidth: 0

    x: (discharging ? -200 : maxWidth+200)
    Behavior on x {
        NumberAnimation {
            duration: root.boltDuration
            easing.type: Easing.InQuad
        }
    }
    Rectangle {
        width: 200
        height: parent.height*4
        y: -parent.height*1.5
        transform: Rotation { origin.x: parent.width; origin.y: parent.height; angle: 30}

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(parent.width, 0)
            gradient: Gradient {
                GradientStop { position: 0.00; color: "#00000000" }
                GradientStop { position: 0.50; color: "#A0FFFFFF" }
                GradientStop { position: 1.00; color: "#00000000" }
            }
        }
        color: "transparent"
    }
}
