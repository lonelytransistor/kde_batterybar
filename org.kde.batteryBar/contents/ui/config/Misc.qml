import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Controls 1.4 as QQC1

import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls

Kirigami.FormLayout {
    id: miscSettings
    
    property alias cfg_updateInterval: updateIntervalSpinBox.value
    property alias cfg_valueOffset: valueOffsetSpinBox.value
    property alias cfg_valueRateOffset: valueRateOffsetSpinBox.value
    
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
}
