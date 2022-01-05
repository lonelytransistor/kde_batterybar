import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Controls 1.4 as QQC1

import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls

Kirigami.FormLayout {
    id: animationSettings
    
    property alias cfg_plugInAnimation: plugInAnimationCheckBox.checked
    property alias cfg_plugOutAnimation: plugOutAnimationCheckBox.checked
    property alias cfg_chargingAnimation: chargingAnimationCheckBox.checked
    property alias cfg_chargingAnimationSpeed: chargingAnimationSpeedSpinBox.value
    property alias cfg_chargingAnimationDelay: chargingAnimationDelaySpinBox.value
    
    QQC2.CheckBox {
        id: plugInAnimationCheckBox

        Kirigami.FormData.label: i18nc("@label", "Animations:")
        text: i18nc("@option:check", "Charging start")
    }
    QQC2.CheckBox {
        id: plugOutAnimationCheckBox
        
        text: i18nc("@option:check", "Charging stop")
    }
    QQC2.CheckBox {
        id: chargingAnimationCheckBox
        
        text: i18nc("@option:check", "Charging breathing")
    }
    QQC1.SpinBox {
        id: chargingAnimationSpeedSpinBox
        
        Kirigami.FormData.label: i18n("Charging breathing speed:")
        
        decimals: 1
        stepSize: 0.1
        minimumValue: 0
        suffix: i18n("s")
        
        enabled: chargingAnimationCheckBox.checked
    }
    QQC1.SpinBox {
        id: chargingAnimationDelaySpinBox
        
        Kirigami.FormData.label: i18n("Charging breathing delay:")
        
        decimals: 1
        stepSize: 0.1
        minimumValue: 0
        suffix: i18n("s")
        
        enabled: chargingAnimationCheckBox.checked
    }
}
