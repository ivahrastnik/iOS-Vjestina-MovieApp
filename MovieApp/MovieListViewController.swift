import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

class MovieListViewController: UIViewController {
    
    private var allMovies: [MovieModel] = []
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private var collectionCellHeight: Int = 142
    
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
    
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allMovies = MovieUseCase().allMovies
            self.collectionView.reloadData()
        }
    }

    private func createViews() {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func defineLayoutForViews() {
        collectionView.autoPinEdgesToSuperviewEdges()
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
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
        let year = (MovieUseCase().getDetails(id: movie.id)?.year) ?? 0
        cell.set(name: movie.name, summary: movie.summary, imageUrl: movie.imageUrl, year: year)
        
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
