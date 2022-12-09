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
import ".."

Bar {
    id: root

    align:          Global.batteryIsCharging ? Global.chargeBarChargingAlign : Global.chargeBarAlign
    offset:         Global.chargeBarOffset
    margin:         Global.chargeBarMargin
    width:         (Global.chargeBarValueOffset + Global.batteryNowAbsolute) * Global.maxLen / Global.batteryFullAbsolute - Global.chargeBarOffset
    height:         Global.chargeBarHeight

    opacity:        Global.batteryIsCharging ? Global.chargeBarChargingOpacity : Global.chargeBarOpacity
    color:          Global.batteryIsCharging ? Global.chargeBarChargingColor : Global.chargeBarColor
}
