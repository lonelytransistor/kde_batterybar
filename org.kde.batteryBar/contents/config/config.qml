import QtQuick 2.2
import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
         name: i18n('Geometry')
         icon: 'applications-engineering'
         source: 'config/Geometry.qml'
    }
    ConfigCategory {
         name: i18n('Color')
         icon: 'preferences-desktop-color'
         source: 'config/Color.qml'
    }
    ConfigCategory {
         name: i18n('Animation')
         icon: 'preferences-desktop-effects'
         source: 'config/Animation.qml'
    }
    ConfigCategory {
         name: i18n('Misc')
         icon: 'preferences-system-other'
         source: 'config/Misc.qml'
    }
}
