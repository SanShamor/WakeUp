//
//  ContentView.swift
//  WakeUp
//
//  Created by Александр on 15.07.2022.
//

import AVFoundation
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published public var maxDuration = 0.0
    private var player: AVAudioPlayer?
    
    public func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
    }
    
    public func play() {
        playSong(name: "Omnissiah")
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
}

struct ContentView: View {
    @State var isToggleOn = false
    @State var section = 0
    
    @State var numberOfPeople = 2
    
    @State var progress: Float = 0
    @ObservedObject var viewModel = PlayerViewModel()
    
    var settings = ["Свин-паук", "Лентяй", "Недо-программист", "Трудяга"]
    
    var body: some View {
        VStack {
            Toggle(isOn: $isToggleOn, label: {
                Text("Настроить себя")
            })
            ZStack {
                NavigationView {
                    Form {
                        Section {
                            Picker("Кто я:", selection: $numberOfPeople) {
                                ForEach(0..<settings.count) {
                                    Text("\(settings[$0])")
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
            
            VStack {
                Slider(value: Binding(get: {
                    self.progress
                }, set: { newTimeValue in
                    self.progress = newTimeValue
                    self.viewModel.setTime(value: newTimeValue)
                }), in: 0...100)
                .padding()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.viewModel.play()
                    }, label: {
                        Text("Play")
                            .foregroundColor(Color.gray)
                    })
                    .frame(width: 60, height: 60)
                    .background(Color.mint)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button(action: {
                        self.viewModel.setTime(value: 0)
                        self.progress = 0
                        self.viewModel.stop()
                    }, label: {
                        Text("Stop")
                            .foregroundColor(Color.gray)
                    })
                    .frame(width: 60, height: 60)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                .padding()
                
            }
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
