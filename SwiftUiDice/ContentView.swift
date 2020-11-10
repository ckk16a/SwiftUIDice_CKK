//
//  ContentView.swift
//  SwiftUiDice
//
//  Created by Carson Kelley on 11/10/20.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
//    @State var diceImage = "d1"
//    @State var diceText = "Tap the dice or shake to roll!"
    
    @State var rolledNumber = 1
    @State var diceText = "Tap the dice or shake to roll!"
    
    var body: some View {
        ZStack {
            ShakableViewRepresentable()
                .allowsHitTesting(false)
            VStack(alignment: .center) {
                Button(action: {
                    rollDice()
                }) {
                    Image("d\(rolledNumber)")
                        .padding(10)
                }
                Text(diceText)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .padding(10)
            }
                .onReceive(messagePublisher) { _ in
                            rollDice()
            }
        }
    }
    
    func rollDice() {
        let randomNumber = Int.random(in: 1...20)

        self.rolledNumber = randomNumber

        if(randomNumber == 1){
            self.diceText = "Critical Miss! #Oof"
            playSound(sound: "criticalmiss", type: "mp3")
        } else if(randomNumber == 20){
            self.diceText = "Critical Hit! It's Your Lucky Day!"
            playSound(sound: "criticalhit", type: "mp3")
        } else{
            playSound(sound: "diceroll", type: "wav")
            self.diceText = ""
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
