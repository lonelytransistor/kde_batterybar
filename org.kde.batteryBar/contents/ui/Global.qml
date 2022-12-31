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

Item {
    id: global

    property var getAlignment: function (vertical) {
        if (vertical) {
            return [{"label": "Top-left", "align": "top-left"},
                    {"label": "Top-right", "align": "top-right"},
                    {"label": "Bottom-left", "align": "bottom-left"},
                    {"label": "Bottom-right", "align": "bottom-right"},
                    {"label": "Top, fill left-right", "align": "fill-top"},
                    {"label": "Bottom, fill left-right", "align": "fill-bottom"}]
        } else {
            return [{"label": "Top-left", "align": "top-left"},
                    {"label": "Top-right", "align": "top-right"},
                    {"label": "Bottom-left", "align": "bottom-left"},
                    {"label": "Bottom-right", "align": "bottom-right"},
                    {"label": "Left, fill top-bottom", "align": "fill-left"},
                    {"label": "Right, fill top-bottom", "align": "fill-right"}]
        }
    }
    property var findAlignment: function (key) {
        var model = getAlignment(true)
        for (var ix = 0; ix < model.length; ix++) {
            if (model[ix].align == key)
                return ix
        }
        model = getAlignment(false)
        for (var ix = 0; ix < model.length; ix++) {
            if (model[ix].align == key)
                return ix
        }
        return 0
    }

    // Info
    property bool isVertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property bool isPlanar: (plasmoid.formFactor == PlasmaCore.Types.Planar)
    property int containerWidth: 1
    property int containerHeight: 1
    property int appletWidth: 1
    property int appletHeight: 1
    property int maxLen: 1
    property bool editMode: true

    // Battery
    property double batteryNowFraction: 0.25
    property double batteryRateFraction: 0.50
    property double batteryNowAbsolute: 1
    property double batteryRateAbsolute: 2
    property double batteryFullAbsolute: 4
    property bool batteryIsCharging: false

    // Size
    property int editModeSize: Math.max(parent ? parent.width : 32, parent ? parent.height : 32)

    // Animations
    property bool animationsVisible: plasmoid.configuration.animationsVisible
    property bool rainVisible: plasmoid.configuration.rainVisible
    property bool snowVisible: plasmoid.configuration.snowVisible
    property bool boltVisible: plasmoid.configuration.boltVisible
    property bool bubblesVisible: plasmoid.configuration.bubblesVisible
    property bool breatheVisible: plasmoid.configuration.breatheVisible
    property int breatheDuration: plasmoid.configuration.breatheDuration*1000
    property int breatheDelay: plasmoid.configuration.breatheDelay*1000
    property double breatheOpacity: 0.2

    // Charge bar
    property string chargeBarAlign: plasmoid.configuration.chargeBarAlign
    property string chargeBarChargingAlign: plasmoid.configuration.chargeBarChargingAlign
    property color chargeBarColor: plasmoid.configuration.chargeBarColor
    property double chargeBarOpacity: plasmoid.configuration.chargeBarOpacity/255
    property color chargeBarChargingColor: plasmoid.configuration.chargeBarChargingColor
    property double chargeBarChargingOpacity: plasmoid.configuration.chargeBarChargingOpacity/255
    property int chargeBarOffset: plasmoid.configuration.chargeBarOffset
    property int chargeBarHeight: plasmoid.configuration.chargeBarHeight
    property int chargeBarMargin: plasmoid.configuration.chargeBarMargin

    // Rate bar
    property string rateBarAlign: plasmoid.configuration.rateBarAlign
    property string rateBarChargingAlign: plasmoid.configuration.rateBarChargingAlign
    property color rateBarColor: plasmoid.configuration.rateBarColor
    property double rateBarOpacity: plasmoid.configuration.rateBarOpacity/255
    property color rateBarChargingColor: plasmoid.configuration.rateBarChargingColor
    property double rateBarChargingOpacity: plasmoid.configuration.rateBarChargingOpacity/255
    property color rateBarSegmentsColor: plasmoid.configuration.rateBarSegmentsColor
    property double rateBarSegmentsOpacity: plasmoid.configuration.rateBarSegmentsOpacity/255
    property int rateBarOffset: plasmoid.configuration.rateBarOffset
    property int rateBarHeight: plasmoid.configuration.rateBarHeight
    property int rateBarMargin: plasmoid.configuration.rateBarMargin
    property double rateBarRescale: plasmoid.configuration.rateBarRescale

    // Others
    property int batteryUpdateInterval: plasmoid.configuration.batteryUpdateInterval*1000
    property int dimensionsUpdateInterval: plasmoid.configuration.dimensionsUpdateInterval*1000
    property int chargeBarValueOffset: plasmoid.configuration.chargeBarValueOffset
    property int rateBarValueOffset: plasmoid.configuration.rateBarValueOffset
    property int normalModeSize: plasmoid.configuration.normalModeSize
    property string devicePath: plasmoid.configuration.devicePath
}
