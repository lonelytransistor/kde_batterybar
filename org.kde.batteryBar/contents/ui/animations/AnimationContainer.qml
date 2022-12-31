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
import QtQuick 2.15
import ".."

Rectangle {
    id: root
    color: "transparent"
    visible: rootItem.global.animationsVisible
    clip: true

    Loader {
        anchors.fill: parent

        signal load
        signal ended

        property bool oldRain: false
        property bool oldSnow: false
        property bool oldBubbles: false

        property bool rain: rootItem.global.rainVisible
        property bool snow: rootItem.global.snowVisible
        property bool bubbles: !rootItem.global.batteryIsCharging && rootItem.global.bubblesVisible
        onRainChanged: { load(); oldRain = rain }
        onSnowChanged: { load(); oldSnow = snow }
        onBubblesChanged: { load(); oldBubbles = bubbles }

        onLoad: {
            if (bubbles && !oldBubbles) {
                sourceComponent = bubblesComponent
                active = true
            } else if (rain && !oldRain) {
                sourceComponent = rainComponent
                active = true
            } else if (snow && !oldSnow) {
                sourceComponent = snowComponent
                active = true
            }
        }
        onEnded: active = false
    }
    Breathing {}
    Bolt {}
    Component {
        id: bubblesComponent
        Bubbles {}
    }
    Component {
        id: snowComponent
        Snow {}
    }
    Component {
        id: rainComponent
        Rain {}
    }
}
