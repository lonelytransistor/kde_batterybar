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
    id: root

    GlobalLoader {}
    Battery {}
    ChargeBar {
        id: chargeBar
    }
    RateBar {
        id: rateBar
    }
    Rectangle {
        id: rateBarSegments
        anchors.top: rateBar.top
        anchors.bottom: rateBar.bottom
        anchors.left: chargeBar.left
        anchors.right: chargeBar.right
        clip: true
        color: "transparent"

        Repeater {
            model: 20
            Rectangle {
                anchors.top: rateBarSegments.top
                anchors.bottom: rateBarSegments.bottom

                color: Global.rateBarSegmentsColor
                opacity: Global.rateBarSegmentsOpacity

                x: rateBar.length*(2+index) - 2
                width: 4
            }
        }
    }
    AnimationContainer {
        anchors.fill: chargeBar
    }
}
