//
//  BoardView.swift
//  Flip board
//
//  Created by 上別縄祐也 on 2023/11/20.
//

import SwiftUI

struct BoardView: View {
    @Environment(\.undoManager) private var undoManager
    @Environment(\.dismiss) var dismiss
    @State var views : [TextView] = []
    let image: String
    
    init(image: String) {
        self.image = image
    }
    
    var body: some View {
        let bounds = UIScreen.main.bounds
        let height = Double(bounds.height)
        HStack{
            Spacer()
            VStack{
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName:"square.stack.3d.up")
                        .font(.system(size: 24))
                        .padding([.top, .leading], 10)
                })
                Spacer()
            }
            VStack {
                Text("").frame(height: 8)
                ZStack {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(Angle.degrees(270))
                    ForEach(views) { view in
                        view
                    }
                }
            }
            .frame(width: height * 1.5, height: height * 1.5)
            VStack{
                Spacer()
                Button(action: {
                    views.append(TextView(views: $views, id: UUID()))
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .padding(.leading,  6)
                })
            }
            Spacer()
        }.navigationBarHidden(true)
    }
}

