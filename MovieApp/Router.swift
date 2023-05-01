import Foundation
import UIKit

protocol RouterProtocol {
    func setStartScreen(in window: UIWindow?)
    func showMovieDetailsViewController(movieId: Int)
}
class Router: RouterProtocol {
    private let navigationController: UINavigationController!
    private var tabBarController: UITabBarController!
    private var movieListVC: MovieCategoriesListViewController!
    private var favoritesVC: FavoritesViewController!
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func setStartScreen(in window: UIWindow?) {
        movieListVC = MovieCategoriesListViewController(router: self)
        favoritesVC = FavoritesViewController()
        tabBarController = UITabBarController()
        
        styleControllers()
        
        tabBarController.viewControllers = [navigationController, favoritesVC]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    func styleControllers() {
        movieListVC.navigationItem.title = "Movie list"
        navigationController.pushViewController(movieListVC, animated: false)
        
        let home = UIImage(systemName: "house")
        movieListVC.tabBarItem = UITabBarItem(title: "Movie List", image: .some(home!), selectedImage: .some(home!))
        
        let fav = UIImage(systemName: "heart")
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: .some(fav!), selectedImage: .some(fav!))
        
        tabBarController.tabBar.tintColor = Colors.tabBarIconColor
        
    }
    func showMovieDetailsViewController(movieId: Int) {
        let vc = MovieDetailsViewController(router: self, movieId: movieId)
        vc.navigationItem.title = "Movie details"
        navigationController.pushViewController(vc, animated: true)
    }
}
