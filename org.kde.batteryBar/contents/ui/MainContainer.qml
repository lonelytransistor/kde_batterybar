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

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    property int spacerWidth: plasmoid.configuration.spacerWidth
    readonly property int editModeSize: 32

    property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property bool planar: (plasmoid.formFactor == PlasmaCore.Types.Planar)

    property var containmentInterface: null
    property var appletInterface: null
    property bool editMode: pEditMode

    property int maxLength: 1
    readonly property bool pEditMode: containmentInterface ? containmentInterface.editMode : false
    onParentChanged: {
        if (parent) {
            for (var obj = root, depth = 0; !!obj; obj = obj.parent, depth++) {
                if (obj.toString().startsWith('AppletInterface')) {
                    root.appletInterface = obj
                    console.log("Applet interface has width=" + obj.width + " height=" + obj.height + " offset=" + obj.x + " y=" + obj.y)
                }
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
            updateDimensions()
        }
    }
    onPEditModeChanged: editModeDelay.running = true
    onEditModeChanged: updateDimensions()
    onSpacerWidthChanged: updateDimensions()
    Timer { // FIXME: find a better way for this.
        id: updateDimensionsOccasionally
        interval: 2000
        running: true
        repeat: true
        onTriggered: updateDimensions()
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
    function updateDimensions() {
        var gpoint = root.appletInterface.mapToItem(root.containmentInterface, 0, 0)
        root.maxLength = root.containmentInterface.width - gpoint.x

        let _width = editMode ? editModeSize : root.spacerWidth
        root.Layout.preferredWidth = _width
        root.Layout.minimumWidth = _width
        root.width = _width
        root.Layout.preferredHeight = _width
        root.Layout.minimumHeight = _width
        root.height = _width
    }
}
