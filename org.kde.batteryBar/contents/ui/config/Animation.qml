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
