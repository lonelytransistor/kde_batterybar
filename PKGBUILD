pkgname=kdeplasma-applets-batterybar
pkgver=0.2
pkgrel=1
pkgdesc="A KDE plasmoid showing you the current state of the battery in a nice graphical way."
url="https://github.com/lonelytransistor/kde_batterybar"
arch=("any")
license=("GPL2")
depends=("plasma-workspace", "qt5-tools")
makedepends=()
conflicts=()
source=("${url}/releases/download/v${pkgver}/${pkgname}-${pkgver}.tar.gz")
sha1sums=("6e80ce3c3d0cdf5a878082c3b03f099a6ef0fed5")

package() {
    cd "${srcdir}"

    install -d "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/config
    install -d "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/ui/config

    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/                    org.kde.batteryBar/metadata.desktop
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/config/    org.kde.batteryBar/contents/config/config.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/config/    org.kde.batteryBar/contents/config/main.xml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/ui/config/ org.kde.batteryBar/contents/ui/config/Animation.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/ui/config/ org.kde.batteryBar/contents/ui/config/Geometry.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/ui/config/ org.kde.batteryBar/contents/ui/config/Misc.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/ui/config/ org.kde.batteryBar/contents/ui/config/Color.qml
    install -t "${pkgdir}"/usr/share/plasma/plasmoids/org.kde.batteryBar/contents/ui/        org.kde.batteryBar/contents/ui/main.qml
}
