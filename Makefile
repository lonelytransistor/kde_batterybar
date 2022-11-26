all:
	./build.py --name org.kde.batteryBar --version ${VERSION} --pkg kdeplasma-applets-batterybar --url https://github.com/lonelytransistor/kde_batterybar build/

clean:
	rm -rf build/
