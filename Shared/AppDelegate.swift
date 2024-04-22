import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }

        let tabBarController = UITabBarController()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let splitViewController = storyboard.instantiateViewController(withIdentifier: "PhotosSplitViewController") as? UISplitViewController else {
            fatalError("Could not find PhotosSplitViewController in storyboard.")
        }
        
        splitViewController.delegate = self
        
        #if os(iOS)
            if let navigationController = splitViewController.viewControllers.last as? UINavigationController {
                navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
            }
        #endif
        
        let redditTableViewController = RedditListTableViewController()
        
        splitViewController.tabBarItem = UITabBarItem(
            title: "Photos",
            image: UIImage(systemName: "photo.on.rectangle"),
            tag: 0
        )
        
        redditTableViewController.tabBarItem = UITabBarItem(
            title: "Reddit",
            image: UIImage(systemName: "list.bullet"),
            tag: 1
        )
        
        tabBarController.viewControllers = [splitViewController, redditTableViewController]
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()

        return true
    }
}
