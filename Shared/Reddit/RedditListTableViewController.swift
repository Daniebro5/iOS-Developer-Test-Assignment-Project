import UIKit

final class RedditListTableViewController: UITableViewController, RedditViewModelDelegate {
    private let viewModel: RedditViewModel
    
    private let cellReuseIdentifier = "redditCell"
    
    init(viewModel: RedditViewModel = RedditViewModel()) {
        self.viewModel = viewModel
        super.init(style: .plain)
        setupTableView()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.register(RedditTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRedditPosts()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.redditPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? RedditTableViewCell else {
            return UITableViewCell()
        }
        
        let redditPost = viewModel.redditPosts[indexPath.row]
        cell.titleLabel.text = redditPost.title
        cell.authorLabel.text = "By: \(redditPost.author)"
        cell.commentCountLabel.text = "Comments: \(redditPost.num_comments)"
        cell.scoreLabel.text = "Score: \(redditPost.score)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let redditPost = viewModel.redditPosts[indexPath.row]
        if let url = URL(string: redditPost.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func didFetchRedditData(success: Bool) {
        if success {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            let alert = UIAlertController(
                title: "Error",
                message: "Failed to fetch Reddit data.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
}
