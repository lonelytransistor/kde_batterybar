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
import QtGraphicalEffects 1.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: root

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    property var containmentInterface: null
    property var appletInterface: null
    readonly property bool pEditMode: containmentInterface ? containmentInterface.editMode : false
    readonly property int normalModeSize: Global.normalModeSize
    onParentChanged: updateParent()
    onPEditModeChanged: updateDimensions()
    onNormalModeSizeChanged: updateDimensions()

    function _updateDimensions() {
        let size = Global.editMode ? Global.editModeSize : normalModeSize

        var gpoint = root.appletInterface.mapToItem(root.containmentInterface, 0, 0)
        Global.containerWidth = root.containmentInterface.width
        Global.containerHeight = root.containmentInterface.height
        if (root.appletInterface.width > size)
            Global.appletWidth = root.appletInterface.width
        if (root.appletInterface.height > size)
            Global.appletHeight = root.appletInterface.height
        if (Global.isVertical) {
            Global.maxLen = root.containmentInterface.height - gpoint.y
        } else {
            Global.maxLen = root.containmentInterface.width - gpoint.x
        }
        Global.editMode = root.pEditMode

        root.Layout.preferredWidth = size
        root.Layout.maximumWidth = size
        root.Layout.minimumWidth = size
        root.implicitWidth = size
        root.width = size
        root.appletInterface.Layout.preferredWidth = size
        root.appletInterface.Layout.maximumWidth = size
        root.appletInterface.Layout.minimumWidth = size
        root.appletInterface.implicitWidth = size
        root.appletInterface.width = size
    }
    function updateDimensions() {
        if (root.appletInterface && root.containmentInterface) {
            updateDimensionsDelay.running = true
        }
    }
    function updateParent() {
        if (parent) {
            for (var obj = root, depth = 0; !!obj; obj = obj.parent, depth++) {
                if (obj.toString().startsWith('AppletInterface')) {
                    root.appletInterface = obj
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
    Timer {
        id: updateDimensionsDelay
        interval: 10
        running: false
        repeat: false
        onTriggered: _updateDimensions()
    }
    Timer {
        id: updateDimensionsCyclical
        interval: Global.dimensionsUpdateInterval
        running: true
        repeat: true
        onTriggered: updateDimensions()
    }
    Image {
        id: editIcon
        anchors.fill: parent
        source: "icon.svg"
        visible: Global.editMode
    }
}
