//
//  ScheduleData.swift
//  Schedulo
//
//  Created by Harshit Agarwal on 01/08/24.
//

import Foundation

import SwiftUI

struct ClassSchedule: Identifiable {
    let id = UUID() // Unique identifier for the item
    let className: String
    let time: String
    let venue: String
}

struct ScheduleData {
    static let schedules: [String: [String: [ClassSchedule]]] = [
        "CSE-34": [
            "Sun": [
                ClassSchedule(className: "Holiday", time: "Holiday", venue: "Holiday")
            ],
            "Mon": [
                ClassSchedule(className: "STW", time: "9:00-10:00", venue: "C-LH-307"),
                ClassSchedule(className: "PS", time: "10:00-11:00", venue: "C-LH-307"),
                ClassSchedule(className: "IND4", time: "11:00-12:00", venue: "C-LH-402"),
                ClassSchedule(className: "AFL", time: "12:00-1:00", venue: "C-LH-402")
            ],
            "Tue": [
                ClassSchedule(className: "PS", time: "9:00-10:00", venue: "ETC_LT-2"),
                ClassSchedule(className: "DS", time: "10:00-11:00", venue: "ETC_LT-2"),
                ClassSchedule(className: "DSD", time: "11:00-12:00", venue: "C12_DEC(new)"),
                ClassSchedule(className: "DSD(L)-1", time: "12:00-1:00", venue: "C12_DEC(new)"),
                ClassSchedule(className: "DSD(L)-2", time: "1:00-2:00", venue: "C12_DEC(new)")
            ],
            "Wed": [
                ClassSchedule(className: "AFL", time: "8:00-9:00", venue: "C-LH-306"),
                ClassSchedule(className: "DS", time: "9:00-10:00", venue: "C-LH-306"),
                ClassSchedule(className: "IND4", time: "10:00-11:00", venue: "C-LH-306"),
                ClassSchedule(className: "DSD", time: "11:00-12:00", venue: "C-LH-408"),
                ClassSchedule(className: "PS", time: "12:00-1:00", venue: "C-LH-408")
            ],
            "Thu": [
                ClassSchedule(className: "DS", time: "8:00-9:00", venue: "C-LH-307"),
                ClassSchedule(className: "STW", time: "9:00-10:00", venue: "C-LH-307"),
                ClassSchedule(className: "DSD", time: "10:00-11:00", venue: "C-LH-307"),
                ClassSchedule(className: "AFL", time: "2:00-3:00", venue: "C-LH-408"),
                ClassSchedule(className: "PS", time: "3:00-4:00", venue: "C-LH-408"),
                ClassSchedule(className: "DS(L)-1", time: "4:00-5:00", venue: "C-WL-301"),
                ClassSchedule(className: "DS(L)-2", time: "5:00-6:00", venue: "C-WL-301")
            ],
            "Fri": [
                ClassSchedule(className: "Holiday", time: "Holiday", venue: "Holiday")
            ],
            "Sat": [
                ClassSchedule(className: "AFL", time: "11:00-12:00", venue: "C-LH-301"),
                ClassSchedule(className: "DS", time: "12:00-1:00", venue: "C-LH-301")
            ]
        ]
        // Add more sections here if needed
    ]
}
