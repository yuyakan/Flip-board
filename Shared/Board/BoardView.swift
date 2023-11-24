//
//  BoardView.swift
//  Flip board
//
//  Created by 上別縄祐也 on 2023/11/20.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var interstitial: Interstitial
    @Environment(\.undoManager) private var undoManager
    @Environment(\.dismiss) var dismiss
    @State var views : [TextView] = []
    let image: String
    
    init(image: String, interstitial: Interstitial) {
        self.image = image
        self.interstitial = interstitial
    }
    
    var body: some View {
        let bounds = UIScreen.main.bounds
        let height = Double(bounds.height)
        HStack{
            Spacer()
            VStack{
                if height > 700 {
                    Text("").frame(height: 100)
                }
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
                if UIScreen.main.nativeBounds.height > 2208 || UIScreen.main.nativeBounds.height == 1792{
                    Text("").frame(height: 12)
                }
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
            .frame(width: height > 700 ? height : height * 1.5, height: height > 700 ? height : height * 1.5)
            VStack{
                Spacer()
                Button(action: {
                    views.append(TextView(views: $views, id: UUID()))
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .padding(UIScreen.main.nativeBounds.height > 2208 || UIScreen.main.nativeBounds.height == 1792 ? .trailing : [.bottom, .trailing] ,  10)
                })
                if height > 700 {
                    Text("").frame(height: 100)
                }
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear(){
            interstitial.presentInterstitial()
        }
    }
}

