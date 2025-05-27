import Foundation

class MainViewModel {
    private let questionManager: QuestionManager
    
    // MARK: - Properties for View
    var totalCardCount: Int {
        return questionManager.interViewItems.count
    }
    
    var totalDeckCount: Int {
        // Currently hardcoded as per Main.swift, can be made dynamic later
        return 1 
    }
    
    var deckTitle: String {
        // Currently hardcoded as per Main.swift
        return "iOS"
    }

    // MARK: - Initialization
    init(questionManager: QuestionManager = QuestionManager.shared) {
        self.questionManager = questionManager
    }
    
    // MARK: - Future Actions (Placeholder)
    // func studyModeSelected() { ... }
    // func exerciseModeSelected() { ... }
}
