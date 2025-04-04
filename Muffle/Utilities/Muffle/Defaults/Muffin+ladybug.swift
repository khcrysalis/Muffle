//
//  Muffin+ladybug.swift
//  Muffle
//
//  Created by samara on 3.04.2025.
//

extension Muffle {
	static let ladybugKey = ["-g", "_NS_4445425547"]
	
	static func toggleLadybug(enabled: Bool) {
		
		Muffle._run("/usr/bin/defaults", ["write", ladybugKey[0], ladybugKey[1], "-bool", enabled ? "true" : "false"])
		
		Muffle._restartFinder()
	}
	
	static func isLadybugEnabled() -> Bool {
		return Muffle._readDefault(ladybugKey) == true
	}
}
