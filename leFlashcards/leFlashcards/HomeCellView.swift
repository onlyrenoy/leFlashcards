import SwiftUI

struct HomeCellView: View {
    let category: Categories // Categories is now Identifiable

    var body: some View {
        HStack {
            Text(category.rawValue)
                .font(.system(size: 18, weight: .medium)) // Example styling
                .foregroundColor(.black) // Example styling
            Spacer()
            Image(systemName: "chevron.right") // Example disclosure indicator
                .foregroundColor(.gray)
        }
        .padding() // Add padding around the content
        .frame(height: 70) // Approximate height, can be adjusted
        .background(Color.white) // Ensure it has a background if List is styled
    }
}

struct HomeCellView_Previews: PreviewProvider {
    static var previews: some View {
        // Example category for preview
        HomeCellView(category: .swiftFundamentals)
            .previewLayout(.sizeThatFits)
            .padding() // Padding for the preview container
    }
}
