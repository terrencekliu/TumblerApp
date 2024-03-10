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
    @State private var tabSelection = 1

    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabSelection) {
                RecentTabView(tabSelection: $tabSelection)
                    .tabItem { Label("In Progress", systemImage: "figure.walk") }
                    .tag(1)
                    .accessibilityIdentifier("tab-recent")
                TripTabView()
                    .tabItem { Label("Trips", systemImage: "beach.umbrella")}
                    .tag(2)
                    .accessibilityIdentifier("tab-trip")
                SettingTabView()
                    .tabItem { Label("Settings", systemImage: "gear")}
                    .tag(3)
                    .accessibilityIdentifier("tab-setting")
            }
        }
    }
}
