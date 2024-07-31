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
                    ForEach(classes) { classSchedule in
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
                    Picker("Section", selection: $selectedSection) {
                        ForEach(["CSE-34", "CSE-35"], id: \.self) { sec in
                            Text(sec).tag(sec)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
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
        if let sectionSchedule = ScheduleData.schedules[selectedSection]?[dayPress] {
            classes = sectionSchedule
        } else {
            classes = []
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
    ContentView()
}
