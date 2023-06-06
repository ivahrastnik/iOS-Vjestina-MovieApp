import UIKit
import PureLayout
import Kingfisher

protocol CollectionCellDelegate: AnyObject {
    func tapOnMovieCell(id: Int)
}

class CollectionCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CollectionCell.self)

    private var titleView: UILabel!
    private var categoriesView: UIView!
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private let titleOffset: CGFloat = 16
    private let imageWidth: CGFloat = 122
    private let imageHeight: CGFloat = 179
    private var catLabel: UILabel!
    
    private var movies: [MovieListModel] = []
    private var categories: [String] = []
    var tapOnMovieCell: ((Int) -> Void)?
    private var router: RouterProtocol!
    weak var delegate: CollectionCellDelegate?
    
    convenience init(router: RouterProtocol) {
        self.init()
        self.router = router
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String, movies: [MovieListModel], categories: [String]) {
        titleView.text = title
        
        self.movies = movies
        
        var text = String("")
        for c in categories {
            text.append(c)
            text.append("   ")
        }
        catLabel.text = text
        
        collectionView.reloadData()
    }
}

extension CollectionCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        titleView = UILabel()
        contentView.addSubview(titleView)
        
        categoriesView = UIView()
//        contentView.addSubview(categoriesView)
        
        catLabel = UILabel()
        contentView.addSubview(catLabel)
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        
        contentView.addSubview(collectionView)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        
        titleView.textColor = .black
        titleView.font = UIFont(name: "ProximaNova-Bold", size: 20)
        titleView.textAlignment = .left
        
        categoriesView.backgroundColor = .systemMint
        
        catLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)
        catLabel.textColor = Colors.darkGray
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func defineLayout() {
        titleView.autoSetDimension(.height, toSize: 28)
        titleView.autoPinEdge(toSuperviewEdge: .top)
        titleView.autoPinEdge(toSuperviewEdge: .leading, withInset: titleOffset)
        titleView.autoPinEdge(toSuperviewEdge: .trailing, withInset: titleOffset)
        
        catLabel.autoPinEdge(.top, to: .bottom, of: titleView, withOffset: 8)
        catLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: titleOffset)
        catLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: titleOffset)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: catLabel, withOffset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: titleOffset)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40)
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

extension CollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath)
                as? MovieCell
        else { return UICollectionViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        let movie = movies[indexPath.row]
        let movieId = movie.id
        let movieURL = URL(string: movie.imageUrl)
        let heartImage = getHeartImage(for: movieId)
        
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

extension CollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageWidth, height: imageHeight)
    }
}

extension CollectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let movieId = movie.id
        tapOnMovieCell?(movieId)
    }
}
