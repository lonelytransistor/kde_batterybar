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
pragma Singleton
import QtQuick 2.2

QtObject {
    id: root

    // Info
    property bool isVertical
    property bool isPlanar
    property int maxLen: 1
    property bool editMode

    // Battery
    property int batteryNow: 1
    property int batteryRate: 2
    property int batteryFull: 4
    property bool batteryIsCharging: false

    // Size
    property int editModeSize: 32

    // Animations
    property bool animationsVisible
    property bool boltVisible
    property bool bubblesVisible
    property bool breatheVisible
    property int breatheDuration
    property int breatheDelay
    property double breatheOpacity: 0.7

    // Charge bar
    property bool chargeBarTopAlign
    property bool chargeBarFlip
    property bool chargeBarFlipOnCharging
    property color chargeBarColor
    property double chargeBarOpacity
    property color chargeBarChargingColor
    property double chargeBarChargingOpacity
    property int chargeBarOffset
    property int chargeBarHeight
    property int chargeBarMargin

    // Rate bar
    property bool rateBarTopAlign
    property bool rateBarFlip
    property bool rateBarFlipOnCharging
    property color rateBarColor
    property double rateBarOpacity
    property color rateBarChargingColor
    property double rateBarChargingOpacity
    property color rateBarSegmentsColor
    property double rateBarSegmentsOpacity
    property int rateBarOffset
    property int rateBarHeight
    property int rateBarMargin
    property double rateBarRescale

    // Others
    property int batteryUpdateInterval
    property int dimensionsUpdateInterval
    property int chargeBarValueOffset
    property int rateBarValueOffset
    property int normalModeSize
    property string devicePath
}
