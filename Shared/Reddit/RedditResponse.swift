import Foundation

struct RedditResponse: Codable {
    let kind: String
    let data: RedditData
}

struct RedditData: Codable {
    let children: [RedditChild]
}

struct RedditChild: Codable {
    let kind: String
    let data: RedditPost
}

struct RedditPost: Codable {
    let title: String
    let url: String
    let author: String
    let num_comments: Int
    let created_utc: TimeInterval
    let score: Int
}

