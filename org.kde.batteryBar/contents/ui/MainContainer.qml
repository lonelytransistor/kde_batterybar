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
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    anchors.fill: parent
    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property bool planar: (plasmoid.formFactor == PlasmaCore.Types.Planar)
    property int spacerWidth: plasmoid.configuration.spacerWidth
    property var containmentInterface: null
    property bool editMode: pEditMode
    readonly property bool pEditMode: containmentInterface ? containmentInterface.editMode : false
    readonly property int editModeSize: 32
    onParentChanged: {
        if (parent) {
            for (var obj = root, depth = 0; !!obj; obj = obj.parent, depth++) {
                if (obj.toString().startsWith('ContainmentInterface')) {
                    if (typeof obj['editMode'] === 'boolean') {
                        root.containmentInterface = obj
                        break
                    }
                } else if (obj.toString().startsWith('DeclarativeDropArea')) {
                    if (typeof obj['Plasmoid'] !== 'undefined' && obj['Plasmoid'].toString().startsWith('ContainmentInterface')) {
                        if (typeof obj['Plasmoid']['editMode'] === 'boolean') {
                            root.containmentInterface = obj.Plasmoid
                            break
                        }
                    }
                }
            }
        }
    }
    onPEditModeChanged: {
        editModeDelay.running = true
    }
    onEditModeChanged: {
        let _width = editMode ? editModeSize : root.spacerWidth
        root.Layout.preferredWidth = _width
        root.Layout.minimumWidth = _width
        root.width = _width
        root.Layout.preferredHeight = _width
        root.Layout.minimumHeight = _width
        root.height = _width
    }
    onSpacerWidthChanged: {
        let _width = editMode ? editModeSize : root.spacerWidth
        root.Layout.preferredWidth = _width
        root.Layout.minimumWidth = _width
        root.width = _width
        root.Layout.preferredHeight = _width
        root.Layout.minimumHeight = _width
        root.height = _width
    }
    Timer {
        id: editModeDelay
        interval: 1
        running: false
        repeat: false
        onTriggered: root.editMode = root.pEditMode
    }
    Image {
        anchors.fill: parent
        source: "file:///usr/share/icons/breeze/status/32/battery-full-charging.svg"
        visible: root.editMode
    }
}
