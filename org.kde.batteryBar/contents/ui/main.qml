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
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import "bars"
import "animations"

MainContainer {
    id: rootItem

    property var global: Global {}
    Battery {}
    ChargeBar {
        id: chargeBar
    }
    RateBar {
        id: rateBar
    }
    Rectangle {
        id: rateBarSegments
        anchors.top:    rateBar.top
        anchors.bottom: rateBar.bottom
        anchors.left:   chargeBar.left
        anchors.right:  chargeBar.right
        clip: !rootItem.global.batteryIsCharging
        color: "transparent"

        Repeater {
            model: 20
            Rectangle {
                anchors.top    : rateBarSegments.top
                anchors.bottom : rateBarSegments.bottom

                color: rootItem.global.rateBarSegmentsColor
                opacity: rootItem.global.rateBarSegmentsOpacity

                x: (rateBar.x - chargeBar.x) + rateBar.width * (rateBar.flip ? -1-index : 2+index)
                width: 4

                Behavior on x {
                    NumberAnimation {
                        duration: 1000
                        easing.type: Easing.InQuad
                    }
                }
                Behavior on y {
                    NumberAnimation {
                        duration: 1000
                        easing.type: Easing.InQuad
                    }
                }
            }
        }
    }
    AnimationContainer {
        anchors.fill: chargeBar
    }
    transform: [
        Rotation {
            origin { x: 0; y: 0 }
            angle: rootItem.global.isVertical ? -90 : 0
        },
        Rotation {
            origin { x: 0; y: 0 }
            axis { x: 1; y: 0; z: 0 }
            angle: rootItem.global.isVertical ? 180 : 0
        }
    ]
}
