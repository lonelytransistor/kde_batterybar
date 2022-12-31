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
import QtQuick 2.15
import QtQuick.Particles 2.15
import ".."

Rectangle {
    id: root
    anchors.fill: parent
    color: "transparent"
    opacity: 0.7

    ParticleSystem {
        id: particleSystem
        onEmptyChanged: if (empty) root.parent.ended()
    }
    ImageParticle {
        source: "snowflake.png"
        system: particleSystem
    }
    Emitter {
        id: emitter
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: -100
            topMargin: -parent.height
        }
        height: 1
        system: particleSystem
        emitRate: rootItem.global.snowVisible ? 40 : 0
        lifeSpan: rootItem.global.snowVisible ? 6400 : 0
        size: 8
        sizeVariation: 6
        velocity: AngleDirection {
            angle: 70
            angleVariation: 20
            magnitude: 100
            magnitudeVariation: 25
        }
    }
}
