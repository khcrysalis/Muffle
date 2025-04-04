STRIP          = $(shell command -v strip)
BINDERTMP          = $(TMPDIR)/Muffle
BINDER_STAGE_DIR   = $(BINDERTMP)/stage
BINDER_APP_DIR     = $(BINDERTMP)/Build/Products/Release/Muffle.app

.PHONY: package

package:
	# Build
	@set -o pipefail; \
		xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'Muffle.xcodeproj' -scheme Muffle -configuration Release -sdk macosx -derivedDataPath $(BINDERTMP) ONLY_ACTIVE_ARCH=NO -arch x86_64 -arch arm64 only_active_arch=no \
		DSTROOT=$(BINDERTMP)/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
	
	@rm -rf $(BINDER_STAGE_DIR)/
	@mkdir -p $(BINDER_STAGE_DIR)/Payload
	@mv $(BINDER_APP_DIR) $(BINDER_STAGE_DIR)/Payload/Muffle.app

	# Package
	@echo $(BINDERTMP)      
	@rm -rf packages

	# Move new app bundle to package directory
	@mkdir packages
	@mv $(BINDER_STAGE_DIR)/Payload/Muffle.app packages/Muffle.app
	@rm -rf $(BINDERTMP)
	@rm -rf Payload
	@codesign -f -s - packages/Muffle.app --preserve-metadata=entitlements
