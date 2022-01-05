# Battery bar for KDE Plasma
## Description
This plasmoid adds a battery bar for the KDE Plasma as seen in the screenshot below.
![Screenshot here](screenshot.png)
The main bar (green in the screenshot) fills the screen to the percentage equal to the current battery state.

An auxilliary bar is also available (dark pink in the screenshot), which shows the current discharge rate of the battery. Its length represents the battery percantage that will be lost during the next hour (by default) at the current load. This allows for an easy estimation of the time left on battery. In the example provided above, the battery will be empty in less than an hour.

Additionally simple animations are provided.

Whenever the battery is charging, the bar is shown to slowly breathe once in a while; whenever the charger is disconnected, an animation showing bubbles escaping the battery bar is shown; and whenever the charger is reconnected, a swift bright flash is shown to travel through the battery bar.

## 

![Screenshot here](screenshot2.png)

## Adding to plasma
The trick used in this plasmoid is an overflow of the QML widget's elements into its container. The battery bar is a simple rectangle, however it is significantly larger than the container advertised to KDE Plasma. That means, that for the plasmoid to work, it **must** be placed at the very beginning of a panel that fills the entire screen. The container's size is determined by the value of a spinbox marked *Spacer width* in the configuration.

## Installation
### Local
Just copy the *org.kde.batteryBar* folder into the *~/.local/share/plasma/plasmoids/* folder.
### Global (Arch-based)
A *PKGBUILD* is provided within this repo to install this plasmoid globally on Arch based distros.
