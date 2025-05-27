import Foundation

class QuestionsViewModel {
    private let questionManager: QuestionManager
    private var currentCategory: Categories?
    
    var questions: [Item] = []
    
    // MARK: - Initialization
    init(questionManager: QuestionManager = QuestionManager.shared) {
        self.questionManager = questionManager
    }
    
    // MARK: - Configuration
    func configure(with category: Categories) {
        self.currentCategory = category
        self.questions = questionManager.list(category)
    }
    
    // MARK: - Data Access
    func numberOfQuestions() -> Int {
        return questions.count
    }
    
    func question(at index: Int) -> Item? {
        guard index >= 0 && index < questions.count else {
            return nil
        }
        return questions[index]
    }
    
    func getSelectedQuestion(at index: Int) -> Item? {
        guard index >= 0 && index < questions.count else {
            return nil
        }
        return questions[index]
    }

    func getCategoryName() -> String {
        return currentCategory?.rawValue ?? "Questions"
    }
}
