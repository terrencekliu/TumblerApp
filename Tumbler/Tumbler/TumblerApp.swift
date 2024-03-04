//
//  TumblerApp.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI
import SwiftData

@main
struct TumblerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                RecentTabView()
                    .tabItem { Label("In Progress", systemImage: "figure.walk") }
                    .accessibilityIdentifier("tab-recent")
                TripTabView()
                    .tabItem { Label("Trips", systemImage: "beach.umbrella")}
                    .accessibilityIdentifier("tab-trip")
                SettingTabView()
                    .tabItem { Label("Settings", systemImage: "gear")}
                    .accessibilityIdentifier("tab-setting")
            }
        }
    }
}
