//
//  Muffin+SilenceFinder.swift
//  Muffle
//
//  Created by samara on 3.04.2025.
//

extension Muffle {
	static let ignoreDevicesKey = ["com.apple.AMPDeviceDiscoveryAgent", "ignore-devices"]
	static let revealDevicesKey = ["com.apple.AMPDeviceDiscoveryAgent", "reveal-devices"]
	static let dontAutomaticallySyncIPodsKey = ["com.apple.AMPDevicesAgent", "dontAutomaticallySyncIPods"]
	
	static func toggleFinderSilence(enabled: Bool) {
		Muffle._toggleSilence(should: enabled)
		Muffle._restartFinder()
	}
	
	static private func _toggleSilence(should: Bool) {
		Muffle._run("/usr/bin/defaults", ["write", ignoreDevicesKey[0], ignoreDevicesKey[1], "-bool", should ? "true" : "false"])
		Muffle._run("/usr/bin/defaults", ["write", revealDevicesKey[0], revealDevicesKey[1], "-bool", should ? "false" : "true"])
		Muffle._run("/usr/bin/defaults", ["write", dontAutomaticallySyncIPodsKey[0], dontAutomaticallySyncIPodsKey[1], "-bool", should ? "true" : "false"])
	}
	
	static func isFinderSilenceEnabled() -> Bool {
		let ignoreDevices = Muffle._readDefault(ignoreDevicesKey)
		let revealDevices = Muffle._readDefault(revealDevicesKey)
		let dontAutomaticallySyncIPods = Muffle._readDefault(dontAutomaticallySyncIPodsKey)
		
		return ignoreDevices == true && revealDevices == false && dontAutomaticallySyncIPods == true
	}
}
