//
//  Sky2View.swift
//  Flip board
//
//  Created by 上別縄祐也 on 2022/02/26.
//

import SwiftUI

struct Sky2View: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var text: String
    @Binding var textcolor: Color
    @Binding var backcolor: Color
    @Binding var selection: Int
    
    var body: some View {
        let fonts:[Font.Design] = [.default, .rounded, .serif, .monospaced]
        let bounds = UIScreen.main.bounds
        let height = Double(bounds.height)
        let width = Double(bounds.width)
        ZStack{
            Image("sky2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            Text(text).foregroundColor(textcolor).font(.system(size: text.count < 6 ? height * 0.5 / Double(text.count) : height * 0.7 / 7,design: fonts[selection - 1])).rotationEffect(Angle.degrees(90)).frame(width: height * 0.67, height: width * 0.8)
            VStack{
                Spacer()
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
        }.navigationBarHidden(true)
    }
}




