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

Bar {
    id: root

    alignToTopLeft: Global.chargeBarTopAlign
    flip:          (Global.batteryIsCharging && Global.chargeBarFlipOnCharging) || (!Global.batteryIsCharging && Global.chargeBarFlip)
    offset:         Global.chargeBarOffset
    fill:           Global.chargeBarHeight == 0
    margin:         Global.chargeBarMargin
    length:        (Global.chargeBarValueOffset + Global.batteryNow) * Global.maxLen / Global.batteryFull + Global.chargeBarOffset
    thickness:      Global.chargeBarHeight

    opacity:        Global.batteryIsCharging ? Global.chargeBarChargingOpacity : Global.chargeBarOpacity
    color:          Global.batteryIsCharging ? Global.chargeBarChargingColor : Global.chargeBarColor
}
