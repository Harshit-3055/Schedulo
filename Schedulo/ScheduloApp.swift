//
//  ScheduloApp.swift
//  Schedulo
//
//  Created by Harshit Agarwal on 31/07/24.
//

import SwiftUI

@main
struct ScheduloApp: App {
    var body: some Scene {
        WindowGroup {
            if let scheduleData = loadScheduleData() {
                ContentView(scheduleData: scheduleData)
            } else {
                Text("Failed to load schedule data")
            }
        }
    }
}

