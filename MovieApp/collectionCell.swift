import UIKit
import PureLayout
import Kingfisher
import MovieAppData

class collectionCell: UITableViewCell {

    static let reuseIdentifier = String(describing: collectionCell.self)

    private var titleView: UILabel!
    private var title: String!
    private var collectionView: UICollectionView!
    private var movieCategory: [MovieModel]!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setCollectionCell(rowId: Int) {
        
        if (rowId == 0) {
            movieCategory = MovieUseCase().popularMovies
            title = "What's popular"
        } else if (rowId == 1) {
            movieCategory = MovieUseCase().freeToWatchMovies
            title = "Free to watch"
        } else if (rowId == 2){
            movieCategory = MovieUseCase().trendingMovies
            title = "Trending"
        } else {
            print("ERROR! Row id is wrong.")
        }
        
        // Set title
        titleView.text = title
        
        // Set collection
        
        
        
        
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
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        
        contentView.addSubview(collectionView)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        titleView.text = title
        titleView.textColor = .black
        titleView.font = UIFont(name: "ProximaNova-Bold", size: 20)
        titleView.textAlignment = .left
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func defineLayout() {
        titleView.autoSetDimension(.height, toSize: 28)
        titleView.autoPinEdge(toSuperviewEdge: .top)
        titleView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        titleView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: titleView, withOffset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40)
    }

}

extension collectionCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieUseCase().popularMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        self.collectionView.register(movieCell.self, forCellWithReuseIdentifier: "movieCell")

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell.reuseIdentifier, for: indexPath)
                as? movieCell,
              MovieUseCase().popularMovies.count > indexPath.item
        else { return UICollectionViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")

        let movie = MovieUseCase().popularMovies[indexPath.row]

        return cell
    }
}

extension collectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Logic when cell is selected
    }
}

extension collectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let emptySpace = 16
        let width = (Int(collectionView.frame.width) - emptySpace)
        return CGSize(width: 122, height: 179)
    }
}
