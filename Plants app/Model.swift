
import Foundation

struct ReminderModel: Identifiable, Codable {
    let id = UUID()
    var plantName: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isDone: Bool = false   // ✅ جديد
}
