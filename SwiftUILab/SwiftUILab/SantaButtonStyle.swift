import SwiftUI

extension Color {
    static let grey2 = Color(red: 239/255, green: 239/255, blue: 239/255)
    static let grey3 = Color(red: 196/255, green: 196/255, blue: 196/255)
    static let santaRed = Color(red: 243/255, green: 21/255, blue: 35/255)
}

enum SantaButtonState {
    case active
    case inActive
    
    var textColor: Color {
        switch self {
        case .active:
            return Color.white
        case .inActive:
            return .grey3
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .active:
            return .santaRed
        case .inActive:
            return .grey2
        }
    }
}

struct SantaButtonStyle: ButtonStyle {
    let buttonState: SantaButtonState
    
    init(_ buttonState: SantaButtonState) {
        self.buttonState = buttonState
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14))
            .foregroundColor(buttonState.textColor)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 54)
            .background(buttonState.backgroundColor)
            .cornerRadius(6)
            .padding(.horizontal, 20)
    }
}
