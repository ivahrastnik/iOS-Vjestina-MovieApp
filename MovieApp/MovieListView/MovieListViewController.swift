import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher
import Combine

class MovieListViewController: UIViewController {
    
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private var collectionCellHeight: Int = 142
    
    private var movieListViewModel: MovieListViewModel!
    private var allMovies: [MovieListModel] = []
    private var disposeables = Set<AnyCancellable>()
    
    private var router: RouterProtocol!
    init(router: RouterProtocol, movieListViewModel: MovieListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.router = router
        self.movieListViewModel = movieListViewModel
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        loadData()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) { super.willTransition(to: newCollection, with: coordinator)
        flowLayout.invalidateLayout()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func loadData() {
        movieListViewModel.getAllMovies()
        
        movieListViewModel
                .$allMovies
                .receive(on: DispatchQueue.main)
                .sink { [weak self] allMovies in
                    guard let self = self else { return }
                    
                    self.allMovies = allMovies
                    self.collectionView.reloadData()
                }
                .store(in: &disposeables)
    }

    private func createViews() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func styleViews() {
        view.backgroundColor = .white
    }

    private func defineLayoutForViews() {
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier, for: indexPath)
                as? ListCell,
              allMovies.count > indexPath.item
        else { return UICollectionViewCell() }
        
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        let movie = allMovies[indexPath.row]
        cell.set(name: movie.name, summary: movie.summary, imageUrl: movie.imageUrl, year: movie.year)
        
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let emptySpace = 2*16
        let collectionCellWidth = (Int(collectionView.bounds.width) - emptySpace)
        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = allMovies[indexPath.row]
        router.showMovieDetailsViewController(movieId: movie.id)
    }
    
}
