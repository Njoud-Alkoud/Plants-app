
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            
            
            VStack {
               
                Text("My Plants 🌱")
                
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.top, 60)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                
                Spacer()
                
                Divider()
                
                Rectangle()
                    .foregroundColor(.gray.opacity(0.7))
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .offset(x: 0)
                    .padding(.top, 12)
                    .ignoresSafeArea(edges: .horizontal)
                Spacer()
                
                    .padding(.bottom, 400)
                    .padding(.top, 30)
                
                
                
                
                VStack {
                    
                    Image("plant")
                    
                        .frame(width: 315, height: 220)
                        .offset(y: -400)
                    Spacer()
                    
                    
                }
                Text("Start your plant journey! ")
                    .font(.title2.bold())
                    .padding(.top, -370)
                
                
                Text(" Now all your plants will be in one place and \n we will help you take care of them :)🪴" )
                    .padding(.top, -320)
                    .foregroundColor(Color.gray.opacity(0.8))
                    .multilineTextAlignment(.center)
                
       
                
                
                
            }
            
            VStack {
                Spacer()
                
                NavigationLink(destination: ReminderPage()) {
                    Text("Set Plant Reminder")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 220, height: 45)
                        .background(Color(red: 20/255, green: 215/255, blue: 198/255))
                        .cornerRadius(90)
                        .padding(.top, -170)
                }

                Spacer()
            }
            
            
        }
        
        
        }
    
    }
    
    
    
    #Preview {
        ContentView()
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .preferredColorScheme(.dark) // No matter what the user’s system setting is (Light or Dark) always dark
    }


