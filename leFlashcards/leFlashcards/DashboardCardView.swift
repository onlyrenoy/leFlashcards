import SwiftUI

struct DashboardCardView: View {
    var title: String
    var count: String
    var color: Color

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(count)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(color)
        .cornerRadius(10)
    }
}

struct DashboardCardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardCardView(title: "Total Cards", count: "120", color: .pink)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
