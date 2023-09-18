//
//  ContentView.swift
//  MyFirstApp
//
//  Created by 김김이 on 2023/08/23.
//

import SwiftUI

let defaultBGColor: Color = Color(red: 0.2, green: 0.2, blue: 0.2)
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
        ButtonStruct(text: "×", textColor: .white, backgroundColor: .orange)
    ],
    [
        ButtonStruct(text: "4", textColor: .white, backgroundColor: defaultBGColor),
        ButtonStruct(text: "5", textColor: .white, backgroundColor: defaultBGColor),
        ButtonStruct(text: "6", textColor: .white, backgroundColor: defaultBGColor),
        ButtonStruct(text: "−", textColor: .white, backgroundColor: .orange)
    ],
    [
        ButtonStruct(text: "1", textColor: .white, backgroundColor: defaultBGColor),
        ButtonStruct(text: "2", textColor: .white, backgroundColor: defaultBGColor),
        ButtonStruct(text: "3", textColor: .white, backgroundColor: defaultBGColor),
        ButtonStruct(text: "+", textColor: .white, backgroundColor: .orange)
    ],
    [
        ButtonStruct(text: "0", textColor: .white, backgroundColor: defaultBGColor,
            isWide: true, frame: [TypeSize.width: 135, TypeSize.height: 80, TypeSize.padding: 30]),
        ButtonStruct(text: ".", textColor: .white, backgroundColor: defaultBGColor),
        ButtonStruct(text: "=", textColor: .white, backgroundColor: .orange)
    ]
]

enum TypeSize {
    case width
    case height
    case padding
}

struct ButtonStruct: Hashable {
    let text: String
    var textColor: Color
    var backgroundColor: Color
    var isWide: Bool?
    var frame: [TypeSize: CGFloat]?
}

struct KeyButton {
    private var text: String
    @State private var textColor: Color
    @State private var backgroundColor: Color
    private var isWide: Bool
    private var frame: [TypeSize: CGFloat]?

    init(_ button: ButtonStruct) {
        self.text = button.text
        self.textColor = button.textColor
        self.backgroundColor = button.backgroundColor
        self.frame = button.frame
        self.isWide = button.isWide ?? false
    }

    func getText() -> String {
        self.text
    }

    func textView() -> some View {
        return Text(text)
            .frame(width: frame?[TypeSize.width] ?? 80, height: frame?[TypeSize.height] ?? 80,
            alignment: isWide ? .leading : .center)
            .padding([.leading], frame?[TypeSize.padding] ?? 0)
            .background(backgroundColor)
            .cornerRadius(40)
            .foregroundColor(textColor)
            .font(.system(size: 36))
    }
}

struct ContentView: View {
    @State var total: String = "0"

    @State var value: Float = 0
    @State var beforeValue: String = ""

    @State var isFloat: Bool = false
    @State var oper: String = ""
    
    private func initializeValues() -> Void {
        total = "0"
        value = 0
        oper = ""
        isFloat = false
    }

    func convertStringToFloat(_ val: String) -> Float {
        (val as NSString).floatValue
    }

    func convertFloatToString(_ val: Float) -> String {
        isFloat ? String(val) : String(Int(val))
    }

    func isNumber(_ val: String) -> Bool {
        Float(val) != nil
    }
    
    func calculateValue(_ value: Float, _ parsedValue: Float, _ oper: String) -> Float {
        if oper == "" {
            return parsedValue
        }
        
        if oper == "+" {
            return value + parsedValue
        } else if oper == "−" {
            return value - parsedValue
        } else if oper == "×" {
            return value * parsedValue
        } else if oper == "%" {
            return value.truncatingRemainder(dividingBy: parsedValue)
        } else {
            return value / parsedValue
        }
    }

    func onClick(_ text: String) -> Void {
        if isNumber(text) {
            if total == "0" || (oper != "" && !isNumber(beforeValue)) {
                total = ""
            }

            total += text
        } else if text == "AC" {
            initializeValues()
        } else if text == "=" {
            let calcVal = calculateValue(value, convertStringToFloat(total), oper);
            total = convertFloatToString(calcVal)
        } else if text == "." && !total.contains(".") {
            total += text
            isFloat = true
        } else if text == "+/-" {
            //
        } else {
            if text == "+" || text == "−" || text == "×" || text == "%" || text == "÷" {
                let parsedTotal = convertStringToFloat(total)
                let calcVal = calculateValue(value, parsedTotal, oper);
                oper = text
                value = calcVal
                
                let result = convertFloatToString(calcVal)
                
                total = isFloat ? result : result.replacingOccurrences(of: ".0", with: "")
            }
        }

        beforeValue = text
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
                    Spacer().frame(height: 10)
                    HStack {
                        ForEach(line, id: \.self) { cell in
                            let keyButton = KeyButton(cell)

                            Button {
                                self.onClick(keyButton.getText())
                            } label: {
                                keyButton.textView()
                            }
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
