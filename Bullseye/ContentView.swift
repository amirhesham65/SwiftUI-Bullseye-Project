//
//  ContentView.swift
//  Bullseye
//
//  Created by Amir Hesham on 3/12/20.
//  Copyright © 2020 Amir Hesham. All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        Text("Hello, World!")
//    }
//}

struct ContentView: View {
  
  @State var alertIsVisible = false
  
  var body: some View {
    VStack(spacing: 14) {
      Text("Welcome to the app")
      Button(action: {
        self.alertIsVisible = true
      }) {
        Text("PRESS ME")
      }
      .alert(isPresented: $alertIsVisible) { () ->
        Alert in
        return Alert(
          title: Text("Alert"),
          message: Text("Some message to be told!"),
          dismissButton: .default(Text("Awesome"))
        )
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
