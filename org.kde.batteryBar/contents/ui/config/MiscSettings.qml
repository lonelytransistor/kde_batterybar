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
    id: miscSettings
    
    property alias cfg_batteryUpdateInterval: batteryUpdateIntervalSpinBox.value
    property alias cfg_dimensionsUpdateInterval: dimensionsUpdateIntervalSpinBox.value
    property alias cfg_devicePath: devicePathComboBox.devicePath

    property alias cfg_chargeBarValueOffset: chargeBarValueOffsetSpinBox.value
    property alias cfg_rateBarValueOffset: rateBarValueOffsetSpinBox.value
    property alias cfg_normalModeSize: normalModeSizeSpinBox.value
    
    QQC1.SpinBox {
        id: batteryUpdateIntervalSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Update battery info interval:")

        decimals: 1
        stepSize: 0.1
        minimumValue: 0.1
        suffix: i18ncp("@item:valuesuffix spacing to number + unit (seconds)", " second", " seconds")
    }
    QQC1.SpinBox {
        id: dimensionsUpdateIntervalSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Update applet location interval:")

        decimals: 1
        stepSize: 0.1
        minimumValue: 0.1
        suffix: i18ncp("@item:valuesuffix spacing to number + unit (seconds)", " second", " seconds")
    }
    QQC2.ComboBox {
        id: devicePathComboBox

        property string devicePath
        Kirigami.FormData.label: i18n("Device name:")

        PlasmaCore.DataSource {
            id: deviceNameDataSource
            engine: "executable"
            connectedSources: ["qdbus --literal --system org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.EnumerateDevices"]
            property var devicePaths: []

            onNewData: {
                if (data['exit code'] == 0) {
                    var _paths = data.stdout.match(/(\/\w+)+/g)
                    var paths = ["/Dummy"]
                    for (var ix=0; ix<_paths.length; ix++) {
                        paths.push(_paths[ix])
                    }
                    devicePaths = paths

                    devicePathComboBox.model.clear()
                    for (var ix=0; ix<devicePaths.length; ix++) {
                        var name = devicePaths[ix].replace(/.*?\/(\w+)$/gm, "$1")
                        devicePathComboBox.model.append({
                            "label": name,
                            "path": devicePaths[ix],
                            "name": name,
                            "ix": ix})
                    }

                    var ix = devicePaths.indexOf(devicePathComboBox.devicePath)
                    ix = ix>0 ? ix : 0
                    devicePathComboBox.currentIndex = ix
                }
            }
        }
        model: ListModel {
            ListElement {
                label: "Dummy"
                name: "Dummy"
                path: "/Dummy"
                ix: 0
            }
        }
        textRole: "label"
        onActivated: devicePath = deviceNameDataSource.devicePaths[currentIndex]
    }
    QQC1.SpinBox {
        id: chargeBarValueOffsetSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Battery charge value offset:")

        decimals: 0
        stepSize: 10
        suffix: i18ncp("@item:valuesuffix spacing to number + unit (Wh)", " Wh", " Wh")
    }
    QQC1.SpinBox {
        id: rateBarValueOffsetSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Battery rate value offset:")

        decimals: 0
        stepSize: 10
        suffix: i18ncp("@item:valuesuffix spacing to number + unit (Wh)", " Wh", " Wh")
    }
    QQC1.SpinBox {
        id: normalModeSizeSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Container size:")

        decimals: 0
        stepSize: 1
        minimumValue: 1
        suffix: i18n("px")
    }
}
