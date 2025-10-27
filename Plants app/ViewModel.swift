import Foundation

class ReminderViewModel: ObservableObject {
    @Published var reminders: [ReminderModel] = []
    
    @Published var plantName = ""
    @Published var room = "Bedroom"
    @Published var light = "Full sun"
    @Published var wateringDays = "Every day"
    @Published var waterAmount = "20–50 ml"

    private let saveKey = "SavedReminders"

    init() { loadReminders() }

    func addReminder() {
        let new = ReminderModel(
            plantName: plantName.isEmpty ? "Unnamed Plant" : plantName,
            room: room, light: light, wateringDays: wateringDays,
            waterAmount: waterAmount, isDone: false  // ✅
        )
        reminders.append(new)
        saveReminders()
    }

    func toggleDone(_ id: UUID) {
        guard let idx = reminders.firstIndex(where: { $0.id == id }) else { return }
        reminders[idx].isDone.toggle()
        
        // ✅ أعد نشر القائمة كاملة عشان الـ UI يحدث
        reminders = reminders.map { $0 }
        
        saveReminders()
    }

    func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func loadReminders() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([ReminderModel].self, from: data) {
            reminders = decoded
        } else {
            reminders = []
        }
    }

    // ✅ نسبة الإنجاز للشريط
    var progress: Double {
        guard !reminders.isEmpty else { return 0 }
        let done = reminders.filter { $0.isDone }.count
        return Double(done) / Double(reminders.count)   // من 0 إلى 1
    }
    
}
