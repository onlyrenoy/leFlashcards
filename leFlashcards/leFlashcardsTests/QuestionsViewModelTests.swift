import XCTest
@testable import leFlashcards

class QuestionsViewModelTests: XCTestCase {

    var viewModel: QuestionsViewModel!
    var mockQuestionManager: MockQuestionManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockQuestionManager = MockQuestionManager()
        viewModel = QuestionsViewModel(questionManager: mockQuestionManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockQuestionManager = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssertTrue(true, "This is a placeholder test.")
    }

    func testQuestionsViewModelConfigurationAndData() throws {
        // Given
        let categoryToTest: Categories = .swiftFundamentals
        let expectedItems: [Item] = [
            Item(Question: "Q1", Answer: "A1", Example: "E1", Category: categoryToTest),
            Item(Question: "Q2", Answer: "A2", Example: "E2", Category: categoryToTest)
        ]
        mockQuestionManager.mockedItems = expectedItems // Mock all items
        
        // When
        viewModel.configure(with: categoryToTest)
        
        // Then
        XCTAssertEqual(viewModel.numberOfQuestions(), expectedItems.count, "Number of questions should match")
        XCTAssertEqual(viewModel.getCategoryName(), categoryToTest.rawValue, "Category name should match")
        
        let question1 = viewModel.question(at: 0)
        XCTAssertEqual(question1?.Question, "Q1", "Question at index 0 should be Q1")
        
        let selectedQuestion = viewModel.getSelectedQuestion(at: 1)
        XCTAssertEqual(selectedQuestion?.Question, "Q2", "Selected question at index 1 should be Q2")
        
        XCTAssertNil(viewModel.question(at: 2), "Question at out-of-bounds index should be nil")
    }
}
