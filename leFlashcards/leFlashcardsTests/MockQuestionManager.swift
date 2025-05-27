import Foundation
@testable import leFlashcards

// Basic MockQuestionManager
class MockQuestionManager: QuestionManager {
    var mockedCategories: [Categories] = []
    var mockedItems: [Item] = []

    override func requestCategories() -> [Categories] {
        return mockedCategories
    }

    override func list(_ cat: Categories) -> [Item] {
        // Return items filtered by category from mockedItems or a specific mock for this category
        return mockedItems.filter { $0.Category == cat }
    }
    
    // Override init() to prevent real JSON loading and use mock data
    override init() {
        super.init() // Call super.init() but immediately override its effects
        self.interViewItems = [] // Ensure no real data is loaded
        // Note: The original QuestionManager.swift doesn't explicitly call loadJson in its init(),
        // but it's good practice to ensure the mock doesn't rely on external files.
    }
    
    // Override loadJson to prevent loading from actual JSON in tests
    override func loadJson(filename fileName: String) -> [Item]? {
        // If the QuestionManager's init or other methods called loadJson,
        // this override ensures mock data is returned instead.
        if fileName == "iosInterview" { // Assuming this is the relevant filename
            return self.mockedItems // Return all mocked items, or specific items for this "file"
        }
        return [] // Return empty for any other filename requests
    }
}
