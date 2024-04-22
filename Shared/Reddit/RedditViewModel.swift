import Foundation

protocol RedditViewModelDelegate: AnyObject {
    func didFetchRedditData(success: Bool)
}

final class RedditViewModel {
    private let redditService: RedditServiceProtocol
    weak var delegate: RedditViewModelDelegate?
    
    private(set) var redditPosts: [RedditPost] = []
    
    init(redditService: RedditServiceProtocol = RedditService()) {
        self.redditService = redditService
    }
    
    func fetchRedditPosts() {
        redditService.fetchTopPosts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let redditResponse):
                self.redditPosts = redditResponse.data.children.map { $0.data }
                self.delegate?.didFetchRedditData(success: true)
            case .failure:
                self.delegate?.didFetchRedditData(success: false)
            }
        }
    }
}
