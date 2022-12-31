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
import ".."

Rectangle {
    id: root
    anchors.fill: parent
    color: "#FFFFFF"
    visible: rootItem.global.batteryIsCharging && rootItem.global.breatheVisible
    opacity: 0.0

    SequentialAnimation {
        running: root.visible
        loops: Animation.Infinite
        alwaysRunToEnd: true
        PauseAnimation {
            duration: rootItem.global.breatheDelay
        }
        PropertyAnimation {
            target: root
            property: "opacity"

            from: 0.0
            to: rootItem.global.breatheOpacity

            duration: rootItem.global.breatheDuration
            easing.type: Easing.InOutQuad
        }
        PropertyAnimation {
            target: root
            property: "opacity"

            from: rootItem.global.breatheOpacity
            to: 0.0

            duration: rootItem.global.breatheDuration
            easing.type: Easing.InOutQuad
        }
    }
}
