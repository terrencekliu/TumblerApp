//
//  TumblerApp.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

@main
struct TumblerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                RecentTabView()
                    .tabItem { Label("In Progress", systemImage: "figure.walk") }
                    .accessibilityIdentifier("tab-recent")
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                TripTabView()
                    .tabItem { Label("Trips", systemImage: "beach.umbrella")}
                    .accessibilityIdentifier("tab-trip")
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                SettingTabView()
                    .tabItem { Label("Settings", systemImage: "gear")}
                    .accessibilityIdentifier("tab-setting")
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
            }
        }
    }
}
