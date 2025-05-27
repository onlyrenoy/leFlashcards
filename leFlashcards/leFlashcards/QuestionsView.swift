import SwiftUI

struct QuestionsView: View {
    let category: Categories
    @StateObject private var viewModel = QuestionsViewModel()
    
    // State for navigation to a results/summary view
    @State private var navigateToResults = false

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isQuizComplete {
                // Quiz Complete / Results View (Placeholder)
                VStack {
                    Text("Quiz Complete!")
                        .font(.largeTitle)
                        .padding()
                    Text("Your score: \(viewModel.score) / \(viewModel.totalQuestions)")
                        .font(.title2)
                    
                    Button("View All Q&A") {
                        self.navigateToResults = true
                        // Actual navigation will be set up later
                        print("Navigate to QuestionAndAnswersView (placeholder)")
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)

                    Button("Restart Quiz") {
                        viewModel.loadQuestions(for: category) // Reloads and resets
                    }
                    .padding()
                    .buttonStyle(.bordered)
                }
            } else if let item = viewModel.currentQuestion {
                // Question Display
                Text("Question \(viewModel.progressText)")
                    .font(.headline)
                
                Text(item.Question)
                    .font(.title2)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(minHeight: 100) // Ensure space for question

                if viewModel.showAnswer {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Answer:")
                            .font(.semibold)
                        Text(item.Answer)
                            .padding(.bottom)
                        
                        if !item.Example.isEmpty {
                            Text("Example:")
                                .font(.semibold)
                            Text(item.Example)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    
                    Button("Next Question") {
                        viewModel.nextQuestion()
                    }
                    .padding(.top)
                    .buttonStyle(.borderedProminent)
                } else {
                    Button("Show Answer") {
                        // In a real quiz with options, this would be where answer selection happens.
                        // For this flashcard format, "Show Answer" also implies "answered".
                        // We can consider "correct" if the user feels they knew it, or just track reveals.
                        // For simplicity, let's assume revealing means they attempted it.
                        // The original app didn't seem to have explicit correct/incorrect buttons per question.
                        viewModel.answerSelected(isCorrect: true) // Defaulting to "correct" for now on reveal
                    }
                    .padding(.top)
                    .buttonStyle(.bordered)
                }
                
                Spacer() // Push content to top
                
                Text("Score: \(viewModel.score)")
                    .font(.caption)
                    .padding(.bottom)

            } else {
                // Loading state or no questions
                Text("Loading questions...")
            }
        }
        .padding()
        .navigationTitle(category.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadQuestions(for: category)
        }
        // NavigationLink to QuestionAndAnswersView, activated by navigateToResults state
        // It's important to place it so it's part of the view hierarchy but doesn't create a visible element itself.
        // Often placed at the end of a ZStack or as a background to a button if direct tap should trigger.
        // Here, placing it more generally within the VStack.
        .background(
            NavigationLink(
                destination: QuestionAndAnswersView(category: category, itemsFromQuiz: viewModel.items),
                isActive: $navigateToResults
            ) {
                EmptyView() // The NavigationLink itself is invisible
            }
        )
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionsView(category: .swiftFundamentals)
        }
    }
}
