import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    // For navigation to QuestionsView, to be implemented later
    @State private var selectedCategory: Categories? = nil 
    @State private var navigateToQuestions = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Title Area
            VStack(alignment: .leading) {
                // The original "iOS" title seemed to be static or from elsewhere,
                // For now, let's use a generic title or one from the ViewModel if available.
                // The original Home.swift had "iOS" hardcoded for titleLabel.text
                // If this needs to be dynamic (e.g. based on selected deck from MainView),
                // it should be passed to HomeView.
                Text("Categories") // Default title, was "iOS" in UIKit version.
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 10) // Adjust padding as needed
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // Original titleArea height was UIScreen.main.bounds.height * 0.22
            // This is a bit tricky to replicate directly without GeometryReader or fixed height.
            // For simplicity, using padding and letting content define size.
            .padding(.top, 20) // Approximation of original top spacing for title text
            .padding(.bottom, 20)
            .background(Color(hex: "1861F1")) // Original titleArea background color

            // List of Categories
            // The @State variables selectedCategory and navigateToQuestions are no longer needed
            // if we use NavigationLink directly in the List.
            List(viewModel.categories) { category in
                NavigationLink(destination: QuestionsView(category: category)) {
                    HomeCellView(category: category)
                }
                .listRowInsets(EdgeInsets()) // Remove default padding if needed for the cell
                .background(Color.white) // Ensure cells are white if list has a different bg
            }
            .listStyle(PlainListStyle()) // Use PlainListStyle to match UICollectionView appearance
            .onAppear {
                viewModel.fetchCategories()
            }
            // No separate NavigationLink needed here if embedded in the List
        }
        .background(Color.white) // Main background for the VStack
        .edgesIgnoringSafeArea(.top) // Allow title area to extend into safe area
        .navigationBarTitleDisplayMode(.inline) // Controls how the title is displayed in the nav bar
        .navigationTitle("") // Set to empty if we use custom title area, or specific title if needed
        .navigationBarHidden(true) // Hiding because we have a custom title area
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
