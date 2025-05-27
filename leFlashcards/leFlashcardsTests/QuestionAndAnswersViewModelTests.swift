import XCTest
@testable import leFlashcards

class QuestionAndAnswersViewModelTests: XCTestCase {

    var viewModel: QuestionAndAnswersViewModel!
    let testItem = Item(Question: "Test Q", Answer: "Test A", Example: "Test E", Category: .swiftFundamentals)

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = QuestionAndAnswersViewModel(item: testItem)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssertTrue(true, "This is a placeholder test.")
    }

    func testQuestionAndAnswersViewModelInitializationAndStateTransitions() throws {
        // Initial state (Question)
        XCTAssertEqual(viewModel.currentState, .question, "Initial state should be .question")
        XCTAssertEqual(viewModel.currentCardTitle, "QUESTION", "Initial card title should be QUESTION")
        XCTAssertEqual(viewModel.currentTextContent, testItem.Question, "Initial text content should be the question")
        XCTAssertEqual(viewModel.buttonAreaText, "Go to Answer".uppercased(), "Initial button text should be 'Go to Answer'")
        XCTAssertFalse(viewModel.showReadButton, "Read button should initially be hidden")
        XCTAssertEqual(viewModel.getTextForSpeech(), "", "Text for speech should be empty for question state")

        // Transition to Answer state
        viewModel.transitionState()
        XCTAssertEqual(viewModel.currentState, .answer, "State should transition to .answer")
        XCTAssertEqual(viewModel.currentCardTitle, "ANSWER", "Card title should be ANSWER")
        XCTAssertEqual(viewModel.currentTextContent, testItem.Answer, "Text content should be the answer")
        XCTAssertEqual(viewModel.buttonAreaText, "See Example".uppercased(), "Button text should be 'See Example'")
        XCTAssertTrue(viewModel.showReadButton, "Read button should be visible for answer state")
        XCTAssertEqual(viewModel.getTextForSpeech(), testItem.Answer, "Text for speech should be the answer")

        // Transition to Example state
        viewModel.transitionState()
        XCTAssertEqual(viewModel.currentState, .example, "State should transition to .example")
        XCTAssertEqual(viewModel.currentCardTitle, "EXAMPLE", "Card title should be EXAMPLE")
        XCTAssertEqual(viewModel.currentTextContent, testItem.Example, "Text content should be the example")
        XCTAssertEqual(viewModel.buttonAreaText, "Check Question".uppercased(), "Button text should be 'Check Question'")
        XCTAssertTrue(viewModel.showReadButton, "Read button should be visible for example state")
        XCTAssertEqual(viewModel.getTextForSpeech(), testItem.Example, "Text for speech should be the example")
        
        // Transition back to Question state
        viewModel.transitionState()
        XCTAssertEqual(viewModel.currentState, .question, "State should transition back to .question")
        XCTAssertEqual(viewModel.currentTextContent, testItem.Question, "Text content should be the question again")
    }
}
