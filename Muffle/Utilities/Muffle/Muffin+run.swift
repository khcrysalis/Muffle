//
//  Muffin+run.swift
//  Muffle
//
//  Created by samara on 3.04.2025.
//

import Foundation

extension Muffle {
	static func _run(_ command: String, _ arguments: [String]) {
		let process = Process()
		process.executableURL = URL(fileURLWithPath: command)
		process.arguments = arguments
		
		do {
			try process.run()
			process.waitUntilExit()
		} catch {
			print("Error running process: \(error)")
		}
	}
}
