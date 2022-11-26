import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Controls 1.4 as QQC1

import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls
import org.kde.plasma.core 2.0 as PlasmaCore

Kirigami.FormLayout {
    id: miscSettings
    
    property alias cfg_updateInterval: updateIntervalSpinBox.value
    property alias cfg_valueOffset: valueOffsetSpinBox.value
    property alias cfg_valueRateOffset: valueRateOffsetSpinBox.value
    property alias cfg_devicePath: deviceNameComboBox.devicePath
    
    QQC1.SpinBox {
        id: updateIntervalSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Update interval:")

        decimals: 1
        stepSize: 0.1
        minimumValue: 0.1
        suffix: i18ncp("@item:valuesuffix spacing to number + unit (seconds)", " second", " seconds")
    }
    QQC1.SpinBox {
        id: valueOffsetSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Battery charge offset value:")

        decimals: 2
        stepSize: 0.01
        maximumValue: 1.0
        minimumValue: -1.0
    }
    QQC1.SpinBox {
        id: valueRateOffsetSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Battery discharge offset value:")

        decimals: 2
        stepSize: 0.01
        maximumValue: 1.0
        minimumValue: -1.0
    }
    QQC2.ComboBox {
        id: deviceNameComboBox

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

                    deviceNameComboBox.model.clear()
                    for (var ix=0; ix<devicePaths.length; ix++) {
                        var name = devicePaths[ix].replace(/.*?\/(\w+)$/gm, "$1")
                        deviceNameComboBox.model.append({
                            "label": name,
                            "path": devicePaths[ix],
                            "name": name,
                            "ix": ix})
                    }

                    var ix = devicePaths.indexOf(deviceNameComboBox.devicePath)
                    ix = ix>0 ? ix : 0
                    deviceNameComboBox.currentIndex = ix
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
}
