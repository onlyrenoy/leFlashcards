import Foundation

class HomeViewModel {
    private let questionManager: QuestionManager
    
    var categories: [Categories] = []
    
    // MARK: - Initialization
    init(questionManager: QuestionManager = QuestionManager.shared) {
        self.questionManager = questionManager
    }
    
    // MARK: - Data Fetching
    func fetchCategories() {
        self.categories = questionManager.requestCategories()
    }
    
    // MARK: - Data Access
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func category(at index: Int) -> Categories? {
        guard index >= 0 && index < categories.count else {
            return nil
        }
        return categories[index]
    }
    
    func getSelectedCategory(at index: Int) -> Categories? {
        guard index >= 0 && index < categories.count else {
            return nil
        }
        return categories[index]
    }
}
