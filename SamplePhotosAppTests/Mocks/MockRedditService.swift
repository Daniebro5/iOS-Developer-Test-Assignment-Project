import Foundation
@testable import SamplePhotosApp

final class MockRedditService: RedditServiceProtocol {
    var shouldSucceed: Bool = true
    var testData: RedditResponse?
    var testError: Error?
    
    func fetchTopPosts(completion: @escaping RedditServiceProtocol.RedditCompletion) {
        if shouldSucceed {
            if let testData = testData {
                completion(.success(testData))
            } else {
                let defaultData = RedditResponse(
                    kind: "Listing",
                    data: RedditData(
                        children: [
                            RedditChild(
                                kind: "t3",
                                data: RedditPost(
                                    title: "Sample Reddit Post",
                                    url: "https://www.reddit.com",
                                    author: "test_user",
                                    num_comments: 10,
                                    created_utc: TimeInterval(Date().timeIntervalSince1970),
                                    score: 100
                                )
                            )
                        ]
                    )
                )
                completion(.success(defaultData))
            }
        } else {
            completion(.failure(testError ?? NSError(domain: "Test error", code: 1, userInfo: nil)))
        }
    }
}
