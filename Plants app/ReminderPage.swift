

import SwiftUI

struct ReminderPage: View {
    var body: some View {
        
        NavigationLink(destination: ReminderPage()) {
            
            
            
            
            
            VStack{
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(red: 28/255, green: 28/255, blue: 30/255))
                    .frame(width: UIScreen.main.bounds.width - 1, height: UIScreen.main.bounds.height * 0.90)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height * 0.5)
                
            }
            
            
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.gray.opacity(0.3))
                          .frame(width: UIScreen.main.bounds.width - 25,
                                 height: UIScreen.main.bounds.height * 0.07)
                          .shadow(color: .black.opacity(0.2), radius: 25, x: 0, y: 15)
                          .padding(.top, -220)
                          .position(x: UIScreen.main.bounds.width / 400, y: UIScreen.main.bounds.height * 0.45)
            
            
            
            
            
            
            .overlay(
                VStack(alignment: .leading, spacing: 20) {
                    Text("Set Reminder")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.top, -320)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .position(x: UIScreen.main.bounds.width / 400, y: UIScreen.main.bounds.height * 0.45)
                    
                
                    
                    
                    
                }
                
                
            )
            
            
            
            
            
        }
        
    }
        
    }
    
    
    #Preview {
        ReminderPage()
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .preferredColorScheme(.dark) // No matter what the user’s system setting is (Light or Dark) always dark
    }

