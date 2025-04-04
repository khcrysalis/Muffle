//
//  MuffleApp.swift
//  Muffle
//
//  Created by samara on 3.04.2025.
//

import SwiftUI

@main
struct MuffleApp: App {
    var body: some Scene {
		MenuBarExtra {
			SwitchesView()
		} label: {
			Image(systemName: "iphone.gen1.radiowaves.left.and.right")
		}
		.menuBarExtraStyle(.window)
    }
}
