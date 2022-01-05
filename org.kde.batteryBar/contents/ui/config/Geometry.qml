import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Controls 1.4 as QQC1

import org.kde.kirigami 2.5 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls

Kirigami.FormLayout {
    id: geometrySettings
    
    property alias cfg_startOffset: startOffsetSpinBox.value
    property alias cfg_spacerWidth: spacerWidthSpinBox.value
    property alias cfg_capacityHeight: capacityHeightSpinBox.value
    property alias cfg_capacityMargin: capacityMarginSpinBox.value
    property alias cfg_capacityTopAlign: capacityTopAlignCheckBox.checked
    property alias cfg_rateHeight: rateHeightSpinBox.value
    property alias cfg_rateRescale: rateRescaleSpinBox.value
    property alias cfg_rateMargin: rateMarginSpinBox.value
    property alias cfg_rateTopAlign: rateTopAlignCheckBox.checked
    
    
    QQC1.SpinBox {
        id: startOffsetSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Bars X offset:")

        decimals: 0
        stepSize: 1
        minimumValue: -40
        maximumValue: 40
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: spacerWidthSpinBox

        Kirigami.FormData.label: i18nc("@label:spinbox", "Spacer width:")

        decimals: 0
        stepSize: 1
        minimumValue: 2
        maximumValue: 40
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: capacityHeightSpinBox
        
        Kirigami.FormData.label: i18n("Current charge bar height (0==fit):")
        
        decimals: 0
        stepSize: 1
        minimumValue: 0
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: capacityMarginSpinBox
        
        Kirigami.FormData.label: i18n("Current charge bar offset from edge:")
        
        decimals: 0
        stepSize: 1
        minimumValue: 0
        suffix: i18n("px")
    }
    QQC2.CheckBox {
        id: capacityTopAlignCheckBox

        Kirigami.FormData.label: i18nc("@label", "Charge bar position:")
        text: i18nc("@option:check", "Align to top")
        
        enabled: capacityHeightSpinBox.value != 0
    }
    QQC1.SpinBox {
        id: rateHeightSpinBox
        
        Kirigami.FormData.label: i18n("Discharge rate bar height (0==fit):")
        
        decimals: 0
        stepSize: 1
        minimumValue: 0
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: rateMarginSpinBox
        
        Kirigami.FormData.label: i18n("Discharge rate bar offset from edge:")
        
        decimals: 0
        stepSize: 1
        minimumValue: 0
        suffix: i18n("px")
    }
    QQC1.SpinBox {
        id: rateRescaleSpinBox
        
        Kirigami.FormData.label: i18n("Rescale the discharge rate to mAh per:")
        
        decimals: 1
        stepSize: 0.5
        minimumValue: 0.5
        maximumValue: 3.0
        suffix: i18n("h")
    }
    QQC2.CheckBox {
        id: rateTopAlignCheckBox

        Kirigami.FormData.label: i18nc("@label", "Discharge rate bar position:")
        text: i18nc("@option:check", "Align to top")
        
        enabled: rateHeightSpinBox.value != 0
    }
}
