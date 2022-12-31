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
    id: rateBarSettings
    
    property alias cfg_rateBarAlign: rateBarAlignComboBox.value
    property alias cfg_rateBarChargingAlign: rateBarChargingAlignComboBox.value
    property alias cfg_rateBarColor: rateBarColorPicker.color
    property alias cfg_rateBarOpacity: rateBarOpacitySpinBox.value
    property alias cfg_rateBarChargingColor: rateBarChargingColorPicker.color
    property alias cfg_rateBarChargingOpacity: rateBarChargingOpacitySpinBox.value
    property alias cfg_rateBarSegmentsColor: rateBarSegmentsColorPicker.color
    property alias cfg_rateBarSegmentsOpacity: rateBarSegmentsOpacitySpinBox.value
    property alias cfg_rateBarOffset: rateBarOffsetSpinBox.value
    property alias cfg_rateBarHeight: rateBarHeightSpinBox.value
    property alias cfg_rateBarMargin: rateBarMarginSpinBox.value
    property alias cfg_rateBarRescale: rateBarRescaleSpinBox.value

    property bool isVertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property var alignment: plasmoid.rootItem.global.getAlignment(isVertical)
    function findIndex(key) {
        return plasmoid.rootItem.global.findAlignment(key)
    }

    QQC2.Label {
        Kirigami.FormData.label: "Rate segments show how much battery will\n"
        text: "discharge or charge after multiples of " + cfg_rateBarRescale + "h.\n"
    }
    KQuickControls.ColorButton {
        id: rateBarSegmentsColorPicker
        Kirigami.FormData.label: i18n("Rate segments color:")
        enabled: true
    }
    QQC1.SpinBox {
        id: rateBarSegmentsOpacitySpinBox

        Kirigami.FormData.label: i18n("Rate segments opacity:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: rateBarSegmentsOpacitySlider.value = value
    }
    QQC1.Slider {
        id: rateBarSegmentsOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: rateBarSegmentsOpacitySpinBox.stepSize
        minimumValue: rateBarSegmentsOpacitySpinBox.minimumValue
        maximumValue: rateBarSegmentsOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        value: rateBarSegmentsOpacitySpinBox.value
        onValueChanged: rateBarSegmentsOpacitySpinBox.value = value
    }
    QQC2.Label {
        Kirigami.FormData.label: "Rate bar shows how much battery will\n"
        text: "discharge or charge during the next " + cfg_rateBarRescale + "h.\n"
    }
    KQuickControls.ColorButton {
        id: rateBarColorPicker
        Kirigami.FormData.label: i18n("Rate bar color when discharging:")
        enabled: true
    }
    QQC1.SpinBox {
        id: rateBarOpacitySpinBox

        Kirigami.FormData.label: i18n("Rate bar opacity when discharging:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: rateBarOpacitySlider.value = value
    }
    QQC1.Slider {
        id: rateBarOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: rateBarOpacitySpinBox.stepSize
        minimumValue: rateBarOpacitySpinBox.minimumValue
        maximumValue: rateBarOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        value: rateBarOpacitySpinBox.value
        onValueChanged: rateBarOpacitySpinBox.value = value
    }
    KQuickControls.ColorButton {
        id: rateBarChargingColorPicker
        Kirigami.FormData.label: i18n("Rate bar color when charging:")
        enabled: true
    }
    QQC1.SpinBox {
        id: rateBarChargingOpacitySpinBox

        Kirigami.FormData.label: i18n("Rate bar opacity when charging:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: rateBarChargingOpacitySlider.value = value
    }
    QQC1.Slider {
        id: rateBarChargingOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: rateBarChargingOpacitySpinBox.stepSize
        minimumValue: rateBarChargingOpacitySpinBox.minimumValue
        maximumValue: rateBarChargingOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        value: rateBarChargingOpacitySpinBox.value
        onValueChanged: rateBarChargingOpacitySpinBox.value = value
    }
    QQC2.ComboBox {
        id: rateBarAlignComboBox

        Kirigami.FormData.label: i18n("Rate bar alignment:")

        model: parent.alignment
        textRole: "label"
        property string value
        currentIndex: findIndex(value, model)
        onActivated: {
            value = model[currentIndex].align
            cfg_rateBarAlign = value
        }
    }
    QQC2.ComboBox {
        id: rateBarChargingAlignComboBox

        Kirigami.FormData.label: i18n("Rate bar alignment when charging:")

        model: parent.alignment
        textRole: "label"
        property string value
        currentIndex: findIndex(value, model)
        onActivated: {
            value = model[currentIndex].align
            cfg_rateBarChargingAlign = value
        }
    }
    QQC1.SpinBox {
        id: rateBarOffsetSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Rate bar offset:")

        decimals: 0
        stepSize: 1
        minimumValue: -1000
        maximumValue: 1000
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: rateBarHeightSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Rate bar thickness:")

        decimals: 0
        stepSize: 1
        minimumValue: 1
        suffix: i18n("px")
        enabled: !rateBarChargingAlignComboBox.value.includes("fill") || !rateBarAlignComboBox.value.includes("fill")
    }
    QQC1.SpinBox {
        id: rateBarMarginSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Rate bar margin:")

        decimals: 0
        stepSize: 1
        minimumValue: -10
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: rateBarRescaleSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Rate bar rescaler:")

        decimals: 2
        stepSize: 0.5
        minimumValue: 0.05
        maximumValue: 10.0
        suffix: i18n("h")
    }
}
