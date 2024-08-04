import SwiftUI

struct SheetView: View {
    @Binding var isSheetPresented: Bool
    @Binding var selectedTab: Int
    @Binding var selectedSection: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Select Your Section")
                    .font(.headline)
                    .padding()
                
                Picker("Section", selection: $selectedSection) {
                    ForEach(1..<49) { sec in
                        Text("CSE-\(sec)").tag("CSE-\(sec)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .labelsHidden()
                
                Button("Done") {
                    isSheetPresented = false
                    selectedTab = 0 // Return to the Home tab
                }
                .padding()
            }
            .navigationTitle("Change Section")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SheetView(isSheetPresented: .constant(true), selectedTab: .constant(1), selectedSection: .constant("CSE-1"))
}
