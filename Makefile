.PHONY: build_runner
build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: launcher_icons
launcher_icons:
	convert assets/icon/icon.png -alpha off assets/icon/icon.png
	convert assets/icon/icon_bg.png -alpha off assets/icon/icon_bg.png
	flutter pub run flutter_launcher_icons:main
