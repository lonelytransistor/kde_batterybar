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

    property string devicePath: Global.devicePath
    onDevicePathChanged: update()
    onParentChanged: update()
    function update() {
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

    PlasmaCore.DataSource {
        id: pmSource

        engine: "powermanagement"
        connectedSources: []

        property int batteryPercent
        property double batteryIsCharging
        property double batteryNow
        property double batteryRate
        property double batteryFull
        property string devicePath
        onDevicePathChanged: {
            if (devicePath) {
                connectedSources = ["Battery", devicePath]
            } else {
                connectedSources = []
            }
        }
        onDataChanged: {
            if (data[devicePath]) {
                batteryPercent = data[devicePath]["Percent"]
                batteryNow = data[devicePath]["Energy"]
                batteryRate = batteryNow / (data["Battery"]["Remaining msec"]/(3600*1000))
                batteryFull = 100*batteryNow/batteryPercent
                batteryIsCharging = data[devicePath]["State"] != "Discharging"

                if (Global.batteryPercent != batteryPercent)
                    Global.batteryPercent = batteryPercent
                if (Global.batteryNow != batteryNow)
                    Global.batteryNow = batteryNow
                if (Global.batteryRate != batteryRate)
                    Global.batteryRate = batteryRate
                if (Global.batteryFull != batteryFull)
                    Global.batteryFull = batteryFull
                if (Global.batteryIsCharging != batteryIsCharging)
                    Global.batteryIsCharging = batteryIsCharging
            }
        }
    }
    PlasmaCore.DataSource {
        id: dbusSource
        engine: "executable"
        connectedSources: []
        property var batteryCMDs: {}

        property int errorCount: 0
        readonly property int errorMax: 10
        property string devicePath
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
                        if (tmp_var > 0 && tmp_var <= 100)
                            Global.batteryPercent = tmp_var
                        if (Global.batteryFull > 0 && Math.round(100*Global.batteryNow/Global.batteryFull) != Global.batteryPercent) {
                            if (Global.batteryFull > 0 && Global.batteryFull >= Global.batteryNow) {
                                tmp_var = Global.batteryPercent*Global.batteryFull/100
                                if (Global.batteryNow != tmp_var)
                                    Global.batteryNow = tmp_var
                            } else if (Global.batteryNow > 0 && Global.batteryPercent != 0) {
                                tmp_var = 100*Global.batteryNow/Global.batteryPercent
                                if (Global.batteryFull != tmp_var)
                                    Global.batteryFull = tmp_var
                            } else {
                                if (Global.batteryNow != Global.batteryPercent)
                                    Global.batteryNow = Global.batteryPercent
                                if (Global.batteryFull != 100)
                                    Global.batteryFull = 100
                                console.log("Missing battery data, roughly extrapolated, but energy rate measurement will be invalid.")
                            }
                        }
                    break
                    case 'e_now':
                        if (tmp_var > 0) {
                            if (Global.batteryNow != tmp_var)
                                Global.batteryNow = tmp_var
                            if (Global.batteryFull > 0 && Global.batteryIsCharging && Global.batteryNow/Global.batteryFull > 0.95)
                                Global.batteryIsCharging = false
                        }
                    break
                    case 'e_rate':
                        if (tmp_var > 0 && Global.batteryRate != tmp_var)
                            Global.batteryRate = tmp_var
                    break
                    case 'e_full':
                        if (tmp_var != 0 && tmp_var > Global.batteryNow && Global.batteryFull != tmp_var) {
                            Global.batteryFull = tmp_var
                        } else if (Global.batteryNow > 0 && Global.batteryPercent > 0) {
                            tmp_var = 100*Global.batteryNow/Global.batteryPercent
                            Global.batteryFull = tmp_var
                            console.log("Invalid battery capacity returned by UPower. Extrapolated.")
                        }
                    break
                    case 'b_state':
                        if (tmp_var != 2 && Global.batteryFull > 0 && Global.batteryIsCharging && Global.batteryNow/Global.batteryFull > 0.95) {
                            Global.batteryIsCharging = false
                        } else if (tmp_var != 2) {
                            if (!Global.batteryIsCharging)
                                Global.batteryIsCharging = true
                        } else if (Global.batteryIsCharging) {
                            Global.batteryIsCharging = false
                        }
                    break
                    default:
                    break
                }
                errorCount = 0
            } else {
                if (errorCount >= errorMax) {
                    if (!Global.batteryNow && Global.batteryNow != 2)
                        Global.batteryNow = 2
                    if (!Global.batteryRate && Global.batteryRate != 1)
                        Global.batteryRate = 1
                    if (!Global.batteryFull && Global.batteryFull != 4)
                        Global.batteryFull = 4
                    Global.batteryIsCharging = !Global.batteryIsCharging
                } else {
                    errorCount += 1
                }
            }
        }
        interval: Global.batteryUpdateInterval
    }
}
