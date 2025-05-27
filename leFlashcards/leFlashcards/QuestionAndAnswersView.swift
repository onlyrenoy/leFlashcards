import SwiftUI

struct QuestionAndAnswersView: View {
    let category: Categories
    let itemsFromQuiz: [Item] // Renamed for clarity, these are passed from QuestionsView
    
    @StateObject private var viewModel = QuestionAndAnswersViewModel()

    var body: some View {
        // Use viewModel.items which will be populated onAppear
        List(viewModel.items) { item in // Item is now Identifiable
            VStack(alignment: .leading, spacing: 8) {
                Text("Q: \(item.Question)")
                    .font(.headline)
                Text("A: \(item.Answer)")
                    .font(.subheadline)
                    .foregroundColor(.green) // Differentiate answer
                if !item.Example.isEmpty {
                    Text("Eg: \(item.Example)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 5)
        }
        .navigationTitle("\(category.rawValue) Q&A")
        .onAppear {
            // Pass the items received from QuestionsView to the ViewModel
            viewModel.loadQAs(items: itemsFromQuiz, category: category)
        }
    }
}

struct QuestionAndAnswersView_Previews: PreviewProvider {
    static var previews: some View {
        // Example data for preview
        let exampleItems = [
            Item(Category: .swiftFundamentals, Question: "What is Swift?", Answer: "A programming language.", Example: "Used for iOS apps."),
            Item(Category: .swiftFundamentals, Question: "What are optionals?", Answer: "Variables that can hold a value or nil.", Example: "var name: String?")
        ]
        NavigationView {
            QuestionAndAnswersView(category: .swiftFundamentals, itemsFromQuiz: exampleItems)
        }
    }
}
