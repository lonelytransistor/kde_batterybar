pkgname=kdeplasma-applets-batterybar
pkgver=0.1
pkgrel=1
pkgdesc="A KDE plasmoid showing you the current state of the battery in a nice graphical way."
url="https://github.com/lonelytransistor/kde_batterybar"
arch=("any")
license=("GPL2")
depends=("plasma-workspace")
makedepends=()
conflicts=()
source=("${url}/releases/download/v${pkgver}/${pkgname}-${pkgver}.tar.gz")
sha1sums=("527b31a195bbc4ac96bb9f2573b086f0dc0d08c3")

package() {
    cd "${srcdir}"

    install -d "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/config
    install -d "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/ui/config

    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/metadata.desktop
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/contents/config/config.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/contents/config/main.xml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/contents/ui/config/Animation.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/contents/ui/config/Geometry.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/contents/ui/config/Misc.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/contents/ui/config/Color.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/ org.kde.batteryBar/contents/ui/main.qml
}
