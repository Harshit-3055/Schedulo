import SwiftUI

struct ContentView: View {
    let calendar = Calendar.current
    @State private var selectedSection = "CSE-34"
    @Environment(\.colorScheme) var colorScheme
    let today = Date()
    let weekends: [String] = Calendar.current.shortWeekdaySymbols
    
    var todayIndex: Int {
        calendar.component(.weekday, from: today)
    }
    
    var todayName: String {
        weekends[todayIndex - 1]
    }
    
    @State private var daySelected: String = ""
    @State private var classes: [ClassSchedule] = []
    
    // Pass scheduleData instance
    let scheduleData: ScheduleData
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ForEach(weekends, id: \.self) { day in
                        Button(action: { dayPressed(dayPress: day) }) {
                            Text(day)
                                .frame(width: 45, height: 45)
                                .background(daySelected == day ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .clipShape(Circle())
                        }
                    }
                }
                Form {
                    ForEach(classes.indices, id: \.self) { index in
                        let classSchedule = classes[index]
                        VStack {
                            HStack {
                                Image(systemName: "book.fill")
                                Text(classSchedule.className)
                                Spacer()
                                Image(systemName: "clock.fill")
                                Text(classSchedule.time)
                            }
                            HStack {
                                Image(systemName: "location.fill")
                                Text(classSchedule.venue)
                                Spacer()
                            }
                        }
                    }
                }

                .navigationTitle("Schedulo")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker("Section", selection: $selectedSection) {
                            ForEach(0..<49) { sec in
                                Text("CSE-\(sec)").tag("CSE-\(sec)")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding()
                .onChange(of: selectedSection) { _ in
                    dayPressed(dayPress: daySelected)
                }
                .onAppear {
                    todaysDay(day: todayName)
                }
            }
        }
    }
    
    func dayPressed(dayPress: String) {
        daySelected = dayPress
        print("Day Selected: \(daySelected)")
        print("Section: \(selectedSection)")
        if let sectionSchedule = scheduleData.schedules[selectedSection]?[dayPress] {
            classes = sectionSchedule
            print("Classes: \(classes)")
        } else {
            classes = []
            print("No classes found for this day and section.")
        }
    }
    
    func todaysDay(day: String) {
        switch(day) {
        case "Sun": daySelected = "Sun"
        case "Mon": daySelected = "Mon"
        case "Tue": daySelected = "Tue"
        case "Wed": daySelected = "Wed"
        case "Thu": daySelected = "Thu"
        case "Fri": daySelected = "Fri"
        case "Sat": daySelected = "Sat"
        default:
            daySelected = "Holiday"
        }
        dayPressed(dayPress: daySelected)
    }
}

#Preview {
    // Ensure you pass the actual scheduleData instance here
    if let scheduleData = loadScheduleData() {
        ContentView(scheduleData: scheduleData)
    } else {
        Text("Failed to load schedule data")
    }
}
