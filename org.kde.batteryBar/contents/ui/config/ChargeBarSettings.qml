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

Kirigami.FormLayout {
    id: chargeBarSettings
    
    property alias cfg_chargeBarTopAlign: chargeBarTopAlignCheckBox.checked
    property alias cfg_chargeBarFlip: chargeBarFlipCheckBox.checked
    property alias cfg_chargeBarFlipOnCharging: chargeBarFlipOnChargingCheckBox.checked
    property alias cfg_chargeBarColor: chargeBarColorPicker.color
    property alias cfg_chargeBarOpacity: chargeBarOpacitySpinBox.value
    property alias cfg_chargeBarChargingColor: chargeBarChargingColorPicker.color
    property alias cfg_chargeBarChargingOpacity: chargeBarChargingOpacitySpinBox.value
    property alias cfg_chargeBarOffset: chargeBarOffsetSpinBox.value
    property alias cfg_chargeBarHeight: chargeBarHeightSpinBox.value
    property alias cfg_chargeBarMargin: chargeBarMarginSpinBox.value
    
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
    QQC2.CheckBox {
        id: chargeBarTopAlignCheckBox

        Kirigami.FormData.label: i18nc("@label", "Charge bar location:")
        text: i18nc("@option:check", "Aligned to top / aligned to left")

        enabled: chargeBarHeightSpinBox.value != 0
    }
    QQC2.CheckBox {
        id: chargeBarFlipCheckBox

        Kirigami.FormData.label: i18nc("@label", "Charge bar location when not charging:")
        text: i18nc("@option:check", "From right to left / from bottom to top")
    }
    QQC2.CheckBox {
        id: chargeBarFlipOnChargingCheckBox

        Kirigami.FormData.label: i18nc("@label", "Charge bar location when charging:")
        text: i18nc("@option:check", "From right to left / from bottom to top")
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

        Kirigami.FormData.label: i18nc("@label:spinbox", "Charge bar thickness (set 0 to fill the panel):")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        suffix: i18n("px")
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
