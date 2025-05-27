import SwiftUI

struct StateButtonsView: View {
    let leftTitle: String
    let rightTitle: String
    let leftAction: () -> Void
    let rightAction: () -> Void

    @State private var isLeftSelected: Bool = true

    var body: some View {
        HStack(spacing: 2) {
            Button(action: {
                if !isLeftSelected {
                    isLeftSelected = true
                    leftAction()
                }
            }) {
                Text(leftTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(isLeftSelected ? Color(hex: "1861F1") : Color.orange.opacity(0.4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(isLeftSelected ? Color.clear : Color.white, lineWidth: isLeftSelected ? 0 : 4)
                    )
            }
            .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .bottomLeft]))
            
            Button(action: {
                if isLeftSelected {
                    isLeftSelected = false
                    rightAction()
                }
            }) {
                Text(rightTitle)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(!isLeftSelected ? Color(hex: "1861F1") : Color.orange.opacity(0.4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(!isLeftSelected ? Color.clear : Color.white, lineWidth: !isLeftSelected ? 0 : 4)
                    )
            }
            .clipShape(RoundedCorner(radius: 20, corners: [.topRight, .bottomRight]))
        }
    }
}

// Custom Shape for specific rounded corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Extension to use hex colors (if not already available)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct StateButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        StateButtonsView(
            leftTitle: "STUDY MODE",
            rightTitle: "EXERCISE MODE",
            leftAction: { print("Left Tapped") },
            rightAction: { print("Right Tapped") }
        )
        .padding()
        .background(Color.gray) // To see the button shapes
        .previewLayout(.sizeThatFits)
    }
}
