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
    
    property alias cfg_animationsVisible: animationsVisibleCheckBox.checked
    property alias cfg_rainVisible: rainVisibleCheckBox.checked
    property alias cfg_snowVisible: snowVisibleCheckBox.checked
    property alias cfg_breatheVisible: breatheVisibleCheckBox.checked
    property alias cfg_boltVisible: boltVisibleCheckBox.checked
    property alias cfg_bubblesVisible: bubblesVisibleCheckBox.checked
    property alias cfg_breatheDuration: breatheDurationSpinBox.value
    property alias cfg_breatheDelay: breatheDelaySpinBox.value

    QQC2.CheckBox {
        id: animationsVisibleCheckBox

        Kirigami.FormData.label: i18nc("@label", "Animations:")
        text: i18nc("@option:check", "Enabled")
    }
    QQC2.CheckBox {
        id: rainVisibleCheckBox

        text: i18nc("@option:check", "Let it rain")
        enabled: animationsVisibleCheckBox.checked
    }
    QQC2.CheckBox {
        id: snowVisibleCheckBox

        text: i18nc("@option:check", "Let it snow")
        enabled: animationsVisibleCheckBox.checked
    }
    QQC2.CheckBox {
        id: boltVisibleCheckBox

        text: i18nc("@option:check", "Bolt (charger connect)")
        enabled: animationsVisibleCheckBox.checked
    }
    QQC2.CheckBox {
        id: bubblesVisibleCheckBox
        
        text: i18nc("@option:check", "Bubbles (charger disconnect)")
        enabled: animationsVisibleCheckBox.checked
    }
    QQC2.CheckBox {
        id: breatheVisibleCheckBox

        text: i18nc("@option:check", "Breathing (charging)")
        enabled: animationsVisibleCheckBox.checked
    }
    QQC1.SpinBox {
        id: breatheDurationSpinBox
        
        Kirigami.FormData.label: i18n("Breathing speed:")
        
        decimals: 1
        stepSize: 0.1
        minimumValue: 0
        suffix: i18n("s")
        
        enabled: breatheVisibleCheckBox.checked && animationsVisibleCheckBox.checked
    }
    QQC1.SpinBox {
        id: breatheDelaySpinBox
        
        Kirigami.FormData.label: i18n("Breathing delay:")
        
        decimals: 1
        stepSize: 0.1
        minimumValue: 0
        suffix: i18n("s")
        
        enabled: breatheVisibleCheckBox.checked && animationsVisibleCheckBox.checked
    }
}
