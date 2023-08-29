//
//  ContentView.swift
//  MyFirstApp
//
//  Created by 김김이 on 2023/08/23.
//

import SwiftUI


enum TypeSize {
    case width
    case height
    case padding
}

struct ButtonStruct: Hashable {
    let text: String
    let textColor: Color
    let backgroundColor: Color
    var isWide: Bool?
    var frame: [TypeSize: CGFloat]?
}

struct CustomButton {
    private var text: String
    private var textColor: Color
    private var backgroundColor: Color
    private var isWide: Bool?
    private var frame: [TypeSize: CGFloat]?

    init(button: ButtonStruct) {
        self.text = button.text
        self.textColor = button.textColor
        self.backgroundColor = button.backgroundColor
        self.frame = button.frame
        self.isWide = button.isWide ?? false
    }

    func createButton(total: Int64) -> some View {
        return Button {
            onClick(text: text, total: total)
        } label: {
            Text(text)
                .frame(width: frame?[TypeSize.width] ?? 80, height: frame?[TypeSize.height] ?? 80,
                alignment: isWide! ? .leading : .center)
                .padding([.leading], frame?[TypeSize.padding] ?? 0)
                .background(backgroundColor)
                .cornerRadius(40)
                .foregroundColor(textColor)
                .font(.system(size: 36))

        }
    }

    func onClick(text: String, total: Int64) {
        if text == "1" {
            print(total)
//            return total + 1
            //
        }
    }
}

let defaultBGColor: Color = Color(red: 0.2, green: 0.2, blue: 0.2)

struct ContentView: View {
    var total: Int64 = 0;
    
    var buttons: [[ButtonStruct]] = [
        [
            ButtonStruct(text: "AC", textColor: .black, backgroundColor: .gray),
            ButtonStruct(text: "+/-", textColor: .black, backgroundColor: .gray),
            ButtonStruct(text: "%", textColor: .black, backgroundColor: .gray),
            ButtonStruct(text: "÷", textColor: .white, backgroundColor: .orange)
        ],
        [
            ButtonStruct(text: "7", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "8", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "9", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "X", textColor: .white, backgroundColor: .orange)
        ],
        [
            ButtonStruct(text: "4", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "5", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "6", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "-", textColor: .white, backgroundColor: .orange)
        ],
        [
            ButtonStruct(text: "1", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "2", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "3", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "+", textColor: .white, backgroundColor: .orange)
        ],
        [
            ButtonStruct(text: "0", textColor: .white, backgroundColor: defaultBGColor,
                isWide: true, frame: [TypeSize.width: 130, TypeSize.height: 80, TypeSize.padding: 30]),
            ButtonStruct(text: ".", textColor: .white, backgroundColor: defaultBGColor),
            ButtonStruct(text: "=", textColor: .white, backgroundColor: .orange)
        ]
    ]

    func calculate(text: String) {
        if text == "+" {

        } else {

        }
    }


    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(String(total))
                        .padding()
                        .font(.system(size: 90))
                        .foregroundColor(.white)
                    Spacer().frame(width: 10)
                }
                ForEach(buttons, id: \.self) { line in
                    Spacer().frame(height: 20)
                    HStack {
                        ForEach(line, id: \.self) { button in
                            let btn = CustomButton(button: button)
                            btn.createButton(total: total)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
