import SwiftUI

struct ContentView: View {
    let calendar = Calendar.current
    @AppStorage("selectedSection") private var selectedSection = "CSE-1"
    @State private var isSheetPresented = false
    @State private var selectedTab = 0 // Track the selected tab
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
    
    let scheduleData: ScheduleData
    
    var body: some View {
        TabView(selection: $selectedTab) {
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
                                        .bold()
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
                                ForEach(1..<49) { sec in
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
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)
            
            Text("") // Placeholder view
                .tabItem {
                    Label("Change Section", systemImage: "rectangle.and.pencil.and.ellipsis")
                }
                .tag(1)
                .onAppear {
                    isSheetPresented = true
                }
        }
        .sheet(isPresented: $isSheetPresented, onDismiss: {
            // Return to the Home tab after dismissing the sheet
            selectedTab = 0
        }) {
            SheetView(isSheetPresented: $isSheetPresented, selectedTab: $selectedTab, selectedSection: $selectedSection)
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
        daySelected = day
        dayPressed(dayPress: daySelected)
    }
}

#Preview {
    if let scheduleData = loadScheduleData() {
        ContentView(scheduleData: scheduleData)
    } else {
        Text("Failed to load schedule data")
    }
}
