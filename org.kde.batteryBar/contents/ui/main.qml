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

Item {
    id: root

    anchors.fill: parent
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property bool planar: (plasmoid.formFactor == PlasmaCore.Types.Planar)
    property int spacerWidth: plasmoid.configuration.spacerWidth
    property var containmentInterface: null
    property bool editMode: pEditMode
    readonly property bool pEditMode: containmentInterface ? containmentInterface.editMode : false
    readonly property int editModeSize: 32
    onParentChanged: {
        if (parent) {
            for (var obj = root, depth = 0; !!obj; obj = obj.parent, depth++) {
                if (obj.toString().startsWith('ContainmentInterface')) {
                    if (typeof obj['editMode'] === 'boolean') {
                        root.containmentInterface = obj
                        break
                    }
                } else if (obj.toString().startsWith('DeclarativeDropArea')) {
                    if (typeof obj['Plasmoid'] !== 'undefined' && obj['Plasmoid'].toString().startsWith('ContainmentInterface')) {
                        if (typeof obj['Plasmoid']['editMode'] === 'boolean') {
                            root.containmentInterface = obj.Plasmoid
                            break
                        }
                    }
                }
            }
        }
    }
    onPEditModeChanged: {
        editModeDelay.running = true
    }
    onEditModeChanged: {
        let _width = editMode ? editModeSize : root.spacerWidth
        root.Layout.preferredWidth = _width
        root.Layout.minimumWidth = _width
        root.width = _width
        root.Layout.preferredHeight = _width
        root.Layout.minimumHeight = _width
        root.height = _width
    }
    onSpacerWidthChanged: {
        let _width = editMode ? editModeSize : root.spacerWidth
        root.Layout.preferredWidth = _width
        root.Layout.minimumWidth = _width
        root.width = _width
        root.Layout.preferredHeight = _width
        root.Layout.minimumHeight = _width
        root.height = _width
    }
    Timer {
        id: editModeDelay
        interval: 1
        running: false
        repeat: false
        onTriggered: root.editMode = root.pEditMode
    }
    Image {
        anchors.fill: parent
        source: "/usr/share/icons/breeze/status/32/battery-full-charging.svg"
        visible: root.editMode
    }


    Rectangle {
        id: chargeNow_bar
        anchors.top:    (( plasmoid.configuration.capacityTopAlign || plasmoid.configuration.capacityHeight == 0) && !root.vertical) ? parent.top    : undefined
        anchors.bottom: ((!plasmoid.configuration.capacityTopAlign || plasmoid.configuration.capacityHeight == 0) && !root.vertical) ? parent.bottom : undefined
        anchors.left:   (( plasmoid.configuration.capacityTopAlign || plasmoid.configuration.capacityHeight == 0) &&  root.vertical) ? parent.left   : undefined
        anchors.right:  ((!plasmoid.configuration.capacityTopAlign || plasmoid.configuration.capacityHeight == 0) &&  root.vertical) ? parent.right  : undefined

        anchors.topMargin:    anchors.top    ? plasmoid.configuration.capacityMargin : 0
        anchors.bottomMargin: anchors.bottom ? plasmoid.configuration.capacityMargin : 0
        anchors.leftMargin:   anchors.left   ? plasmoid.configuration.capacityMargin : 0
        anchors.rightMargin:  anchors.right  ? plasmoid.configuration.capacityMargin : 0

        x: !root.vertical ? plasmoid.configuration.startOffset : undefined
        y:  root.vertical ? plasmoid.configuration.startOffset : undefined
        
        property var thickness: plasmoid.configuration.capacityHeight == 0 ? undefined : plasmoid.configuration.capacityHeight
        property var length:    (batteryData.p_now + plasmoid.configuration.valueOffset)*(root.vertical ? Screen.height : Screen.width)
        width:  root.vertical ? thickness : length
        height: root.vertical ? length : thickness
        opacity: plasmoid.configuration.capacityOpacity/255

        color: plasmoid.configuration.capacityColor
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
        
        Rectangle {
            id: chargeBreathing
            anchors.fill: parent
            color: "white"
            property double chargingOpacity: 0.7
            visible: (batteryData.b_charging && plasmoid.configuration.chargingAnimation)
            
            SequentialAnimation {
                running: (batteryData.b_charging && plasmoid.configuration.chargingAnimation)
                loops: Animation.Infinite
                PropertyAnimation {
                    target: chargeBreathing
                    property: "opacity"
                    
                    from: 0.0
                    to: chargeBreathing.chargingOpacity
                    
                    duration: plasmoid.configuration.chargingAnimationSpeed*1000
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    target: chargeBreathing
                    property: "opacity"
                    
                    from: chargeBreathing.chargingOpacity
                    to: 0.0
                    
                    duration: plasmoid.configuration.chargingAnimationSpeed*1000
                    easing.type: Easing.InOutQuad
                }
                PauseAnimation {
                    duration: plasmoid.configuration.chargingAnimationDelay*1000
                }
            }
        }
    }
    Rectangle {
        id: chargeRate_bar

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
        width: root.vertical ? thickness : length
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
    Repeater {
        model: 10
        Rectangle {
            anchors.top: chargeRate_bar.top
            anchors.bottom: chargeRate_bar.bottom

            color: plasmoid.configuration.rateSegmentsColor
            opacity: plasmoid.configuration.rateSegmentsOpacity/255

            x: chargeRate_bar.length*(2+index) - 2
            width: 4
            visible: plasmoid.configuration.showSegments
        }
    }

    AnimationContainer {
        anchors.fill: chargeNow_bar

        vertical: root.vertical
        maxWidth: root.vertical ? Screen.height : Screen.width
        discharging: batteryData.b_discharging
        plugOutAnimation: plasmoid.configuration.plugOutAnimation
        plugInAnimation: plasmoid.configuration.plugInAnimation
    }
    
    PlasmaCore.DataSource {
        id: batteryData
        engine: "executable"
        connectedSources: []
        
        property double p_now: 0.5
        property double p_rate: 0.25
        property double e_now: 0
        property double e_rate: 0
        property double e_full: 0
        property int b_state: 0
        property bool b_discharging: false
        property bool b_charging: false

        property int errorCount: 0
        readonly property int errorMax: 10
        
        property var batteryCMDs: {}
        property string devicePath: plasmoid.configuration.devicePath
        onDevicePathChanged: {
            var dbusPrefix = 'qdbus --system org.freedesktop.UPower '
            var dbusSuffix = ' org.freedesktop.UPower.Device.'

            batteryCMDs = {}
            batteryCMDs[dbusPrefix + devicePath + dbusSuffix + 'Percentage'] = 'p_now'
            batteryCMDs[dbusPrefix + devicePath + dbusSuffix + 'Energy'] = 'e_now'
            batteryCMDs[dbusPrefix + devicePath + dbusSuffix + 'EnergyRate'] = 'e_rate'
            batteryCMDs[dbusPrefix + devicePath + dbusSuffix + 'EnergyFull'] = 'e_full'
            batteryCMDs[dbusPrefix + devicePath + dbusSuffix + 'State'] = 'b_state'

            connectedSources = []
            var keys = Object.keys(batteryCMDs)
            for (const key in keys) {
                if (batteryCMDs.hasOwnProperty(keys[key])) {
                    connectedSources.push(keys[key])
                }
            }
            errorCount = 0
        }
                
        onNewData: {
            if (data['exit code'] == 0) {
                var tmp_var = parseFloat(data.stdout)
                switch (batteryCMDs[sourceName]) {
                    case 'p_now':
                        p_now = tmp_var*0.01
                    break
                    case 'e_now':
                        e_now = tmp_var
                        
                        if (e_full > 0) {
                            if (b_charging && (e_now/e_full > 0.95 || p_now > 0.95)) {
                                b_charging = false
                            }
                        }
                    break
                    case 'e_rate':
                        e_rate = tmp_var
                        
                        if (p_now > 0) {
                            if (e_now/p_now > 0) {
                                p_rate = e_rate/(e_now/p_now)
                            }
                        }
                    break
                    case 'e_full':
                        e_full = tmp_var
                    break
                    case 'b_state':
                        b_state = tmp_var
                        
                        b_discharging = (tmp_var == 2)
                        if (e_full > 0) {
                            if (tmp_var != 2 && (e_now/e_full > 0.95 || p_now > 0.95)) {
                                b_charging = false
                            } else if (tmp_var != 2) {
                                b_charging = true
                            } else {
                                b_charging = false
                            }
                        }
                    break
                    default:
                    break
                }
                errorCount = 0
            } else {
                errorCount += 1
                console.log(devicePath + ":" + data.stderr)
                if (errorCount >= errorMax) {
                    if (!p_now)
                        p_now = 0.5
                    if (!p_rate)
                        p_rate = 0.25
                    errorCount = errorMax
                }
            }
        }
        interval: plasmoid.configuration.updateInterval*1000
    }
}
