import Foundation
import Combine

// Assuming Item struct is defined elsewhere and has Question, Answer, Example fields.
// And Categories enum is also defined.

class QuestionsViewModel: ObservableObject {
    private let questionManager: QuestionManager
    
    @Published var items: [Item] = [] // Renamed from 'questions' for clarity if Item struct is used generally
    @Published var currentQuestionIndex: Int = 0
    @Published var score: Int = 0
    @Published var currentQuestion: Item? = nil
    @Published var showAnswer: Bool = false // To reveal the answer
    @Published var isQuizComplete: Bool = false // To signal completion
    
    private var currentCategory: Categories? // Keep track of the category

    // MARK: - Initialization
    init(questionManager: QuestionManager = QuestionManager.shared) {
        self.questionManager = questionManager
    }
    
    // MARK: - Question Loading
    func loadQuestions(for category: Categories) {
        self.currentCategory = category
        self.items = questionManager.list(category)
        resetQuiz() // Initialize quiz state
        if !items.isEmpty {
            currentQuestion = items[0]
        } else {
            currentQuestion = nil
            isQuizComplete = true // No questions to show
        }
    }

    // MARK: - Quiz Logic
    func answerSelected(isCorrect: Bool) { // Simplified: direct correctness, or pass selected option
        if isCorrect {
            score += 1
        }
        showAnswer = true // Reveal the answer after selection
    }

    func nextQuestion() {
        showAnswer = false
        if currentQuestionIndex < items.count - 1 {
            currentQuestionIndex += 1
            currentQuestion = items[currentQuestionIndex]
        } else {
            // All questions answered
            isQuizComplete = true
            // currentQuestion = nil // Optionally clear currentQuestion
        }
    }
    
    func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        showAnswer = false
        isQuizComplete = false
        // currentQuestion will be set by loadQuestions or nextQuestion
    }

    // MARK: - Data Access (Computed properties for the View)
    var totalQuestions: Int {
        return items.count
    }
    
    var progressText: String {
        if items.isEmpty {
            return "0/0"
        }
        return "\(currentQuestionIndex + 1)/\(items.count)"
    }

    // func getCategoryName() -> String { // The view will get this from the category passed to it
    //     return currentCategory?.rawValue ?? "Questions"
    // }
}
