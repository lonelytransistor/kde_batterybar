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
import QtQuick 2.2
import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
         name: i18n('Data source')
         icon: 'battery'
         source: 'config/SourceSettings.qml'
    }
    ConfigCategory {
         name: i18n('Charge bar')
         icon: 'preferences-desktop-color'
         source: 'config/ChargeBarSettings.qml'
    }
    ConfigCategory {
         name: i18n('Rate bar')
         icon: 'preferences-desktop-color'
         source: 'config/RateBarSettings.qml'
    }
    ConfigCategory {
         name: i18n('Animations')
         icon: 'preferences-desktop-effects'
         source: 'config/AnimationSettings.qml'
    }
    ConfigCategory {
         name: i18n('Misc')
         icon: 'preferences-system-other'
         source: 'config/MiscSettings.qml'
    }
}
