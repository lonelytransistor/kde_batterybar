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
    property var cfg_devicePath
    
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

        Kirigami.FormData.label: i18n("Device name:")
        property var devicePaths: [""]
        onDevicePathsChanged: {
            model.clear()
            model.append({"label": "Dummy source", "path": "", "name": "", "ix": 0})
            for (var ix=1; ix<devicePaths.length; ix++) {
                var name = devicePaths[ix].match(/(\/\w+)$/g)[0]
                var item = {"label": name, "path": devicePaths[ix], "name": name, "ix": ix}
                model.append(item)
            }
        }

        PlasmaCore.DataSource {
            id: deviceNameDataSource
            engine: "executable"
            connectedSources: ["qdbus --literal --system org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.EnumerateDevices"]

            onNewData: {
                if (data['exit code'] == 0) {
                    var paths = data.stdout.match(/(\/\w+)+/g)
                    if (paths)
                        deviceNameComboBox.devicePaths = paths
                }
            }
        }
        model: ListModel {
            ListElement {
                name: "Dummy source"
                path: ""
                name: ""
                ix: 0
            }
        }
        textRole: "label"

        currentIndex: {
            var ix = devicePaths.indexOf(parent.cfg_devicePath)
            ix = ix ? ix : 0
            return ix
        }
        onActivated: miscSettings.cfg_devicePath = devicePaths[currentIndex]
    }
}
