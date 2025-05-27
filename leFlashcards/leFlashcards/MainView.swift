import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    // For navigation, will be properly implemented later
    @State private var navigateToHome = false

    var body: some View {
        // NavigationView will be added in LeFlashcardsApp.swift as per instruction
        VStack(alignment: .leading, spacing: 16) {
            Text("dashboard".uppercased())
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.top, 20) // Approximate top padding based on original layout (80 - some nav bar height)

            HStack(spacing: 8) {
                DashboardCardView(title: "Total Cards",
                                  count: "\(viewModel.totalCardCount)",
                                  color: .pink) // Original was .systemPink
                DashboardCardView(title: "Decks",
                                  count: "\(viewModel.totalDeckCount)",
                                  color: .orange)
            }
            .padding(.horizontal, 16)
            // The original layout had ~120 height for this HStack.
            // DashboardCardView has minHeight 100, plus padding, should be similar.

            Text("Decks".uppercased())
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
            
            ListCardView(title: viewModel.deckTitle) {
                print("ListCardView tapped, navigating to Home (placeholder)")
                // In a real scenario, you'd trigger navigation here.
                // For now, we'll use a placeholder action or a @State variable if needed by NavigationView
                // navigateToHome = true // This will be handled by NavigationLink
            }
            // Wrap ListCardView with NavigationLink for navigation to HomeView
            NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                ListCardView(title: viewModel.deckTitle) {
                    // This action is now primarily for the button's own logic if any,
                    // or can be used to set navigateToHome = true if not using direct NavigationLink activation.
                    // However, with NavigationLink wrapping it, direct tap often suffices.
                    // For clarity and explicit control:
                    self.navigateToHome = true
                }
            }
            .padding(.horizontal, 16) // Original had |-0-listElement-0-| but card itself had padding
            // The original ListCard container had ~220 height, but the card was ~90.
            // This might have been for scroll content or future elements.
            // For now, ListCardView itself defines its height.

            Spacer() // Pushes buttons to the bottom

            StateButtonsView(
                leftTitle: "Study mode".uppercased(),
                rightTitle: "Exercise mode".uppercased(),
                leftAction: {
                    print("Study mode selected")
                    // viewModel.studyModeSelected() // If such a method exists
                },
                rightAction: {
                    print("Exercise mode selected")
                    // viewModel.exerciseModeSelected() // If such a method exists
                }
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 20) // Approximate bottom padding (original 40, minus some safe area)
        }
        .background(Color.white.ignoresSafeArea()) // Mimic original view.backgroundColor = .white
        .navigationTitle("") // Keep navigation bar but no title text, or use .navigationBarHidden(true) if no bar needed
        .navigationBarHidden(true) // Hiding for now to match original's lack of explicit nav bar title area
        // The NavigationLink for navigateToHome is now embedded around ListCardView.
        // No separate hidden NavigationLink needed here for this specific navigation.
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        // It's good practice to wrap previews in NavigationView if the view
        // is designed to be part of one, to catch layout issues early.
        NavigationView {
            MainView()
        }
    }
}
