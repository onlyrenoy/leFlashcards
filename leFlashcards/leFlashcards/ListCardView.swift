import SwiftUI

struct ListCardView: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer() // Pushes content to the left
            }
            .padding()
            .frame(maxWidth: .infinity) // Make HStack take full width
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.blue.opacity(0.1), radius: 6, x: 0, y: 1)
        }
        .frame(height: 90) // Approximate height based on original layout
    }
}

struct ListCardView_Previews: PreviewProvider {
    static var previews: some View {
        ListCardView(title: "iOS") {
            print("ListCardView tapped")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
