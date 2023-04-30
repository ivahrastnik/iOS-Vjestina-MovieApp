import Foundation
import UIKit

protocol RouterProtocol {
    func setStartScreen(in window: UIWindow?)
    func showMovieDetailsViewController(movieId: Int)
}
class Router: RouterProtocol {
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func setStartScreen(in window: UIWindow?) {
        let vc = MovieListViewController(router: self)
        vc.navigationItem.title = "Movie list"
        navigationController.pushViewController(vc, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    func showMovieDetailsViewController(movieId: Int) {
        let vc = MovieDetailsViewController(router: self, movieId: movieId)
        vc.navigationItem.title = "Movie details"
        navigationController.pushViewController(vc, animated: true)
    }
}
