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
