CURRENT_BUILD_NUMBER = $(shell cat metadata/build_number.txt | head)
NEXT_BUILD_NUMBER = $(shell expr $(CURRENT_BUILD_NUMBER) + 1)

.PHONY: default
default: alpha

.PHONY: clean
clean:
	flutter clean

.PHONY: build_runner
build_runner:
	pm2 start --no-daemon "flutter pub run build_runner watch --delete-conflicting-outputs"

.PHONY: icons
icons:
	flutter pub run flutter_launcher_icons:main

.PHONY: screenshots
screenshots:
	dart tools/screenshots.dart

	git reset
	git add android/fastlane/metadata/android/en-US/images
	git add ios/fastlane/screenshots
	git commit -m "Update screenshots"

.PHONY: increment-build-number
increment-build-number:
	@echo $(NEXT_BUILD_NUMBER) > metadata/build_number.txt

.PHONY: alpha
alpha: clean increment-build-number
	cd android && bundle update fastlane && bundle exec fastlane alpha

.PHONY: beta
beta: clean increment-build-number
	cd android && bundle update fastlane && bundle exec fastlane beta

.PHONY: release
release: clean increment-build-number
	cd android && bundle update fastlane && bundle exec fastlane release