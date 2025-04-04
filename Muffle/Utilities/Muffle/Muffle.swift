//
//  Muffle.swift
//  Muffle
//
//  Created by samara on 3.04.2025.
//

import Foundation

class Muffle {
	static func _restartFinder() {
		_run("/usr/bin/killall", ["Finder"])
	}
	
	static func _readDefault(_ keys: [String]) -> Bool {
		let process = Process()
		process.executableURL = URL(fileURLWithPath: "/usr/bin/defaults")
		
		process.arguments = ["read"] + keys
		
		let pipe = Pipe()
		process.standardOutput = pipe
		
		do {
			try process.run()
			process.waitUntilExit()
			
			let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
			if let outputString = String(data: outputData, encoding: .utf8)?
				.trimmingCharacters(in: .whitespacesAndNewlines) {
				print(outputString)
				return outputString == "1"
			}
		} catch {
			print("Error reading defaults: \(error)")
		}
		
		return false
	}
}
