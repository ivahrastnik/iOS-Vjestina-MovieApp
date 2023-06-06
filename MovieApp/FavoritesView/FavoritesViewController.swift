import Foundation
import UIKit
import PureLayout
import MovieAppData
import Combine

class FavoritesViewController: UIViewController {
    private var emptySpace: Int!
    private var cellWidth: CGFloat!
    private let cellHeight: CGFloat = 167
    private let imageWidth: CGFloat = 122
    private let imageHeight: CGFloat = 179
    private var favoritesViewModel: FavoritesViewModel!
    private var router: RouterProtocol!
    private var disposeables = Set<AnyCancellable>()
    private var favMovies: [MovieDetailsModel] = []
    
    private var titleLabel: UILabel!
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    
    init(router: RouterProtocol, favoritesViewModel: FavoritesViewModel) {
        self.router = router
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteMovies()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        titleLabel = UILabel()
        view.addSubview(titleLabel)
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
    }
    
    private func styleViews(){
        view.backgroundColor = .white
        titleLabel.text = "Favorites"
        titleLabel.font = UIFont(name: "ProximaNova-Bold", size: 20)
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        emptySpace = 2 * 16 + 2 * 8 + 8
        cellWidth = CGFloat((Int(view.bounds.width) - emptySpace) / 3)
    }
    
    private func defineLayoutForViews(){
        titleLabel.autoPinEdgesToSuperviewSafeArea(with: .init(top: 16, left: 16, bottom: 0, right: 16), excludingEdge: .bottom)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 32)
        collectionView.autoPinEdgesToSuperviewSafeArea(with: .init(top: 0, left: 16, bottom: 16, right: 16), excludingEdge: .top)
    }
    
    private func getFavoriteMovies() {
        favoritesViewModel.getMovieDetails()
        
        favoritesViewModel
            .$favMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self = self else { return }
                
                self.favMovies = movies
                self.collectionView.reloadData()
            }
            .store(in: &disposeables)
        
       collectionView.reloadData()
    }
    
    private func getHeartImage(for movieId: Int) -> UIImage {
        if let favoriteIds = Defaults.favoriteMoviesIds {
          if favoriteIds.contains(movieId) {
              return UIImage(systemName: "heart.fill")!
          } else {
              return UIImage(systemName: "heart")!
          }
        }
        return UIImage(systemName: "heart")!
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath)
                as? MovieCell
        else { return UICollectionViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        if indexPath.row >= favMovies.count { return cell }
        
        let movie = favMovies[indexPath.row]
        let movieId = movie.id
        let movieURL = URL(string: movie.imageUrl)
        
        cell.configure(with: movieURL, movieId: movieId) {
              guard let favoriteMovies = Defaults.favoriteMoviesIds else { return }
              var movieIds = Defaults.favoriteMoviesIds!
            if favoriteMovies.contains(movieId) {
                movieIds.removeAll { id in
                  id == movieId
                }
                Defaults.favoriteMoviesIds = movieIds
              } else {
                movieIds.append(movieId)
                Defaults.favoriteMoviesIds = movieIds
              }
              collectionView.reloadData()
        }
        
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = favMovies[indexPath.row]
        let movieId = movie.id
        self.router.showMovieDetailsViewController(movieId: movieId)
    }
}
