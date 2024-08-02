import Foundation
import SwiftUI

struct ClassSchedule:  Codable{
    let className: String
    let time: String
    let venue: String
}

struct ScheduleData: Codable {
    let schedules: [String: [String: [ClassSchedule]]]
}

func loadScheduleData() -> ScheduleData? {
    guard let url = Bundle.main.url(forResource: "schedule", withExtension: "json") else {
        print("Failed to find the JSON file")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let scheduleData = try decoder.decode(ScheduleData.self, from: data)
        return scheduleData
    } catch {
        print("Failed to load or decode JSON data: \(error)")
        return nil
    }
}

