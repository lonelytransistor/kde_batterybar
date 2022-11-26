/*
 * Copyright 2020 lonelytransistor
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
    id: main

    anchors.fill: parent

    property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property bool planar: (plasmoid.formFactor == PlasmaCore.Types.Planar)

    property bool initialized: false

    Layout.preferredWidth: plasmoid.configuration.spacerWidth
    Layout.minimumWidth: plasmoid.configuration.spacerWidth
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    Rectangle {
        id: chargeNow_bar
        anchors.top: {
            if (plasmoid.configuration.capacityTopAlign || plasmoid.configuration.capacityHeight == 0) {
                return parent.top
            } else {
                return undefined
            }
        }
        anchors.bottom: {
            if (!plasmoid.configuration.capacityTopAlign || plasmoid.configuration.capacityHeight == 0) {
                return parent.bottom
            } else {
                return undefined
            }
        }
        anchors.topMargin: (anchors.top ? plasmoid.configuration.capacityMargin : 0)
        anchors.bottomMargin: (anchors.bottom ? plasmoid.configuration.capacityMargin : 0)
        x: plasmoid.configuration.startOffset
        
        width: (batteryData.p_now + plasmoid.configuration.valueOffset)*Screen.width
        height: (plasmoid.configuration.capacityHeight == 0 ? undefined : plasmoid.configuration.capacityHeight)
        opacity: plasmoid.configuration.capacityOpacity/255

        color: plasmoid.configuration.capacityColor
        Behavior on width {
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
        anchors.top: {
            if (plasmoid.configuration.rateTopAlign || plasmoid.configuration.rateHeight == 0) {
                return parent.top
            } else {
                return undefined
            }
        }
        anchors.bottom: {
            if (!plasmoid.configuration.rateTopAlign || plasmoid.configuration.rateHeight == 0) {
                return parent.bottom
            } else {
                return undefined
            }
        }
        anchors.topMargin: (anchors.top ? plasmoid.configuration.rateMargin : 0)
        anchors.bottomMargin: (anchors.bottom ? plasmoid.configuration.rateMargin : 0)
        x: plasmoid.configuration.startOffset
        
        width: (plasmoid.configuration.valueRateOffset + batteryData.p_rate*plasmoid.configuration.rateRescale)*Screen.width
        height: (plasmoid.configuration.rateHeight == 0 ? undefined : plasmoid.configuration.rateHeight)
        opacity: plasmoid.configuration.rateOpacity/255

        color: plasmoid.configuration.rateColor
        Behavior on width {
            NumberAnimation {
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
    }
    
    Rectangle {
        id: animationContainer
        anchors.fill: chargeNow_bar
        color: "transparent"
        visible: false
        
        property int bubbles1_dur: 1500
        property int bubbles2_dur: 1400
        property int bubble0_dur: 1800
        property int bubble1_dur: 700
        property int bubble2_dur: 1200
        property int bubble3_dur: 600
        property int bubble4_dur: 1000
        property int bubble5_dur: 800
        property int bubble6_dur: 1200
        property int diagonalBolt_dur: 500
        property bool discharging: batteryData.b_discharging
        
        Rectangle {
            id: diagonalBolt
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "transparent"
            property double opacityCharging: (plasmoid.configuration.plugInAnimation ? 1.0 : 0.0)
            opacity: (animationContainer.discharging ? 0.0 : opacityCharging)
            
            x: (animationContainer.discharging ? -200 : Screen.width+200)
            
            Behavior on x {
                NumberAnimation {
                    duration: animationContainer.diagonalBolt_dur
                    easing.type: Easing.InQuad
                }
            }
            Rectangle {
                width: 200
                height: parent.height*4
                y: -parent.height*1.5
                transform: Rotation { origin.x: parent.width; origin.y: parent.height; angle: 30}
                
                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(parent.width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.00; color: "#00000000" }
                        GradientStop { position: 0.50; color: "#A0FFFFFF" }
                        GradientStop { position: 1.00; color: "#00000000" }
                    }
                }
                color: "transparent"
            }
        }
        Rectangle {
            id: bubbles1
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "transparent"
            property double opacityCharging: (plasmoid.configuration.plugOutAnimation ? 0.75 : 0.0)
            opacity: (animationContainer.discharging ? opacityCharging : 0.0)
            
            x: (animationContainer.discharging ? Screen.width : -200)
            
            Behavior on x {
                NumberAnimation {
                    duration: animationContainer.bubbles1_dur
                    easing.type: Easing.InOutQuad
                }
            }
            Rectangle {
                id: bubble1
                
                x: bubble2.width*6
                y: (animationContainer.discharging ? parent.height/2-height/2 : parent.height/2-height/4)
                width: parent.height/2
                height: width
                visible: false
                
                Behavior on y {
                    NumberAnimation {
                        duration: animationContainer.bubble1_dur
                        easing.type: Easing.OutInBounce
                    }
                }
                
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: parent.width/4
                    verticalOffset: parent.width/4
                    gradient: Gradient {
                        GradientStop { position: 0.2; color: "#60FFFFFF" }
                        GradientStop { position: 1.0; color: "#10000000" }
                    }
                }
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: width*0.5
            }
            OpacityMask {
                anchors.fill: bubble1
                source: bubble1
                maskSource: Rectangle {
                    width: bubble1.height
                    height: bubble1.width
                    radius: bubble1.radius
                }
            }
            Rectangle {
                id: bubble2
                
                x: bubble3.width*2
                y: (animationContainer.discharging ? height : parent.height/2)
                width: parent.height/4
                height: width
                visible: false
                
                Behavior on y {
                    NumberAnimation {
                        duration: animationContainer.bubble2_dur
                        easing.type: Easing.InOutBounce
                    }
                }
                
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: parent.width/4
                    verticalOffset: parent.width/4
                    gradient: Gradient {
                        GradientStop { position: 0.2; color: "#60FFFFFF" }
                        GradientStop { position: 1.0; color: "#10000000" }
                    }
                }
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: width*0.5
            }
            OpacityMask {
                anchors.fill: bubble2
                source: bubble2
                maskSource: Rectangle {
                    width: bubble2.height
                    height: bubble2.width
                    radius: bubble2.radius
                }
            }
            Rectangle {
                id: bubble3
                
                y: (animationContainer.discharging ? parent.height-height : 0)
                width: parent.height/8
                height: width
                visible: false
                
                Behavior on y {
                    NumberAnimation {
                        duration: animationContainer.bubble3_dur
                        easing.type: Easing.OutInBounce
                    }
                }
                
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: parent.width/4
                    verticalOffset: -parent.width/4
                    gradient: Gradient {
                        GradientStop { position: 0.2; color: "#60FFFFFF" }
                        GradientStop { position: 1.0; color: "#10000000" }
                    }
                }
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: width*0.5
            }
            OpacityMask {
                anchors.fill: bubble3
                source: bubble3
                maskSource: Rectangle {
                    width: bubble3.height
                    height: bubble3.width
                    radius: bubble3.radius
                }
            }
        }
        Rectangle {
            id: bubbles2
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "transparent"
            property double opacityCharging: (plasmoid.configuration.plugOutAnimation ? 0.75 : 0.0)
            opacity: (animationContainer.discharging ? opacityCharging : 0.0)
            
            x: (animationContainer.discharging ? Screen.width : -200)
            
            Behavior on x {
                NumberAnimation {
                    duration: animationContainer.bubbles2_dur
                    easing.type: Easing.InOutQuad
                }
            }
            
            Rectangle {
                id: bubble4
                
                y: (animationContainer.discharging ? height : height/4)
                width: parent.height/3
                height: width
                visible: false
                
                Behavior on y {
                    NumberAnimation {
                        duration: animationContainer.bubble4_dur
                        easing.type: Easing.OutInBounce
                    }
                }
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: parent.width/4
                    verticalOffset: parent.width/4
                    gradient: Gradient {
                        GradientStop { position: 0.2; color: "#60FFFFFF" }
                        GradientStop { position: 1.0; color: "#10000000" }
                    }
                }
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: width*0.5
            }
            OpacityMask {
                anchors.fill: bubble4
                source: bubble4
                maskSource: Rectangle {
                    width: bubble4.height
                    height: bubble4.width
                    radius: bubble4.radius
                }
            }
            Rectangle {
                id: bubble5
                
                x: bubble4.width*3
                y: (animationContainer.discharging ? height/2 : height*2)
                width: parent.height/4
                height: width
                visible: false
                
                Behavior on y {
                    NumberAnimation {
                        duration: animationContainer.bubble5_dur
                        easing.type: Easing.InOutBounce
                    }
                }
                
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: parent.width/4
                    verticalOffset: parent.width/4
                    gradient: Gradient {
                        GradientStop { position: 0.2; color: "#60FFFFFF" }
                        GradientStop { position: 1.0; color: "#10000000" }
                    }
                }
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: width*0.5
            }
            OpacityMask {
                anchors.fill: bubble5
                source: bubble5
                maskSource: Rectangle {
                    width: bubble5.height
                    height: bubble5.width
                    radius: bubble5.radius
                }
            }
            Rectangle {
                id: bubble6
                
                y: (animationContainer.discharging ? height/3 : parent.height-height-height/3)
                width: parent.height/6
                height: width
                visible: false
                
                Behavior on y {
                    NumberAnimation {
                        duration: animationContainer.bubble6_dur
                        easing.type: Easing.InOutBounce
                    }
                }
                
                RadialGradient {
                    anchors.fill: parent
                    horizontalOffset: parent.width/4
                    verticalOffset: -parent.width/4
                    gradient: Gradient {
                        GradientStop { position: 0.2; color: "#60FFFFFF" }
                        GradientStop { position: 1.0; color: "#10000000" }
                    }
                }
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: width*0.5
            }
            OpacityMask {
                anchors.fill: bubble6
                source: bubble6
                maskSource: Rectangle {
                    width: bubble6.height
                    height: bubble6.width
                    radius: bubble6.radius
                }
            }
        }
    }
    OpacityMask {
        anchors.fill: animationContainer
        source: animationContainer
        maskSource: Rectangle {
            width: animationContainer.height
            height: animationContainer.width
            radius: animationContainer.radius
        }
    }
    
    PlasmaCore.DataSource {
        id: batteryData
        engine: "executable"
        connectedSources: []
        
        property double p_now: 0
        property double p_rate: 0
        property double e_now: 0
        property double e_rate: 0
        property double e_full: 0
        property int b_state: 0
        property bool b_discharging: false
        property bool b_charging: false
        
        property var batteryCMDs: {}
        property var devicePath: plasmoid.configuration.devicePath
        onDevicePathChanged: {
            if (devicePath) {
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
            } else {
                p_now = 0.5
                p_rate = 0.25
            }
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
            }
        }
        interval: plasmoid.configuration.updateInterval*1000
    }
}
