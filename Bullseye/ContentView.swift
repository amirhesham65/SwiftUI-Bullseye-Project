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
  
  var body: some View {
    VStack(spacing: 14) {
      Spacer()
      // Target row
      HStack {
        Text("Put the bullseye as close as you can to: ")
        Text("\(target)")
          .fontWeight(.bold)
      }
      Spacer()
      
      // Slider row
      HStack {
        Text("1")
        Slider(value: $sliderValue, in: 1...100)
        Text("100")
      }
      Spacer()
      
      // Button row
      Button(action: {
        self.alertIsVisible = true
      }) {
        Text("Hit me!")
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
      Spacer()
      
      // Score row
      HStack {
        Button (action: {
          self.startOver()
        }) {
          Text("Start Over")
        }
        Spacer()
        Text("Score:")
        Text("\(score)")
        Spacer()
        Text("Round:")
        Text("\(round)")
        Spacer()
        Button(action: {}) {
          Text("Info")
        }
      }
      .padding(.bottom, 20)
    }
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
