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

    property bool alignToTopLeft
    property bool flip
    property bool fill
    property int margin
    property int offset
    property int length
    property int thickness
    onMarginChanged: updateAnchors()
    onOffsetChanged: updateAnchors()
    onAlignToTopLeftChanged: updateAnchors()
    onFillChanged: updateAnchors()
    function _updateAnchors(data) {
        anchors.top    = data.top    ? parent.top    : undefined
        anchors.bottom = data.bottom ? parent.bottom : undefined
        anchors.left   = data.left   ? parent.left   : undefined
        anchors.right  = data.right  ? parent.right  : undefined

        anchors.topMargin    = data.top    ? margin + ( Global.isVertical ? offset : 0) : undefined
        anchors.bottomMargin = data.bottom ? margin : undefined
        anchors.leftMargin   = data.left   ? margin + (!Global.isVertical ? offset : 0) : undefined
        anchors.rightMargin  = data.right  ? margin : undefined
    }
    function updateAnchors() {
        if (fill) {
            if (Global.isVertical) {
                _updateAnchors({top: 1, left: 1, right: 1})
            } else {
                _updateAnchors({top: 1, bottom: 1, left: 1})
            }
        } else if (!Global.isVertical) {
            if (alignToTopLeft && !flip) {
                _updateAnchors({top: 1, left: 1})
            } else if (alignToTopLeft && flip) {
                _updateAnchors({top: 1, right: 1})
            } else if (!alignToTopLeft && !flip) {
                _updateAnchors({bottom: 1, left: 1})
            } else if (!alignToTopLeft && flip) {
                _updateAnchors({bottom: 1, right: 1})
            }
        } else {
            if (alignToTopLeft && !flip) {
                _updateAnchors({top: 1, left: 1})
            } else if (alignToTopLeft && flip) {
                _updateAnchors({bottom: 1, left: 1})
            } else if (!alignToTopLeft && !flip) {
                _updateAnchors({top: 1, right: 1})
            } else if (!alignToTopLeft && flip) {
                _updateAnchors({bottom: 1, right: 1})
            }
        }
    }
    width:  Global.isVertical ? thickness : length
    height: Global.isVertical ? length : thickness

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
