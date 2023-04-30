import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

class MovieCategoriesListViewController: UIViewController {
    
    private var tableView: UITableView!
    private var movieCategories: [[MovieModel]]!
    private var titleCategories: [String]!
    private let tableViewCellHeight: CGFloat = 263
    private let numberOfMovieCategories: Int = 3
    
    private var router: RouterProtocol!
    convenience init(router: RouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        loadData()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(CollectionCell.self, forCellReuseIdentifier: "CollectionCell")
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        tableView.separatorStyle = .none
    }
    
    private func defineLayoutForViews() {
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
    }
    
    private func loadData() {
        movieCategories = [[MovieModel]] ()
        movieCategories.append(MovieUseCase().popularMovies)
        movieCategories.append(MovieUseCase().freeToWatchMovies)
        movieCategories.append(MovieUseCase().trendingMovies)
        titleCategories = ["What's popular", "Free to watch", "Trending"]
        self.tableView.reloadData()
    }
}
    
extension MovieCategoriesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfMovieCategories
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.rowHeight = tableViewCellHeight
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionCell.reuseIdentifier, for: indexPath)
                as? CollectionCell,
            3 > indexPath.item
        else { return UITableViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        let categoryId = indexPath.row
        cell.set(title: titleCategories[categoryId], movies: movieCategories[categoryId])
        
        cell.tapOnMovieCell = {
            [weak self] (id: Int) in self?.router.showMovieDetailsViewController(movieId: id)
        }
        
        return cell
    }
}
