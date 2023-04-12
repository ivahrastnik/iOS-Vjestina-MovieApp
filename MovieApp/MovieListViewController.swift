import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

let cellIdentifier = "cellId"
let allMovies = MovieUseCase().allMovies

class MovieListViewController: UIViewController {
    
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private var collectionCellHeight: Int = 142
    private var collectionCellWidth: Int!
    
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        
        view.addSubview(collectionView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func defineLayoutForViews() {
        collectionView.autoPinEdge(toSuperviewEdge: .top)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing)
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.collectionView.register(listCell.self, forCellWithReuseIdentifier: "listCell")
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listCell.reuseIdentifier, for: indexPath)
                as? listCell,
              allMovies.count > indexPath.item
        else { return UICollectionViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        let movie = allMovies[indexPath.row]
        cell.setImage(imageUrl: movie.imageUrl)
        
        var movieNameAndYearLabel = movie.name
        let year = (MovieUseCase().getDetails(id: movie.id)?.year)!
        movieNameAndYearLabel += " ("
        movieNameAndYearLabel += NumberFormatter.localizedString(from: NSNumber(value: year), number: .none)
        movieNameAndYearLabel += ")"
        
        cell.setName(name: movieNameAndYearLabel)
        cell.setSummary(summary: movie.summary)
        
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let emptySpace = 2*16
        collectionCellWidth = (Int(collectionView.frame.width) - emptySpace)
        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
    }
}

