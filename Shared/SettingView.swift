//
//  SettingView.swift
//  Flip board
//
//  Created by 上別縄祐也 on 2023/11/20.
//

import SwiftUI

struct SettingView: View {
    @State var selection = 3
    @State var textColor: Color
    @State var backColor = Color.white
    @State var text = "Flip board"
    let image: String
    
    init(defaultTextColor: Color, image: String) {
        self.textColor = defaultTextColor
        self.image = image
    }
    
    var body: some View {
        let fonts:[Font.Design] = [.default, .rounded, .serif, .monospaced]
        let bounds = UIScreen.main.bounds
        let width = Double(bounds.width)
        let height = Double(bounds.width)
        ZStack{
            VStack{
                Spacer()
                ZStack{
                    Image(image).rotationEffect(Angle.degrees(-90))
                    Text(text).foregroundColor(textColor).font(.system(size: text.count < 6 ? height * 0.5 / Double(text.count) : height * 0.7 / 7, design: fonts[selection - 1])).frame(width: 300 * 0.8, height:  220 * 0.67)
                }
                Spacer()
                HStack{
                    Text("Text")
                        .font(.system(.title,design: fonts[selection - 1]))
                        .padding()
                    Spacer()
                    TextField("", text: $text)
                        .font(.title)
                        .frame(width: width * 0.6,alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                    
                }
                ColorPicker("Text color", selection: $textColor).foregroundColor(Color.black).font(.system(.title,design: fonts[selection - 1])).padding(.trailing, width*0.1)
                    .padding()
                HStack{
                    Text("Font").font(.system(.title,design: fonts[selection - 1]))
                        .padding()
                    Spacer()
                    Picker(selection: $selection, label: Text("Font").font(.system(.title, design: .default))) {
                                    Text("default").font(.system(.largeTitle, design: .default)).tag(1)
                                    Text("rounded").font(.system(.largeTitle, design: .rounded)).tag(2)
                                    Text("serif").font(.system(.largeTitle, design: .serif)).tag(3)
                                    Text("monospaced").font(.system(.largeTitle, design: .monospaced)).tag(4)
                                }
                                .frame(width: 100)
                }
                Spacer()
                NavigationLink(destination: BoardView(text: $text, textColor: $textColor, selection: $selection, image: image)) {
                    Text("Flip").font(.title)
                }
                AdView().frame(width: 320, height: 50)
            }.navigationBarTitleDisplayMode(.inline)
        }
    }
}

