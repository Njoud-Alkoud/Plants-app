import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ReminderViewModel()
    @State private var showSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                Group {
                    if viewModel.reminders.isEmpty {
                        welcomeSection
                    } else {
                        plantsSection
                    }
                }
            }
            .sheet(isPresented: $showSheet, onDismiss: {
                viewModel.loadReminders()
            }) {
                ReminderPage()
            }
            .onAppear { viewModel.loadReminders() }
        }
    }

    // MARK: - شاشة البداية
    private var welcomeSection: some View {
        VStack(spacing: 35) {
            Spacer()
            Image("plant")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            Text("Start your plant journey!")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)

            Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Button {
                showSheet = true
            } label: {
                Text("Set Plant Reminder")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 240, height: 50)
                    .background(Color(red: 0.5, green: 1.0, blue: 0.85))
                    .cornerRadius(25)
            }
            Spacer()
        }
    }

    // MARK: - شاشة النباتات
    private var plantsSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("My Plants 🌱")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 50)
                .frame(maxWidth: .infinity, alignment: .leading)

            Divider().background(Color.white.opacity(0.3))

            Text("Your plants are waiting for a sip 💦")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)

            // شريط التقدم
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.15))
                    .frame(height: 5)

                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green.opacity(0.8))
                        .frame(width: CGFloat(viewModel.progress) * geo.size.width)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.progress)
                }
                .frame(height: 5)
            }
            .frame(height: 5)

            // ✅ إذا كل النباتات مكتملة، نعرض صفحة "All Done!"
            if viewModel.reminders.allSatisfy({ $0.isDone }) && !viewModel.reminders.isEmpty {
                Spacer()
                VStack(spacing: 20) {
                    Image("happyPlant") // ← ضيفي الصورة في Assets بهذا الاسم
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 4)

                    Text("All Done! 🎉")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)

                    Text("All Reminders Completed")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer()
            } else {
                // قائمة النباتات
                List {
                    ForEach(viewModel.reminders) { plant in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 5) {
                                Image(systemName: "paperplane")
                                    .foregroundColor(.gray)
                                Text("in \(plant.room)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14))
                            }

                            HStack(spacing: 10) {
                                Button {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                        viewModel.toggleDone(plant.id)
                                    }
                                } label: {
                                    ZStack {
                                        Circle()
                                            .stroke(plant.isDone ? Color.green : Color.white.opacity(0.6), lineWidth: 2)
                                            .frame(width: 22, height: 22)
                                        if plant.isDone {
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.green)
                                        }
                                    }
                                }
                                .buttonStyle(.plain)

                                Text(plant.plantName)
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                            }

                            HStack(spacing: 10) {
                                Label(plant.light, systemImage: "sun.max")
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color.yellow.opacity(0.2))
                                    .cornerRadius(8)
                                    .foregroundColor(.yellow)

                                Label(plant.waterAmount, systemImage: "drop")
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(8)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 8)
                        // 🔥 السحب للحذف
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation {
                                    viewModel.reminders.removeAll { $0.id == plant.id }
                                    viewModel.saveReminders()
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                    }
                    .listRowBackground(Color.black)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.black)
            }

            // زر الإضافة العائم
            HStack {
                Spacer()
                Button {
                    showSheet = true
                } label: {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.2, green: 0.85, blue: 0.75),
                                        Color(red: 0.15, green: 0.9, blue: 0.7)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 65, height: 65)
                            .shadow(color: Color(red: 0.2, green: 0.95, blue: 0.85).opacity(0.8),
                                    radius: 12, x: 0, y: 0)
                            .overlay(
                                Circle().stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                            .shadow(color: Color.white.opacity(0.3), radius: 3, x: 0, y: 0)
                            .shadow(color: Color(red: 0.2, green: 1.0, blue: 0.8).opacity(0.4), radius: 8, x: 0, y: 0)

                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.white)
                            .shadow(color: .white.opacity(0.4), radius: 4, x: 0, y: 0)
                    }
                    .padding(.trailing, 25)
                    .padding(.bottom, 40)
                }
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 25)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
