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
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

QtObject {
    id: root

    // Info
    property bool isVertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    onIsVerticalChanged: Global.isVertical = isVertical
    property bool isPlanar: (plasmoid.formFactor == PlasmaCore.Types.Planar)
    onIsPlanarChanged: Global.isPlanar = isPlanar
    property int maxLen: 1
    onMaxLenChanged: Global.maxLen = maxLen
    property bool editMode: false
    onEditModeChanged: Global.editMode = editMode

    // Animations
    property bool animationsVisible: plasmoid.configuration.animationsVisible
    onAnimationsVisibleChanged: Global.animationsVisible = animationsVisible
    property bool boltVisible: plasmoid.configuration.boltVisible
    onBoltVisibleChanged: Global.boltVisible = boltVisible
    property bool bubblesVisible: plasmoid.configuration.bubblesVisible
    onBubblesVisibleChanged: Global.bubblesVisible = bubblesVisible
    property bool breatheVisible: plasmoid.configuration.breatheVisible
    onBreatheVisibleChanged: Global.breatheVisible = breatheVisible
    property int breatheDuration: plasmoid.configuration.breatheDuration*1000
    onBreatheDurationChanged: Global.breatheDuration = breatheDuration
    property int breatheDelay: plasmoid.configuration.breatheDelay*1000
    onBreatheDelayChanged: Global.breatheDelay = breatheDelay

    // Charge bar
    property bool chargeBarTopAlign: plasmoid.configuration.chargeBarTopAlign
    onChargeBarTopAlignChanged: Global.chargeBarTopAlign = chargeBarTopAlign
    property bool chargeBarFlip: plasmoid.configuration.chargeBarFlip
    onChargeBarFlipChanged: Global.chargeBarFlip = chargeBarFlip
    property bool chargeBarFlipOnCharging: plasmoid.configuration.chargeBarFlipOnCharging
    onChargeBarFlipOnChargingChanged: Global.chargeBarFlipOnCharging = chargeBarFlipOnCharging
    property color chargeBarColor: plasmoid.configuration.chargeBarColor
    onChargeBarColorChanged: Global.chargeBarColor = chargeBarColor
    property double chargeBarOpacity: plasmoid.configuration.chargeBarOpacity/255
    onChargeBarOpacityChanged: Global.chargeBarOpacity = chargeBarOpacity
    property color chargeBarChargingColor: plasmoid.configuration.chargeBarChargingColor
    onChargeBarChargingColorChanged: Global.chargeBarChargingColor = chargeBarChargingColor
    property double chargeBarChargingOpacity: plasmoid.configuration.chargeBarChargingOpacity/255
    onChargeBarChargingOpacityChanged: Global.chargeBarChargingOpacity = chargeBarChargingOpacity
    property int chargeBarOffset: plasmoid.configuration.chargeBarOffset
    onChargeBarOffsetChanged: Global.chargeBarOffset = chargeBarOffset
    property int chargeBarHeight: plasmoid.configuration.chargeBarHeight
    onChargeBarHeightChanged: Global.chargeBarHeight = chargeBarHeight
    property int chargeBarMargin: plasmoid.configuration.chargeBarMargin
    onChargeBarMarginChanged: Global.chargeBarMargin = chargeBarMargin

    // Rate bar
    property bool rateBarTopAlign: plasmoid.configuration.rateBarTopAlign
    onRateBarTopAlignChanged: Global.rateBarTopAlign = rateBarTopAlign
    property bool rateBarFlip: plasmoid.configuration.rateBarFlip
    onRateBarFlipChanged: Global.rateBarFlip = rateBarFlip
    property bool rateBarFlipOnCharging: plasmoid.configuration.rateBarFlipOnCharging
    onRateBarFlipOnChargingChanged: Global.rateBarFlipOnCharging = rateBarFlipOnCharging
    property color rateBarColor: plasmoid.configuration.rateBarColor
    onRateBarColorChanged: Global.rateBarColor = rateBarColor
    property double rateBarOpacity: plasmoid.configuration.rateBarOpacity/255
    onRateBarOpacityChanged: Global.rateBarOpacity = rateBarOpacity
    property color rateBarChargingColor: plasmoid.configuration.rateBarChargingColor
    onRateBarChargingColorChanged: Global.rateBarChargingColor = rateBarChargingColor
    property double rateBarChargingOpacity: plasmoid.configuration.rateBarChargingOpacity/255
    onRateBarChargingOpacityChanged: Global.rateBarChargingOpacity = rateBarChargingOpacity
    property color rateBarSegmentsColor: plasmoid.configuration.rateBarSegmentsColor
    onRateBarSegmentsColorChanged: Global.rateBarSegmentsColor = rateBarSegmentsColor
    property double rateBarSegmentsOpacity: plasmoid.configuration.rateBarSegmentsOpacity/255
    onRateBarSegmentsOpacityChanged: Global.rateBarSegmentsOpacity = rateBarSegmentsOpacity
    property int rateBarOffset: plasmoid.configuration.rateBarOffset
    onRateBarOffsetChanged: Global.rateBarOffset = rateBarOffset
    property int rateBarHeight: plasmoid.configuration.rateBarHeight
    onRateBarHeightChanged: Global.rateBarHeight = rateBarHeight
    property int rateBarMargin: plasmoid.configuration.rateBarMargin
    onRateBarMarginChanged: Global.rateBarMargin = rateBarMargin
    property double rateBarRescale: plasmoid.configuration.rateBarRescale
    onRateBarRescaleChanged: Global.rateBarRescale = rateBarRescale

    // Others
    property int batteryUpdateInterval: plasmoid.configuration.batteryUpdateInterval*1000
    onBatteryUpdateIntervalChanged: Global.batteryUpdateInterval = batteryUpdateInterval
    property int dimensionsUpdateInterval: plasmoid.configuration.dimensionsUpdateInterval*1000
    onDimensionsUpdateIntervalChanged: Global.dimensionsUpdateInterval = dimensionsUpdateInterval
    property int chargeBarValueOffset: plasmoid.configuration.chargeBarValueOffset
    onChargeBarValueOffsetChanged: Global.chargeBarValueOffset = chargeBarValueOffset
    property int rateBarValueOffset: plasmoid.configuration.rateBarValueOffset
    onRateBarValueOffsetChanged: Global.rateBarValueOffset = rateBarValueOffset
    property int normalModeSize: plasmoid.configuration.normalModeSize
    onNormalModeSizeChanged: Global.normalModeSize = normalModeSize
    property string devicePath: plasmoid.configuration.devicePath
    onDevicePathChanged: Global.devicePath = devicePath
}
