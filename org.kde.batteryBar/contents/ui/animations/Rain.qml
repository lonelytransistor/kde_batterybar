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
import QtQuick 2.5
import QtQuick.Particles 2.0
import ".."

Rectangle {
    id: root
    anchors.fill: parent
    color: "transparent"
    opacity: 0.7
    visible: Global.rainVisible

    ParticleSystem {
        id: particleSystem
    }
    ImageParticle {
        source: "tail.png"
        system: particleSystem
        groups: ['tail']
    }
    Emitter {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: -100
            topMargin: -parent.height
        }
        height: 1
        system: particleSystem
        emitRate: 80
        lifeSpan: 4800
        lifeSpanVariation: 400
        size: 8
        enabled: Global.rainVisible
        group: 'raindrop'
        velocity: AngleDirection { angle: 60; magnitude: 600; magnitudeVariation: 100 }
    }
    TrailEmitter {
        system: particleSystem
        size: 4
        emitRatePerParticle: 300
        lifeSpan: 20
        group: 'tail'
        follow: 'raindrop'
    }
}
