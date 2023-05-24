import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class CollectionCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CollectionCell.self)

    private var titleView: UILabel!
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private let titleOffset: CGFloat = 16
    private let imageWidth: CGFloat = 122
    private let imageHeight: CGFloat = 179
    
    private var movies: [MovieModel] = []
    var tapOnMovieCell: ((Int) -> Void)?
    private var router: RouterProtocol!
    
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
    
    func set(title: String, movies: [MovieModel]) {
        titleView.text = title
        self.movies = movies
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func defineLayout() {
        titleView.autoSetDimension(.height, toSize: 28)
        titleView.autoPinEdge(toSuperviewEdge: .top)
        titleView.autoPinEdge(toSuperviewEdge: .leading, withInset: titleOffset)
        titleView.autoPinEdge(toSuperviewEdge: .trailing, withInset: titleOffset)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: titleView, withOffset: titleOffset)
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: titleOffset)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40)
    }

}

extension CollectionCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath)
                as? MovieCell
        else { return UICollectionViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        let movie = movies[indexPath.row]
        cell.setImage(imageUrl: movie.imageUrl)
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
