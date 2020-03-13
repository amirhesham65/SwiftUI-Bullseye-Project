//
//  ContentView.swift
//  Bullseye
//
//  Created by Amir Hesham on 3/12/20.
//  Copyright © 2020 Amir Hesham. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State var alertIsVisible = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 0...100)
  @State var score = 0
  @State var round = 1
  
  let midNightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
  
  struct ShadowStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
  }
  
  struct ButtonLargeTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .foregroundColor(Color.black)
      .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
  
  struct ButtonSmallTextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .foregroundColor(Color.black)
      .font(Font.custom("Arial Rounded MT Bold", size: 12))
    }
  }
  
  // Styling the text view
  struct LabelStyle: ViewModifier {
    
    // Defining the view modifier body
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 18))
        .modifier(ShadowStyle())
    }
    
  }
  
  // Styling the value text view
  struct ValueStyle: ViewModifier {
    
    // Defining the view modifier ody
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.yellow)
        .font(Font.custom("Arial Rounded MT Bold", size: 24))
        .modifier(ShadowStyle())
    }
  }
  
  var body: some View {
    VStack(spacing: 14) {
      Spacer()
      // Target row
      HStack {
        Text("Put the bullseye as close as you can to: ").modifier(LabelStyle())
        
        Text("\(target)")
          .fontWeight(.bold)
          .modifier(ValueStyle())
      }
      Spacer()
      
      // Slider row
      HStack {
        Text("1").modifier(LabelStyle())
        Slider(value: $sliderValue, in: 1...100)
          .accentColor(Color.green)
        Text("100").modifier(LabelStyle())
      }
      Spacer()
      
      // Button row
      Button(action: { self.alertIsVisible = true }) {
        Text("Hit me!").modifier(ButtonLargeTextStyle())
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        // let roundedValue: Int = Int(sliderValue.rounded())
        return Alert(
          title: Text(alertTitle()),
          message: Text("The slider value is \(sliderValueRounded()). \n" + "You scored \(pointsForCurrentRound()) points this round"),
          dismissButton: .default(Text("Awesome")) {
            self.score = self.score + self.pointsForCurrentRound()
            self.target = Int.random(in: 1...100)
            self.round += 1
          }
        )
      }
      .background(Image("Button")).modifier(ShadowStyle())
      Spacer()
      
      // Score row
      HStack {
        Button (action: { self.startOver() }) {
          HStack {
            Image("StartOverIcon")
            Text("Start Over").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("Button")).modifier(ShadowStyle())
        Spacer()
        Text("Score:").modifier(LabelStyle())
        Text("\(score)").modifier(ValueStyle())
        Spacer()
        Text("Round:").modifier(LabelStyle())
        Text("\(round)").modifier(ValueStyle())
        Spacer()
        NavigationLink(destination: AboutView()) {
          HStack {
            Image("InfoIcon")
            Text("Info").modifier(ButtonSmallTextStyle())
          }
        }
        .background(Image("Button")).modifier(ShadowStyle())
      }
      .padding(.bottom, 20)
    }
    .accentColor(midNightBlue)
    .background(Image("Background"), alignment: .center)
    .navigationBarTitle("Bullseye")
  }
  
  func sliderValueRounded() -> Int {
    Int(sliderValue.rounded())
  }
  
  func amountOff() -> Int {
    abs(target - sliderValueRounded())
  }
  
  // Calculating the player awarded points
  func pointsForCurrentRound() -> Int {
    let maximumScore = 100
    let difference = amountOff()
    let bonus: Int
    if difference == 0 {
      bonus = 100
    } else if difference == 1 {
      bonus = 50
    } else {
      bonus = 0
    }
    return maximumScore - difference + bonus
  }
  
  func alertTitle() -> String {
    let difference = amountOff()
    let title: String
    if difference == 0 {
      title = "Perfect!"
    } else if difference < 5{
      title = "You almost had it!"
    } else if difference <= 10 {
      title = "Not bad."
    } else {
      title = "Are you even trying?"
    }
    
    return title
  }
  
  func startOver() -> Void {
    self.score = 0
    self.round = 1
    self.sliderValue = 50.0
    self.target = Int.random(in: 1...100)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
