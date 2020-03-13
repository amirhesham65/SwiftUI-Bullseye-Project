//
//  AboutView.swift
//  Bullseye
//
//  Created by Amir Hesham on 3/13/20.
//  Copyright © 2020 Amir Hesham. All rights reserved.
//

import SwiftUI

struct AboutView: View {
  
  // Styling the Heading text
  struct HeadingTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .font(Font.custom("Arial Rounded MT Bold", size: 30))
        .foregroundColor(Color.black)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
  }
  
  // Styling text style
  struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .font(Font.custom("Arial Rounded MT Bold", size: 16))
        .foregroundColor(Color.black)
        .padding(.leading, 60)
        .padding(.trailing, 60)
        .padding(.bottom, 20)
    }
  }
  
  var body: some View {
    Group {
      VStack {
        Text("🎯 Bullseye 🎯")
          .modifier(HeadingTextStyle())
        Text("This is Bullseye, the game where you can win and do great things with a slider and win great things")
        .modifier(TextStyle())
      }
      .navigationBarTitle("About")
      .background(Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0))
    }
  .background(Image("Background"))
  }
  
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView().previewLayout(.fixed(width: 896, height: 414))
  }
}
