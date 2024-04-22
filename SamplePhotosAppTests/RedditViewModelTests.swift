import XCTest
@testable import SamplePhotosApp

final class RedditViewModelTests: XCTestCase {
    var viewModel: RedditViewModel!
    var mockService: MockRedditService!
    var delegate: TestDelegate!
    
    override func setUp() {
        super.setUp()
        mockService = MockRedditService()
        viewModel = RedditViewModel(redditService: mockService)
        delegate = TestDelegate()
        viewModel.delegate = delegate
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        delegate = nil
        super.tearDown()
    }
    
    func testFetchRedditPostsSuccess() {
        mockService.shouldSucceed = true
        
        viewModel.fetchRedditPosts()
        
        let expectation = self.expectation(description: "Fetch Reddit Data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertTrue(delegate.fetchSuccessful, "Expected data fetch to be successful")
        XCTAssertEqual(viewModel.redditPosts.count, 1, "Expected one Reddit post")
        XCTAssertEqual(viewModel.redditPosts[0].title, "Sample Reddit Post", "Expected specific Reddit post title")
    }
    
    func testFetchRedditPostsFailure() {
        mockService.shouldSucceed = false
        
        viewModel.fetchRedditPosts()
        
        let expectation = self.expectation(description: "Fetch Reddit Data Failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertFalse(delegate.fetchSuccessful, "Expected data fetch to fail")
        XCTAssertTrue(viewModel.redditPosts.isEmpty, "Expected no Reddit posts")
    }
}

final class TestDelegate: RedditViewModelDelegate {
    var fetchSuccessful: Bool = false
    
    func didFetchRedditData(success: Bool) {
        fetchSuccessful = success
    }
}
