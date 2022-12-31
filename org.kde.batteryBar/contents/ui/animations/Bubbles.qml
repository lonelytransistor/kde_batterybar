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
    opacity: 0.75

    Component.onCompleted: emitter.pulse(1000)
    ParticleSystem {
        id: particleSystem
        onEmptyChanged: if (empty) root.parent.ended()
    }
    ImageParticle {
        source: "bubble.png"
        system: particleSystem
    }
    Emitter {
        id: emitter
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            leftMargin: -100
        }
        enabled: false
        maximumEmitted: 10
        width: 1
        system: particleSystem
        emitRate: velocity.magnitude/50
        lifeSpan: 2000
        size: parent.height/2
        sizeVariation: size*0.4
        velocity: AngleDirection {
            angle: 0
            magnitude: 1000
            magnitudeVariation: magnitude/10
        }
    }
}
