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

Rectangle {
    id: root
    property bool vertical: false

    anchors.top:    (( plasmoid.configuration.rateTopAlign || plasmoid.configuration.rateHeight == 0) && !root.vertical) ? parent.top    : undefined
    anchors.bottom: ((!plasmoid.configuration.rateTopAlign || plasmoid.configuration.rateHeight == 0) && !root.vertical) ? parent.bottom : undefined
    anchors.left:   (( plasmoid.configuration.rateTopAlign || plasmoid.configuration.rateHeight == 0) &&  root.vertical) ? parent.left   : undefined
    anchors.right:  ((!plasmoid.configuration.rateTopAlign || plasmoid.configuration.rateHeight == 0) &&  root.vertical) ? parent.right  : undefined

    anchors.topMargin:    anchors.top    ? plasmoid.configuration.rateMargin : 0
    anchors.bottomMargin: anchors.bottom ? plasmoid.configuration.rateMargin : 0
    anchors.leftMargin:   anchors.left   ? plasmoid.configuration.rateMargin : 0
    anchors.rightMargin:  anchors.right  ? plasmoid.configuration.rateMargin : 0

    x: !root.vertical ? plasmoid.configuration.startOffset : undefined
    y:  root.vertical ? plasmoid.configuration.startOffset : undefined

    property var thickness: (plasmoid.configuration.rateHeight == 0 ? undefined : plasmoid.configuration.rateHeight)
    property var length:    (plasmoid.configuration.valueRateOffset + batteryData.p_rate*plasmoid.configuration.rateRescale)*(root.vertical ? Screen.height : Screen.width)
    width:  root.vertical ? thickness : length
    height: root.vertical ? length : thickness
    opacity: plasmoid.configuration.rateOpacity/255

    color: plasmoid.configuration.rateColor
    Behavior on width {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }
    Behavior on height {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }
}
