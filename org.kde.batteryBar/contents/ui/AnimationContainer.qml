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
    property int maxWidth: 0
    property bool vertical: false
    property bool discharging: false

    property alias plugOutAnimation: bubblesContainer.plugOutAnimation
    property var bubbleDuration: [1500, 1800, 700, 1200, 1400, 600, 1000, 800, 1200]
    property alias plugInAnimation: boltContainer.plugInAnimation
    property int boltDuration: 500

    Bolt {
        id: boltContainer

        maxWidth: root.maxWidth
        discharging: root.discharging
        boltDuration: root.boltDuration
    }
    Bubbles {
        id: bubblesContainer

        maxWidth: root.maxWidth
        discharging: root.discharging
        bubbleDuration: root.bubbleDuration
    }
    OpacityMask {
        anchors.fill: bubblesContainer
        source: bubblesContainer
        maskSource: Rectangle {
            width: bubblesContainer.height
            height: bubblesContainer.width
            radius: bubblesContainer.radius
        }
    }
}
