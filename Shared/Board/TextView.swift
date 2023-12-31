//
//  KariView.swift
//  Flip board
//
//  Created by 上別縄祐也 on 2023/11/21.
//

import Foundation
import StoreKit
import SwiftUI

struct TextView: View, Identifiable {
    @State private var location: CGPoint = CGPoint(x: 50, y: 20)
    @State var text: String = ""
    @State var textColor: Color = Color.yellow
    @State var fontSelection = 1
    @FocusState var isActive: Bool
    @Binding var isEditing: Bool
    
    @State private var textSize = 80.0
    @State private var magnifyBy = 1.0
    @State private var lastMagnificationValue = 1.0
    
    @Binding var views: [TextView]
    let id: UUID
    init(views: Binding<[TextView]>, id: UUID, isEditing: Binding<Bool>) {
        self._views = views
        self.id = id
        self._isEditing = isEditing
    }
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                let changeRate = value / lastMagnificationValue
                magnifyBy *= changeRate
                textSize *= changeRate
                lastMagnificationValue = value
            }
            .onEnded { value in
                lastMagnificationValue = 1.0
            }
    }
    
    private func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    var body: some View {
        let fonts:[Font.Design] = [.default, .rounded, .serif, .monospaced]
        let weights:[Font.Weight] = [.light, .black, .regular, .bold]
        let editTextSize = 60.0

        VStack(spacing: 0) {
            HStack(spacing: 0) {
                TextField("",text: $text, onCommit: {
                    location = CGPoint(x: abs(Double(text.count) * editTextSize/4) + 20, y: 0)
                })
                    .focused($isActive, equals: true)
                    .focusedValue(\.myBoolData, true)
                    .font(.system(size: isActive ? editTextSize : textSize, weight: weights[fontSelection], design: fonts[fontSelection]))
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(width: isActive ? abs(Double(text.count) * editTextSize/1.1) : abs(Double(text.count) * textSize), height: isActive ? editTextSize : abs(textSize), alignment: .center)
                    .foregroundColor(textColor)
            }
            HStack {
                Button(action: {
                    views = views.filter{$0.id != self.id}
//                    requestReview()
                }, label: {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.red)
                        .opacity(isActive ? 1 : 0)
                })
                .disabled(!isActive)
                Spacer()
                ColorPicker("ラベル", selection: $textColor)
                    .labelsHidden()
                    .opacity(isActive ? 1 : 0)
                    .disabled(!isActive)
                    .padding(.trailing, 4)
                Button(action: {
                    fontSelection = 0
                }, label: {
                    Text("Aa")
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.system(size: 25, weight: .light, design: .default))
                        .background(fontSelection == 0 ? textColor : Color.clear)
                        .foregroundColor(fontSelection == 0 ? .white : textColor)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                })
                .opacity(isActive ? 1 : 0)
                .disabled(!isActive)
                Button(action: {
                    fontSelection = 1
                }, label: {
                    Text("Aa")
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.system(size: 25, weight: .black, design: .rounded))
                        .background(fontSelection == 1 ? textColor : Color.clear)
                        .foregroundColor(fontSelection == 1 ? .white : textColor)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                })
                .opacity(isActive ? 1 : 0)
                .disabled(!isActive)
                Button(action: {
                    fontSelection = 2
                }, label: {
                    Text("Aa")
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.system(size: 25, weight: .regular, design: .serif))
                        .background(fontSelection == 2 ? textColor : Color.clear)
                        .foregroundColor(fontSelection == 2 ? .white : textColor)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                })
                .opacity(isActive ? 1 : 0)
                .disabled(!isActive)
                Button(action: {
                    fontSelection = 3
                }, label: {
                    Text("Aa")
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.system(size: 25, weight: .bold, design: .monospaced))
                        .background(fontSelection == 3 ? textColor : Color.clear)
                        .foregroundColor(fontSelection == 3 ? .white : textColor)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                })
                .opacity(isActive ? 1 : 0)
                .disabled(!isActive)
                Spacer()
            }
            .padding(.top, 4)
        }
        .position(isActive ? CGPoint(x: abs(Double(text.count) * editTextSize/4) + 20, y: 30) : location)
        .gesture(DragGesture().onChanged({ value in self.location = value.location}))
        .gesture(magnification)
        .frame(width: Double(text.count) * editTextSize / 2 + 30, height: editTextSize/2 + 30)
        .onAppear(){
            isActive = true
        }
    }
}
