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
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    property string devicePath: rootItem.global.devicePath
    onDevicePathChanged: updateSources()
    onParentChanged: updateSources()
    function updateSources() {
        let re = /^(dBus|PM):(.*)$/g
        let match = re.exec(devicePath)
        if (match && match.length >= 3) {
            let type = match[1]
            let path = match[2]

            pmSource.devicePath = ""
            dbusSource.devicePath = ""
            if (type == "dBus") {
                dbusSource.devicePath = path
            } else if (type == "PM") {
                pmSource.devicePath = path
            }
        }
    }
    function truncateBattery(battery) {
        battery.nowFraction = Math.round(battery.nowFraction*100)*0.01
        battery.rateFraction = Math.round(battery.rateFraction*100)*0.01
        battery.nowAbsolute = Math.round(battery.nowAbsolute*100)*0.01
        battery.rateAbsolute = Math.round(battery.rateAbsolute*100)*0.01
        battery.fullAbsolute = Math.round(battery.fullAbsolute*100)*0.01
        return battery
    }
    function extrapolateBattery(battery) {
        if (Math.round(battery.nowFraction*battery.fullAbsolute) != Math.round(battery.nowAbsolute)  &&  battery.fullAbsolute > battery.nowAbsolute) {
            battery.nowAbsolute = battery.nowFraction*battery.fullAbsolute
        }
        if (battery.fullAbsolute < battery.nowAbsolute) {
            battery.fullAbsolute = battery.nowAbsolute/battery.nowFraction
        }
        if (battery.nowFraction > 0.95) {
            battery.isCharging = false
        }
        if (Math.round(100*battery.rateFraction) != Math.round(100*battery.rateAbsolute/battery.fullAbsolute)) {
            battery.rateFraction = battery.rateAbsolute/battery.fullAbsolute
        }
        return battery
    }
    function updateBattery(battery) {
        if (rootItem.global.batteryNowFraction  != battery.nowFraction)
            rootItem.global.batteryNowFraction   = battery.nowFraction
        if (rootItem.global.batteryRateFraction != battery.rateFraction)
            rootItem.global.batteryRateFraction  = battery.rateFraction
        if (rootItem.global.batteryNowAbsolute  != battery.nowAbsolute)
            rootItem.global.batteryNowAbsolute   = battery.nowAbsolute
        if (rootItem.global.batteryRateAbsolute != battery.rateAbsolute)
            rootItem.global.batteryRateAbsolute  = battery.rateAbsolute
        if (rootItem.global.batteryFullAbsolute != battery.fullAbsolute)
            rootItem.global.batteryFullAbsolute  = battery.fullAbsolute
        if (rootItem.global.batteryIsCharging   != battery.isCharging)
            rootItem.global.batteryIsCharging    = battery.isCharging
    }

    PlasmaCore.DataSource {
        id: pmSource

        engine: "powermanagement"
        connectedSources: ["Battery"]

        property var battery: {
            "nowFraction": 0.0,
            "rateFraction": 0.0,
            "nowAbsolute": 0,
            "rateAbsolute": 0,
            "fullAbsolute": 0,
            "isCharging": false
        }
        property string devicePath: ""
        onDevicePathChanged: {
            if (devicePath) {
                connectedSources = ["Battery", devicePath]
            } else {
                connectedSources = ["Battery"]
            }
        }
        onDataChanged: {
            if (devicePath != "" && data[devicePath]) {
                let remainingHours = Math.max(0, (data["Battery"]["Remaining msec"] & 0xFFFFFF)/(3600*1000))

                battery.nowFraction  = data[devicePath]["Percent"]*0.01
                battery.rateFraction = battery.nowFraction / remainingHours
                battery.isCharging   = battery.nowFraction < 0.95 ? (data[devicePath]["State"] != "Discharging") : false

                battery.nowAbsolute  = data[devicePath]["Energy"]
                battery.fullAbsolute = battery.nowAbsolute / battery.nowFraction
                battery.rateAbsolute = battery.isCharging ? (battery.fullAbsolute - battery.nowAbsolute / remainingHours) : battery.nowAbsolute / remainingHours

                updateBattery(extrapolateBattery(truncateBattery(battery)))
            } else if (devicePath == "" && connectedSources.size == 1) {
                connectedSources.push(data["Battery"]["Sources"])
            } else if (devicePath == "") {
                dbusSource.interval = 1000
            }
        }
    }
    PlasmaCore.DataSource {
        id: dbusSource
        engine: "executable"
        connectedSources: []
        property var batteryCMDs: {}
        property var battery: {
            "nowFraction": 0.0,
            "rateFraction": 0.0,
            "nowAbsolute": 0,
            "rateAbsolute": 0,
            "fullAbsolute": 0,
            "isCharging": false
        }

        property int errorCount: 0
        property string devicePath: ""
        property int sourcesProcessed: 0

        readonly property int errorMax: 10
        onDevicePathChanged: {
            if (devicePath) {
                let dbusPath = 'qdbus --system org.freedesktop.UPower ' + devicePath + ' org.freedesktop.UPower.Device.'

                batteryCMDs = {}
                batteryCMDs[dbusPath + 'Percentage'] = 'p_now'
                batteryCMDs[dbusPath + 'Energy'] = 'e_now'
                batteryCMDs[dbusPath + 'EnergyRate'] = 'e_rate'
                batteryCMDs[dbusPath + 'EnergyFull'] = 'e_full'
                batteryCMDs[dbusPath + 'State'] = 'b_state'

                connectedSources = []
                var keys = Object.keys(batteryCMDs)
                for (const key in keys) {
                    if (batteryCMDs.hasOwnProperty(keys[key])) {
                        connectedSources.push(keys[key])
                    }
                }
                errorCount = 0
            } else {
                connectedSources = []
            }
        }

        onNewData: {
            if (data['exit code'] == 0) {
                var tmp_var = parseFloat(data.stdout)
                switch (batteryCMDs[sourceName]) {
                    case 'p_now':
                        if (tmp_var > 0 && tmp_var <= 100) {
                            battery.nowFraction = tmp_var*0.01
                        }
                    break
                    case 'e_now':
                        if (tmp_var > 0) {
                            battery.nowAbsolute = tmp_var
                        }
                    break
                    case 'e_rate':
                        if (tmp_var > 0) {
                            battery.rateAbsolute = tmp_var
                        }
                    break
                    case 'e_full':
                        if (tmp_var > battery.nowAbsolute) {
                            battery.fullAbsolute = tmp_var
                        }
                    break
                    case 'b_state':
                        battery.isCharging = tmp_var != 2
                    break
                    default:
                    break
                }
                errorCount = 0
                sourcesProcessed += 1
                if (sourcesProcessed == connectedSources.length) {
                    interval = rootItem.global.batteryUpdateInterval
                    updateBattery(extrapolateBattery(truncateBattery(battery)))
                    sourcesProcessed = 0
                }
            } else {
                if (errorCount >= errorMax) {
                    if (!battery.nowFraction)
                        battery.nowFraction = 2
                    if (!battery.rateFraction)
                        battery.rateFraction = 1
                    battery.isCharging = !battery.isCharging
                } else {
                    errorCount += 1
                }
            }
        }
        interval: rootItem.global.batteryUpdateInterval
    }
}
