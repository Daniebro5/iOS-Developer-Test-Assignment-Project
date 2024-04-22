import Foundation

protocol RedditServiceProtocol {
    typealias RedditCompletion = (Result<RedditResponse, Error>) -> Void
    
    func fetchTopPosts(completion: @escaping RedditCompletion)
}

final class RedditService: RedditServiceProtocol {
    private let redditURL = URL(string: "https://www.reddit.com/r/Austin/top.json")!
    
    func fetchTopPosts(completion: @escaping RedditCompletion) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: redditURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let redditResponse = try JSONDecoder().decode(RedditResponse.self, from: data)
                completion(.success(redditResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
