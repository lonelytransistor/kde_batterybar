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
import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Controls 1.4 as QQC1

import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls
import org.kde.plasma.core 2.0 as PlasmaCore

Kirigami.FormLayout {
    id: sourceSettings

    property alias cfg_batteryUpdateInterval: batteryUpdateIntervalSpinBox.value
    property alias cfg_devicePath: devicePathComboBox.devicePath

    QQC2.ComboBox {
        id: devicePathComboBox

        property string devicePath
        Kirigami.FormData.label: i18n("Device name:")
        property var devicePathsDBus: []
        property var devicePathsPM: []
        property var devicePaths: []
        onDevicePathsDBusChanged: updateData()
        onDevicePathsPMChanged: updateData()
        function updateModel(type, paths) {
            let _paths = []
            for (let ix=0; paths && ix<paths.length; ix++) {
                let re = /^(.*?(\w+))$/g
                let match = re.exec(paths[ix])
                let data = {"label": type + ": " + match[2], "path": type + ":" + match[1]}
                _paths.push(data.path)
                devicePathComboBox.model.append(data)
            }
            return _paths
        }
        function updateData() {
            devicePathComboBox.model.clear()
            devicePaths = updateModel("dBus", devicePathsDBus)
            devicePaths = devicePaths.concat(updateModel("PM", devicePathsPM))
            let ix = devicePaths.indexOf(devicePathComboBox.devicePath)
            ix = ix>0 ? ix : 0
            devicePathComboBox.currentIndex = ix
        }

        PlasmaCore.DataSource {
            id: deviceNameDBusSource
            engine: "executable"
            connectedSources: ["qdbus --literal --system org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.EnumerateDevices"]
            property alias devicePaths: devicePathComboBox.devicePathsDBus

            onNewData: {
                if (data['exit code'] == 0) {
                    let _paths = data.stdout.match(/(\/\w+)+/g)
                    let paths = ["/Dummy"]
                    for (let ix=0; ix<_paths.length; ix++) {
                        paths.push(_paths[ix])
                    }
                    devicePaths = paths
                }
            }
        }
        PlasmaCore.DataSource {
            id: deviceNamePMSource
            engine: "powermanagement"
            connectedSources: ["Battery"]
            property alias devicePaths: devicePathComboBox.devicePathsPM

            onSourceAdded: {
                disconnectSource(source)
                connectSource(source)
            }
            onSourceRemoved: disconnectSource(source)
            onDataChanged: {
                console.log(JSON.stringify(data))
                let _paths = data["Battery"]["Sources"]
                let paths = []
                for (let ix=0; ix<_paths.length; ix++) {
                    paths.push(_paths[ix])
                }
                devicePaths = paths
            }
        }
        model: ListModel {
            ListElement {
                label: "Dummy"
                type: "dbus"
            }
        }
        textRole: "label"
        onActivated: {
            devicePath = model.get(currentIndex).path
            console.log(devicePath)
        }
    }
    QQC1.SpinBox {
        id: batteryUpdateIntervalSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Update rate data interval (dBus sources only):")

        decimals: 1
        stepSize: 0.1
        minimumValue: 0.1
        suffix: i18ncp("@item:valuesuffix spacing to number + unit (seconds)", " second", " seconds")
    }
    QQC2.Label {
        text: "There are two types of sources for battery data: dBus and PM:\n- Discharge/charge rate obtained from a dBus source is refreshed periodically\n  and as such it may draw more energy. However rate data itself is more\n  precise in terms of value. If interval is equal to 0, data is only refreshed\n  when battery charge changes.\n- Data from PM is obtained instantaneously and does not require polling.\n  However it may provide less precise data for discharge rate."
    }
}
