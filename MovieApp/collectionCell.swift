import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class collectionCell: UITableViewCell {

    static let reuseIdentifier = String(describing: collectionCell.self)

    private var titleView: UILabel!
    private var title: String!
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private var movieCategory: [MovieModel]!
    private var movieCategories: [[MovieModel]] = [MovieUseCase().popularMovies, MovieUseCase().freeToWatchMovies, MovieUseCase().trendingMovies]
    private let titleOffset: CGFloat = 16
    private let imageWidth: CGFloat = 122
    private let imageHeight: CGFloat = 179
    private let titleCategory: [String] = ["What's popular", "Free to watch", "Trending"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension collectionCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        titleView = UILabel()
        contentView.addSubview(titleView)
        
        title = String()
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        
        contentView.addSubview(collectionView)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        
        titleView.textColor = .black
        titleView.font = UIFont(name: "ProximaNova-Bold", size: 20)
        titleView.textAlignment = .left
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let id = categoryId!
        movieCategory = movieCategories[id]
        titleView.text = titleCategory[id]
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

extension collectionCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCategory.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        self.collectionView.register(movieCell.self, forCellWithReuseIdentifier: "movieCell")

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell.reuseIdentifier, for: indexPath)
                as? movieCell,
              movieCategory.count > indexPath.item
        else { return UICollectionViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
//
//        let movie = movieCategory[indexPath.row]
        cell.setImage(imageUrl: movieCategory[indexPath.row].imageUrl)
        return cell
    }
}

extension collectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageWidth, height: imageHeight)
    }
}
