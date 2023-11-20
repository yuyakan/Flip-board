//
//  BoardView.swift
//  Flip board
//
//  Created by 上別縄祐也 on 2023/11/20.
//

import SwiftUI

struct BoardView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var text: String
    @Binding var textColor: Color
    @Binding var selection: Int
    let image: String
    
    init(text: Binding<String>, textColor: Binding<Color>, selection: Binding<Int>, image: String) {
        self.image = image
        self._text = text
        self._textColor = textColor
        self._selection = selection
    }
    
    var body: some View {
        let fonts:[Font.Design] = [.default, .rounded, .serif, .monospaced]
        let bounds = UIScreen.main.bounds
        let height = Double(bounds.height)
        let width = Double(bounds.width)
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        }, label: {
                            Text("　")
                    })
                }
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack{
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName:"arrowshape.turn.up.left.circle.fill")
                                .accentColor(Color.gray)
                                .rotationEffect(Angle.degrees(90))
                    })
                        .padding(.trailing, width  * 0.9)
                }
            }
            Text(text).foregroundColor(textColor).font(.system(size: text.count < 6 ? height * 0.5 / Double(text.count) : height * 0.7 / 7,design: fonts[selection - 1])).rotationEffect(Angle.degrees(90)).frame(width: height * 0.65, height: width * 0.8)
        }.navigationBarHidden(true)
    }
}

