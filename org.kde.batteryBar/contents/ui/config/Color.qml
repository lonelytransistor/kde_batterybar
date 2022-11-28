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
    id: colorSettings
    
    property alias cfg_capacityColor: capacityColorPicker.color
    property alias cfg_capacityOpacity: capacityOpacitySlider.value
    property alias cfg_capacityChargingColor: capacityChargingColorPicker.color
    property alias cfg_capacityChargingOpacity: capacityChargingOpacitySlider.value
    property alias cfg_rateColor: rateColorPicker.color
    property alias cfg_rateOpacity: rateOpacitySlider.value
    property alias cfg_rateSegmentsColor: rateSegmentsColorPicker.color
    property alias cfg_rateSegmentsOpacity: rateSegmentsOpacitySlider.value
    
    KQuickControls.ColorButton {
        id: capacityColorPicker
        Kirigami.FormData.label: i18n("Current charge bar color:")
        enabled: true
    }
    QQC1.SpinBox {
        id: capacityOpacitySpinBox

        Kirigami.FormData.label: i18n("Current charge bar opacity:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: capacityOpacitySlider.value = value
    }
    QQC1.Slider {
        id: capacityOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: capacityOpacitySpinBox.stepSize
        minimumValue: capacityOpacitySpinBox.minimumValue
        maximumValue: capacityOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        onValueChanged: capacityOpacitySpinBox.value = value
    }
    KQuickControls.ColorButton {
        id: capacityChargingColorPicker
        Kirigami.FormData.label: i18n("Current charge bar color:")
        enabled: true
    }
    QQC1.SpinBox {
        id: capacityChargingOpacitySpinBox

        Kirigami.FormData.label: i18n("Current charge bar opacity:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: capacityChargingOpacitySlider.value = value
    }
    QQC1.Slider {
        id: capacityChargingOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: capacityChargingOpacitySpinBox.stepSize
        minimumValue: capacityChargingOpacitySpinBox.minimumValue
        maximumValue: capacityChargingOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        onValueChanged: capacityChargingOpacitySpinBox.value = value
    }
    KQuickControls.ColorButton {
        id: rateColorPicker
        Kirigami.FormData.label: i18n("Discharge rate bar color:")
        enabled: true
    }
    QQC1.SpinBox {
        id: rateOpacitySpinBox

        Kirigami.FormData.label: i18n("Discharge rate bar opacity:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: rateOpacitySlider.value = value
    }
    QQC1.Slider {
        id: rateOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: rateOpacitySpinBox.stepSize
        minimumValue: rateOpacitySpinBox.minimumValue
        maximumValue: rateOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        onValueChanged: rateOpacitySpinBox.value = value
    }
    KQuickControls.ColorButton {
        id: rateSegmentsColorPicker
        Kirigami.FormData.label: i18n("Discharge rate segments color:")
        enabled: true
    }
    QQC1.SpinBox {
        id: rateSegmentsOpacitySpinBox

        Kirigami.FormData.label: i18n("Discharge rate segments opacity:")

        decimals: 0
        stepSize: 1
        minimumValue: 0
        maximumValue: 255
        onValueChanged: rateSegmentsOpacitySlider.value = value
    }
    QQC1.Slider {
        id: rateSegmentsOpacitySlider

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 32
        anchors.rightMargin: 32

        stepSize: rateSegmentsOpacitySpinBox.stepSize
        minimumValue: rateSegmentsOpacitySpinBox.minimumValue
        maximumValue: rateSegmentsOpacitySpinBox.maximumValue
        updateValueWhileDragging: true
        onValueChanged: rateSegmentsOpacitySpinBox.value = value
    }
}
