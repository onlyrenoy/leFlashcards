import XCTest
@testable import leFlashcards

class MainViewModelTests: XCTestCase {

    var viewModel: MainViewModel!
    var mockQuestionManager: MockQuestionManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockQuestionManager = MockQuestionManager()
        viewModel = MainViewModel(questionManager: mockQuestionManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockQuestionManager = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssertTrue(true, "This is a placeholder test.")
    }

    func testMainViewModelDataProperties() throws {
        // Given: Mock QuestionManager is set up with some items
        let expectedItems: [Item] = [
            Item(Question: "Q1", Answer: "A1", Example: "E1", Category: .swiftFundamentals),
            Item(Question: "Q2", Answer: "A2", Example: "E2", Category: .uiKitFundamentals)
        ]
        // The mockQuestionManager's init() sets interViewItems to [] by default.
        // To test totalCardCount, we need to simulate that items were loaded.
        // We can assign directly to interViewItems as QuestionManager.interViewItems is internal (accessible to tests).
        mockQuestionManager.interViewItems = expectedItems
        
        // When: ViewModel properties are accessed
        let totalCards = viewModel.totalCardCount
        let totalDecks = viewModel.totalDeckCount // This is hardcoded to 1 in the ViewModel
        let deckTitle = viewModel.deckTitle // This is hardcoded to "iOS"

        // Then: Properties should reflect mocked data or hardcoded values
        XCTAssertEqual(totalCards, expectedItems.count, "Total card count should match mocked items")
        XCTAssertEqual(totalDecks, 1, "Total deck count should be 1 as per ViewModel logic")
        XCTAssertEqual(deckTitle, "iOS", "Deck title should be 'iOS' as per ViewModel logic")
    }
}
