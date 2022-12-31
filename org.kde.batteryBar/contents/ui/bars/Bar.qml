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

    property int margin
    property int offset
    property string align

    property int thickness
    property int length

    readonly property bool vertical: rootItem.global.isVertical
    readonly property int parentThickness: rootItem.global.isVertical ? parent.width : parent.height

    onMarginChanged: update()
    onOffsetChanged: update()
    onAlignChanged: update()
    onThicknessChanged: update()
    onLengthChanged: update()
    function update() {
        if ((!vertical && align == "bottom-left") || (vertical && align == "top-right")) {
            x = offset
            y = parentThickness - thickness - margin
            width = length
            height = thickness
        } else if ((!vertical && align == "bottom-right") || (vertical && align == "bottom-right")) {
            x = rootItem.global.maxLen - length
            y = parentThickness - thickness - margin
            width = length
            height = thickness
        } else if ((!vertical && align == "top-left") || (vertical && align == "top-left")) {
            x = offset
            y = margin
            width = length
            height = thickness
        } else if ((!vertical && align == "top-right") || (vertical && align == "bottom-left")) {
            x = rootItem.global.maxLen - length
            y = margin
            width = length
            height = thickness
        } else if ((align == "fill-left") || (align == "fill-top")) {
            x = offset
            y = margin
            width = length
            height = parentThickness - 2*margin
        } else if ((align == "fill-right") || (align == "fill-bottom")) {
            x = rootItem.global.maxLen - length
            y = margin
            width = length
            height = parentThickness - 2*margin
        }
    }

    Behavior on y {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }
    Behavior on x {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.InOutQuad
        }
    }
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
    Behavior on color {
        ColorAnimation {
            duration: 1000
        }
    }
}
