import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Controls 1.4 as QQC1

import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls

Kirigami.FormLayout {
    id: colorSettings
    
    property alias cfg_capacityColor: capacityColorPicker.color
    property alias cfg_capacityOpacity: capacityOpacitySlider.value
    property alias cfg_rateColor: rateColorPicker.color
    property alias cfg_rateOpacity: rateOpacitySlider.value
    
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
        onValueChanged: {
            capacityOpacitySlider.value = value
        }
        
        QQC1.Slider {
            id: capacityOpacitySlider
            
            anchors.left: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            
            stepSize: 1
            minimumValue: 0
            maximumValue: 255
            updateValueWhileDragging: true
            onValueChanged: {
                parent.value = value
            }
        }
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
        onValueChanged: {
            rateOpacitySlider.value = value
        }
        
        QQC1.Slider {
            id: rateOpacitySlider
            
            anchors.left: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            
            stepSize: 1
            minimumValue: 0
            maximumValue: 255
            updateValueWhileDragging: true
            onValueChanged: {
                parent.value = value
            }
        }
    }
}
