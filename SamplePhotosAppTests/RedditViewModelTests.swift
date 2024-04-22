import XCTest
@testable import SamplePhotosApp

final class RedditViewModelTests: XCTestCase {
    var viewModel: RedditViewModel!
    var mockService: MockRedditService!
    
    override func setUp() {
        super.setUp()
        mockService = MockRedditService()
        viewModel = RedditViewModel(redditService: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchRedditPostsSuccess() {
        mockService.shouldSucceed = true
        viewModel.fetchRedditPosts()
        
        XCTAssertEqual(viewModel.redditPosts.count, 1, "Expected one Reddit post")
        XCTAssertEqual(viewModel.redditPosts[0].title, "Sample Reddit Post", "Expected specific Reddit post title")
    }
    
    func testFetchRedditPostsFailure() {
        mockService.shouldSucceed = false
        viewModel.fetchRedditPosts()
        
        XCTAssertTrue(viewModel.redditPosts.isEmpty, "Expected no Reddit posts")
    }
}
