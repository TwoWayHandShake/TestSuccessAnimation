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
          .sheet(isPresented: $showingSheet) {
            SheetView()
          }
        
      }
    }
    
  }
}


struct SheetView: View {
  @Environment(\.dismiss) var dismiss
  let gradient = Gradient(colors: [Color("c1"), Color("c2"), Color("c3")])
  var colors = [Color("c1"), Color("c2"), Color("c3")]
  
  
  var body: some View {
    
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
    
    
    ZStack {
      Rectangle()
        .fill(
          LinearGradient(colors: colors, startPoint: .topLeading , endPoint: .bottomTrailing))
      
      VStack {
        HStack (spacing: 20) {
          Card(initials: "FF", name: "Frank Felsing")
          Card(initials: "BS", name: "Beate Simons")
        }
        Rectangle().frame(width: 50, height: 50)
          .foregroundColor(.white.opacity(0.5))
          .cornerRadius(15)
          
      }
      
      
    }
    .frame(height: 300)
    .cornerRadius(15)
    .padding()
    
    Text("Wird an Beate Simons weitergeleitet").foregroundColor(.gray)
    
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
        ZStack {
          Circle().frame(width: 60, height: 60)
          Text(initials).foregroundColor(.white)
        }
        Text(name)
      }
      .padding(.vertical, 25.0)
      .padding(.horizontal, 15.0)
      .background(.white)
      .cornerRadius(15)
      
      
    }
    .padding(.top)
  }
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    ContentView()
  }
}
