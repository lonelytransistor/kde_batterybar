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

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls

import ".."

Kirigami.FormLayout {
    id: chargeBarSettings

    property alias cfg_chargeBarAlign: chargeBarAlignComboBox.value
    property alias cfg_chargeBarChargingAlign: chargeBarChargingAlignComboBox.value
    property alias cfg_chargeBarColor: chargeBarColorPicker.color
    property alias cfg_chargeBarOpacity: chargeBarOpacitySpinBox.value
    property alias cfg_chargeBarChargingColor: chargeBarChargingColorPicker.color
    property alias cfg_chargeBarChargingOpacity: chargeBarChargingOpacitySpinBox.value
    property alias cfg_chargeBarOffset: chargeBarOffsetSpinBox.value
    property alias cfg_chargeBarHeight: chargeBarHeightSpinBox.value
    property alias cfg_chargeBarMargin: chargeBarMarginSpinBox.value

    property bool isVertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property var alignment: plasmoid.rootItem.global.getAlignment(isVertical)
    function findIndex(key) {
        return plasmoid.rootItem.global.findAlignment(key)
    }

    QQC2.Label {
        Kirigami.FormData.label: i18n("Charge bar shows the current\n")
        text: "battery charge and state.\n"
    }
    KQuickControls.ColorButton {
        id: chargeBarColorPicker
        Kirigami.FormData.label: i18n("Current charge bar color:")
        enabled: true
    }
    QQC1.SpinBox {
        id: chargeBarOpacitySpinBox

        Kirigami.FormData.label: i18n("Current charge bar opacity:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: chargeBarOpacitySlider.value = value
    }
    QQC1.Slider {
        id: chargeBarOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: chargeBarOpacitySpinBox.stepSize
        minimumValue: chargeBarOpacitySpinBox.minimumValue
        maximumValue: chargeBarOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        value: chargeBarOpacitySpinBox.value
        onValueChanged: chargeBarOpacitySpinBox.value = value
    }
    KQuickControls.ColorButton {
        id: chargeBarChargingColorPicker
        Kirigami.FormData.label: i18n("Current charge bar color when charging:")
        enabled: true
    }
    QQC1.SpinBox {
        id: chargeBarChargingOpacitySpinBox

        Kirigami.FormData.label: i18n("Current charge bar opacity when charging:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: chargeBarChargingOpacitySlider.value = value
    }
    QQC1.Slider {
        id: chargeBarChargingOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: chargeBarChargingOpacitySpinBox.stepSize
        minimumValue: chargeBarChargingOpacitySpinBox.minimumValue
        maximumValue: chargeBarChargingOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        value: chargeBarChargingOpacitySpinBox.value
        onValueChanged: chargeBarChargingOpacitySpinBox.value = value
    }
    QQC2.ComboBox {
        id: chargeBarAlignComboBox

        Kirigami.FormData.label: i18n("Charge bar alignment:")

        model: parent.alignment
        textRole: "label"
        property string value
        currentIndex: findIndex(value)
        onActivated: {
            value = model[currentIndex].align
            cfg_chargeBarAlign = value
        }
    }
    QQC2.ComboBox {
        id: chargeBarChargingAlignComboBox

        Kirigami.FormData.label: i18n("Charge bar alignment when charging:")

        model: parent.alignment
        textRole: "label"
        property string value
        currentIndex: findIndex(value)
        onActivated: {
            value = model[currentIndex].align
            cfg_chargeBarChargingAlign = value
        }
    }
    QQC1.SpinBox {
        id: chargeBarOffsetSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Charge bar offset:")

        decimals: 0
        stepSize: 1
        minimumValue: -1000
        maximumValue: 1000
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: chargeBarHeightSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Charge bar thickness:")

        decimals: 0
        stepSize: 1
        minimumValue: 1
        suffix: i18n("px")
        enabled: !chargeBarChargingAlignComboBox.value.includes("fill") || !chargeBarAlignComboBox.value.includes("fill")
    }
    QQC1.SpinBox {
        id: chargeBarMarginSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Charge bar margin:")

        decimals: 0
        stepSize: 1
        minimumValue: -10
        suffix: i18n("px")
    }
}
