import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher
import Combine

class MovieCategoriesListViewController: UIViewController {
    
    private var tableView: UITableView!
    private var titleCategories: [String]!
    private let tableViewCellHeight: CGFloat = 263
    private let numberOfMovieCategories: Int = 3
    private var movieCategoriesListViewModel: MovieCategoriesListViewModel!
    private var disposeables = Set<AnyCancellable>()
    private var movieCategories: [[MovieListModel]] = []
    
    private var router: RouterProtocol!
    init(router: RouterProtocol, movieCategoriesListViewModel: MovieCategoriesListViewModel) {
        self.movieCategoriesListViewModel = movieCategoriesListViewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        print(movieCategories)
        print(self.movieCategories)
        buildViews()
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
//        movieCategories = [[MovieModel]] ()
//        movieCategories.append(MovieUseCase().popularMovies)
//        movieCategories.append(MovieUseCase().freeToWatchMovies)
//        movieCategories.append(MovieUseCase().trendingMovies)
        movieCategoriesListViewModel.getMovieCategories()
                
        movieCategoriesListViewModel
            .$movieCategories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self = self else { return }
                
                self.movieCategories = movies
                self.tableView.reloadData()
            }
            .store(in: &disposeables)
        titleCategories = ["What's popular", "Free to watch", "Trending"]
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
        print(movieCategories)
        cell.set(title: titleCategories[categoryId], movies: movieCategories[categoryId])
        
        cell.tapOnMovieCell = {
            [weak self] (id: Int) in self?.router.showMovieDetailsViewController(movieId: id)
        }
        
        return cell
    }
}
