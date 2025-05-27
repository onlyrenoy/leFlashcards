import Foundation
import Combine // For ObservableObject and @Published

// Assuming Categories is defined elsewhere and is identifiable or you handle IDs manually for List
// If Categories is a class, it might also need to be an ObservableObject if its properties can change and affect the UI individually.
// For now, assuming Categories is a struct or a simple data container.

class HomeViewModel: ObservableObject {
    private let questionManager: QuestionManager
    
    @Published var categories: [Categories] = []
    
    // MARK: - Initialization
    init(questionManager: QuestionManager = QuestionManager.shared) {
        self.questionManager = questionManager
    }
    
    // MARK: - Data Fetching
    func fetchCategories() {
        // This will now publish changes to any subscribers (like a SwiftUI View)
        self.categories = questionManager.requestCategories()
    }
    
    // MARK: - Data Access (These methods might not be strictly necessary if the View directly uses the 'categories' array)
    // func numberOfCategories() -> Int { // Not needed if View uses categories.count
    //     return categories.count
    // }
    
    // func category(at index: Int) -> Categories? { // Not needed if View iterates over categories
    //     guard index >= 0 && index < categories.count else {
    //         return nil
    //     }
    //     return categories[index]
    // }
    
    // func getSelectedCategory(at index: Int) -> Categories? { // Potentially useful if selection logic is complex
    //     guard index >= 0 && index < categories.count else {
    //         return nil
    //     }
    //     return categories[index]
    // }
    // For SwiftUI, direct access to the @Published categories array is often preferred in the View.
    // If you need to select a category for navigation, you can pass the category object itself.
}
