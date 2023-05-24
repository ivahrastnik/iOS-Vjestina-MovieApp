import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews () {
        let movieListVC = MovieCategoriesListViewController()
        let home = UIImage(systemName: "house")?.withTintColor(Colors.lightGrey)
        let homeSelected = UIImage(systemName: "house")?.withTintColor(Colors.tabBarIconColor)
        movieListVC.tabBarItem = UITabBarItem(title: "Movie List", image: .some(home!), selectedImage: .some(homeSelected!))
        let favoritesVC = FavoritesViewController()
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [movieListVC, favoritesVC]
    }
    
}
