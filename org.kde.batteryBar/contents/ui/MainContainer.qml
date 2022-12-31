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
    readonly property int normalModeSize: rootItem.global.normalModeSize
    onParentChanged: updateParent()
    onPEditModeChanged: updateDimensions()
    onNormalModeSizeChanged: updateDimensions()

    function _updateAppletSize() {
        let size = rootItem.global.editMode ? rootItem.global.editModeSize : normalModeSize
        var gpoint = root.appletInterface.mapToItem(root.containmentInterface, 0, 0)

        if (rootItem.global.isVertical) {
            if (root.height == size) {
                updateDimensionsRetry.running = false
                console.log("Applet size updated.")
                return
            }
            rootItem.global.maxLen = root.containmentInterface.height - gpoint.y
            root.Layout.preferredHeight = size
            root.Layout.maximumHeight = size
            root.Layout.minimumHeight = size
            root.implicitHeight = size
            root.height = size
            root.appletInterface.Layout.preferredHeight = size
            root.appletInterface.Layout.maximumHeight = size
            root.appletInterface.Layout.minimumHeight = size
            root.appletInterface.implicitHeight = size
            root.appletInterface.height = size
        } else {
            if (root.width == size) {
                updateDimensionsRetry.running = false
                console.log("Applet size updated.")
                return
            }
            rootItem.global.maxLen = root.containmentInterface.width - gpoint.x
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
    }
    function _updateDimensions() {
        let size = rootItem.global.editMode ? rootItem.global.editModeSize : normalModeSize

        rootItem.global.containerWidth = root.containmentInterface.width
        rootItem.global.containerHeight = root.containmentInterface.height
        if (root.appletInterface.width > size) {
            rootItem.global.appletWidth = root.appletInterface.width
        }
        if (root.appletInterface.height > size) {
            rootItem.global.appletHeight = root.appletInterface.height
        }
        if (rootItem.global.editMode != root.pEditMode) {
            rootItem.global.editMode = root.pEditMode
            updateAppletSize()
        }
    }
    function updateAppletSize() {
        if (root.appletInterface && root.containmentInterface) {
            updateDimensionsRetry.running = true
            console.log("Trying to update applet size.")
        }
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
        id: updateDimensionsRetry
        interval: 10
        running: false
        repeat: true
        onTriggered: _updateAppletSize()
    }
    Timer {
        id: updateDimensionsCyclical
        interval: rootItem.global.dimensionsUpdateInterval
        running: true
        repeat: true
        onTriggered: updateDimensions()
    }
    Image {
        id: editIcon
        anchors.fill: parent
        source: "icon.svg"
        visible: rootItem.global.editMode
    }
}
