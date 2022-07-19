//
//  ContentView.swift
//  WakeUp
//
//  Created by Александр on 15.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var isToggleOn = false
    @State var section = 0
    
    @State var numberOfPeople = 2
    
    var settings = ["First way", "Second way", "Third way"]
    
    var body: some View {
        VStack {
            Toggle(isOn: $isToggleOn, label: {
                Text("Show preferences")
            })
            ZStack {
                NavigationView {
                    Form {
                        Section {
                            Picker("Number of KEK", selection: $numberOfPeople) {
                                ForEach(2..<5) {
                                    Text("\($0) kek")
                                }
                            }
                        }
                    }
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .offset(x: isToggleOn ? UIScreen.main.bounds.size.width : 0)
                Text("SwiftUI testing. Turn on toggle")
                    .offset(x: isToggleOn ? UIScreen.main.bounds.size.width : 0)
            }
            .padding()
        }
        .padding()
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.4), value: isToggleOn)
   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
