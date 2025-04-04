//
//  SwitchesView.swift
//  Muffle
//
//  Created by samara on 3.04.2025.
//

import SwiftUI

struct SwitchesView: View {
	@State private var isSilenceFinderOn = false
	@State private var isLadyBugOn = false
	
	var body: some View {
		VStack(spacing: 20) {
			_toggleSwitch(
				"Silence Finder Devices",
				"Make Finder shut up from popping up every time you plug in an iDevice.",
				isOn: $isSilenceFinderOn
			)
			Divider()
			_toggleSwitch(
				"NS🐞",
				"Ladybug debugging menu",
				isOn: $isLadyBugOn
			)
			_footerView()
		}
		.padding()
		.onAppear {
			isSilenceFinderOn = Muffle.isFinderSilenceEnabled()
			isLadyBugOn = Muffle.isLadybugEnabled()
		}
		.onChange(of: isSilenceFinderOn) { value in
			Muffle.toggleFinderSilence(enabled: value)
		}
		.onChange(of: isLadyBugOn) { value in
			Muffle.toggleLadybug(enabled: value)
		}
	}
	
	@ViewBuilder
	private func _toggleSwitch(_ name: String, _ desc: String, isOn: Binding<Bool>) -> some View {
		VStack(alignment: .leading) {
			HStack {
				Text(name)
				Spacer()
				Toggle("", isOn: isOn)
					.toggleStyle(.switch)
					.tint(.accentColor)
			}
			Text(desc)
				.foregroundStyle(.primary.opacity(0.7))
				.font(.subheadline)
		}
	}
	
	@ViewBuilder
	private func _footerView() -> some View {
		HStack(spacing: 10) {
			_link("Donate", urlString: "https://github.com/sponsors/khcrysalis")
			_link("Github", urlString: "https://github.com/khcrysalis")
		}
	}
	
	@ViewBuilder
	func _link(_ title: String, urlString: String) -> some View {
		Link(destination: URL(string: urlString)!) {
			Text(title)
				.foregroundColor(.white)
				.frame(maxWidth: .infinity)
		}
		.padding(.vertical, 6)
		.background(Color.gray.opacity(0.3))
		.cornerRadius(7)
	}


}

