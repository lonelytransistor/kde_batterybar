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

    property string align
    property int margin
    property int offset
    property bool flip

    onMarginChanged: updateAnchors()
    onOffsetChanged: updateAnchors()
    onAlignChanged: updateAnchors()
    function _updateAnchors(data, f = false) {
        anchors.top    = data.top    ? parent.top    : undefined
        anchors.bottom = data.bottom ? parent.bottom : undefined
        anchors.left   = data.left   ? parent.left   : undefined
        anchors.right  = data.right  ? parent.right  : undefined

        anchors.topMargin    = data.top    ? margin : 0
        anchors.bottomMargin = data.bottom ? margin : 0
        anchors.leftMargin   = data.left   ? margin : 0
        anchors.rightMargin  = data.right  ? margin : 0

        flip = f
    }
    function updateAnchors() {
        if (Global.isVertical) {
            if (align == "bottom-left") {
                _updateAnchors({top: 1})
            } else if (align == "bottom-right") {
                _updateAnchors({top: 1}, true)
            } else if (align == "top-left") {
                _updateAnchors({bottom: 1})
            } else if (align == "top-right") {
                _updateAnchors({bottom: 1}, true)
            } else if (align == "fill-left" || align == "fill-top") {
                _updateAnchors({top: 1, bottom: 1})
            } else if (align == "fill-right" || align == "fill-bottom") {
                _updateAnchors({top: 1, bottom: 1}, true)
            }
        } else {
            if (align == "top-left") {
                _updateAnchors({top: 1})
            } else if (align == "top-right") {
                _updateAnchors({top: 1}, true)
            } else if (align == "bottom-left") {
                _updateAnchors({bottom: 1})
            } else if (align == "bottom-right") {
                _updateAnchors({bottom: 1}, true)
            } else if (align == "fill-left" || align == "fill-top") {
                _updateAnchors({top: 1, bottom: 1})
            } else if (align == "fill-right" || align == "fill-bottom") {
                _updateAnchors({top: 1, bottom: 1}, true)
            }
        }
    }
    x: flip ? Global.maxLen-offset-width : offset

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
