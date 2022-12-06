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
    visible: Global.boltVisible
    opacity: Global.batteryIsCharging ? 0.7 : 0.0

    Rectangle {
        x: Global.batteryIsCharging ? Global.maxLen+width : -width
        y: 0
        width: 400
        height: parent.height

        Behavior on x {
            NumberAnimation {
                duration: 1000
                easing.type: Easing.InQuad
            }
        }
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(parent.width, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.25; color: "#00000000" }
                GradientStop { position: 0.50; color: "#A0FFFFFF" }
                GradientStop { position: 0.75; color: "#00000000" }
            }
        }
        color: "transparent"
    }
}
