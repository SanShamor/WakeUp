//
//  ContentView.swift
//  WakeUp
//
//  Created by Александр on 15.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var isToggleOn = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .offset(x: isToggleOn ? 200 : 0)
            Text("SwiftUI testing")
                .offset(x: isToggleOn ? 200 : 0)
            }
            Toggle(isOn: $isToggleOn, label: {
                Text("Hide info")
            })
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
