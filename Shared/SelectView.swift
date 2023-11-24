//
//  ContentView.swift
//  Shared
//
//  Created by 上別縄祐也 on 2022/02/25.
//

import SwiftUI
import GoogleMobileAds

struct SelectView: View {
    @ObservedObject var interstitial = Interstitial()
    var body: some View {
        let bounds = UIScreen.main.bounds
        let width = Double(bounds.width)
        let height = Double(bounds.height)
        let selectImage = ["selectwhite", "brackboard", "manga", "book", "sky", "brick", "brackboard2", "brick2", "wall", "moon", "winter", "star", "sky2", "color", "sand"]
        NavigationView{
            VStack{
                Spacer()
                Text(LocalizedStringKey("choose")).font(.largeTitle)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0...14, id: \.self) { index in
                            GeometryReader { geometry in
                                NavigationLink(destination: BoardView(image: selectImage[index], interstitial: interstitial)) {
                                    Image("\(selectImage[index])")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .rotationEffect(Angle(degrees: 270))
                                        .rotation3DEffect(Angle(degrees: (Double(geometry.frame(in: .global).minX) - width/2.4) / -8), axis: (x: 0, y: 10, 0))
                                }
                            }
                            .frame(width: height/2, height: height/2)
                        }.padding(.vertical, 20)
                    }.padding(.bottom, 20)
                }.frame(height: height/2)
                if height > 1000 {
                    Spacer()
                }
                BannerView()
                    .frame(width: 320, height: 50)
                    .padding(.bottom, 10)
            }.navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            interstitial.loadInterstitial()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
    }
}

