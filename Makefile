all:
	./build.py --name org.kde.batteryBar --version 0.4 --pkg kdeplasma-applets-batterybar --url https://github.com/lonelytransistor/kde_batterybar build/

clean:
	rm -rf build/
