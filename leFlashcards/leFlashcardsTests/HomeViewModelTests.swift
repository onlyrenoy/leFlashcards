import XCTest
@testable import leFlashcards // Make sure 'leFlashcards' is the correct module name

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockQuestionManager: MockQuestionManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockQuestionManager = MockQuestionManager()
        viewModel = HomeViewModel(questionManager: mockQuestionManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockQuestionManager = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        XCTAssertTrue(true, "This is a placeholder test.")
    }

    func testHomeViewModelInitializationAndCategoryFetching() throws {
        // Given: Mock QuestionManager is set up to return specific categories
        let expectedCategories: [Categories] = [.swiftFundamentals, .uiKitFundamentals]
        mockQuestionManager.mockedCategories = expectedCategories
        
        // When: Categories are fetched
        viewModel.fetchCategories()
        
        // Then: The ViewModel's categories should match the expected categories
        XCTAssertEqual(viewModel.categories.count, expectedCategories.count, "Number of categories should match")
        XCTAssertEqual(viewModel.categories, expectedCategories, "Categories should match the mocked data")
        XCTAssertEqual(viewModel.numberOfCategories(), expectedCategories.count, "numberOfCategories should return correct count")
        XCTAssertEqual(viewModel.category(at: 0), .swiftFundamentals, "Category at index 0 should be swiftFundamentals")
        XCTAssertNil(viewModel.category(at: 2), "Category at out-of-bounds index should be nil")
    }
}
