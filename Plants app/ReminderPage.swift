import SwiftUI

struct ReminderPage: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ReminderViewModel()
    @State private var animateCheck = false
    
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony"]
    let lights = ["Full sun", "Partial sun", "Shade"]
    let wateringDays = ["Every day", "Every 2 days", "Twice a week", "Once a week"]
    let waterAmounts = ["10–20 ml", "20–50 ml", "50–100 ml"]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 25) {
                // MARK: Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 36, height: 36)
                            .background(Color.white.opacity(0.08))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Set Reminder")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            animateCheck.toggle()
                        }
                        viewModel.addReminder()
                        viewModel.saveReminders()
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.2, green: 0.95, blue: 0.85))
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                                .shadow(color: Color(red: 0.2, green: 0.95, blue: 0.85).opacity(0.5),
                                        radius: 4, x: 0, y: 2)
                                .scaleEffect(animateCheck ? 1.1 : 1.0)
                            
                            Image(systemName: "checkmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // MARK: Plant Name
                glassField {
                    HStack {
                        Text("Plant Name")
                            .foregroundColor(.white.opacity(0.9))
                        Spacer()
                        TextField("Pothos", text: $viewModel.plantName)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.horizontal)
                
                // MARK: Room & Light (grouped)
                glassGroup {
                    pickerRow(label: "Room", systemImage: "paperplane", items: rooms, selection: $viewModel.room)
                    dividerLine()
                    pickerRow(label: "Light", systemImage: "sun.max", items: lights, selection: $viewModel.light)
                }
                .padding(.horizontal)
                
                // MARK: Watering Days & Water (grouped)
                glassGroup {
                    pickerRow(label: "Watering Days", systemImage: "drop", items: wateringDays, selection: $viewModel.wateringDays)
                    dividerLine()
                    pickerRow(label: "Water", systemImage: "drop", items: waterAmounts, selection: $viewModel.waterAmount)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 10)
        }
     
     

        
    }
    
    // MARK: Glass Field
    @ViewBuilder
    func glassField<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.03)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .background(.ultraThinMaterial.opacity(0.1))
            .overlay(content().padding(.horizontal))
            .frame(height: 55)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.8)
            )
            .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 2)
    }
    
    // MARK: Glass Group (two fields together)
    @ViewBuilder
    func glassGroup<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) {
            content()
        }
        .background(
            LinearGradient(
                colors: [
                    Color.white.opacity(0.07),
                    Color.white.opacity(0.03)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .background(.ultraThinMaterial.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 0.8)
        )
        .shadow(color: Color.black.opacity(0.5), radius: 6, x: 0, y: 2)
    }
    
    // MARK: Divider line between rows
    func dividerLine() -> some View {
        Rectangle()
            .fill(Color.white.opacity(0.1))
            .frame(height: 0.5)
            .padding(.leading, 40)
    }
    
    // MARK: Picker Row
    func pickerRow(label: String, systemImage: String, items: [String], selection: Binding<String>) -> some View {
        HStack {
            Label(label, systemImage: systemImage)
                .foregroundColor(.white.opacity(0.9))
            Spacer()
            Picker("", selection: selection) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accentColor(.white)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
    }
    
    
    
}

#Preview {
    ReminderPage()
        .preferredColorScheme(.dark)
}
