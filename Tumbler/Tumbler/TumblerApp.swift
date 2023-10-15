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
                TripTabView()
                    .tabItem { Label("Trips", systemImage: "beach.umbrella")}
                SettingTabView()
                    .tabItem { Label("Settings", systemImage: "gear")}
            }
            
        }
    }
}
