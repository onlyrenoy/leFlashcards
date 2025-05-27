import Foundation
import Combine // Required for ObservableObject

class MainViewModel: ObservableObject {
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
    // Ensure QuestionManager.shared is used or injected appropriately.
    // If QuestionManager's data can change and MainViewModel needs to react,
    // QuestionManager should also be an ObservableObject, and MainViewModel might need to subscribe to its changes.
    init(questionManager: QuestionManager = QuestionManager.shared) {
        self.questionManager = questionManager
        // If questionManager.interViewItems could change over time and totalCardCount needs to update the UI,
        // you would need a mechanism to observe those changes, possibly making QuestionManager an ObservableObject
        // and having it publish its changes. Then MainViewModel could subscribe or use a @ObservedObject for questionManager.
    }
    
    // MARK: - Future Actions (Placeholder)
    // func studyModeSelected() { ... }
    // func exerciseModeSelected() { ... }
}
