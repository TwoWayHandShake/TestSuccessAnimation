//
//  ContentView.swift
//  TestSuccessAnimation
//
//  Created by Daniel Orlowski on 15.11.22.
//

import SwiftUI

struct ContentView: View {
  @State private var showingSheet = false
  
  
  var body: some View {
    ZStack{
      Color(hex: 0x06174a).ignoresSafeArea()
      VStack {
        
        Button("Show Sheet") {
          showingSheet.toggle()
        }.foregroundColor(.white)
          .sheet(isPresented: $showingSheet)
          {
            SheetView().presentationDetents([.fraction(0.85)])
              
             
              
          }
        
      }
    }
    
  }
}


struct SheetView: View {

  @Environment(\.dismiss) var dismiss
  let gradient = Gradient(colors: [Color("c1"), Color("c2"), Color("c3")])
  var colors = [Color("c1"), Color("c2"), Color("c3")]
  var text = "Wird weitergeleitet"
  private var hapticManager = HapticManager()
  
  @State var scale = 0.75

  
  init() {
    hapticManager?.playSlice()

  }
  

  var body: some View {
    
   
    
    VStack{
      // Top Bar
      HStack {
        Spacer()
        Button {
          dismiss()
        } label: {
          Image(systemName: "xmark.circle.fill")
        }
        .font(.title2)
        .foregroundColor(Color(hex: 0xDFDFE4))
        .padding()
        .background(.white)
      }
      
      
      // Background Card + Name Cards
      VStack (spacing: -40){
        VStack {
          ZStack {
            Rectangle()
              .fill(
                LinearGradient(colors: colors, startPoint: .topLeading , endPoint: .bottomTrailing))
            
            VStack (spacing: 5) {
              HStack (spacing: 30) {
                Card(initials: "FF", name: "Frank Felsing")
                  .padding(.top, 0.0)
                  .scaleEffect(scale)
                  .onAppear {
    //                let baseAnimation = Animation.easeInOut(duration: 0.3)
                    let baseAnimation = Animation.spring()
                    withAnimation(baseAnimation){
                      scale = 1
                    }
                    
                  }
                  
                
                Card(initials: "BS", name: "Beate Simons")
                  .scaleEffect(scale)
                  .onAppear {
                    //                let baseAnimation = Animation.easeInOut(duration: 0.3)
                    let baseAnimation = Animation.spring()
                    withAnimation(baseAnimation){
                      scale = 1
                    }
                  }
              }

            }
          }
          .frame(height: 250)
          .cornerRadius(40)
        .padding()
        }
        VStack (spacing: -40){
          LottieView(name: "check3", loopMode: .playOnce)
            .frame(width: 150 , height: 150)
          Text(text).foregroundColor(.gray)
        }
        
      }
      
      
      
     
      
      Spacer()
      
      Button {
        dismiss()
      } label: {
        Text("Schließen")
        
      }
      .font(.body)
      .fontWeight(.semibold)
      .tracking(0.5)
      .textCase(.uppercase)
      .foregroundColor(.white)
      .padding()
      // Just standard size
      .frame(width: 350)
      .background(.orange)
      .cornerRadius(60)
      
    }
    .background(.white)
   
  
    }
    
    
}

extension Color {
  init(hex: Int, opacity: Double = 1.0) {
    let red = Double((hex & 0xff0000) >> 16) / 255.0
    let green = Double((hex & 0xff00) >> 8) / 255.0
    let blue = Double((hex & 0xff) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
  }
}

struct Card: View {
  var initials: String = "fas"
  var name: String = "dfasd"
 
  
  var body: some View{
    ZStack {

      
      VStack {
        VStack(){
          ZStack {
            Circle().frame(width: 64, height: 64)
              .foregroundColor(Color("AvatarColor"))
            Text(initials).foregroundColor(.white)
              .font(.title2)
              .fontWeight(.bold)
          }
          
          Text(name)
            .font(.callout)
            .foregroundColor(Color("AvatarColor"))
            .multilineTextAlignment(.center)
        }
        Spacer()
        
      }
      .frame(width: 140, height: 130)
      .padding(.top, 24.0)
      .background(.white)
      .cornerRadius(32)
      
      
      
    }
    .padding(.top)
  }
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView()
  }
}
