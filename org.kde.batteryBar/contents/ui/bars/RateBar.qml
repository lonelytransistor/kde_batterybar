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

    align:          rootItem.global.batteryIsCharging ? rootItem.global.rateBarChargingAlign : rootItem.global.rateBarAlign
    offset:         rootItem.global.rateBarOffset
    margin:         rootItem.global.rateBarMargin
    length:        (rootItem.global.rateBarValueOffset + rootItem.global.batteryRateAbsolute) * rootItem.global.rateBarRescale * (rootItem.global.maxLen - offset) / rootItem.global.batteryFullAbsolute
    thickness:      rootItem.global.rateBarHeight

    opacity:        rootItem.global.batteryIsCharging ? rootItem.global.rateBarChargingOpacity : rootItem.global.rateBarOpacity
    color:          rootItem.global.batteryIsCharging ? rootItem.global.rateBarChargingColor : rootItem.global.rateBarColor
}
