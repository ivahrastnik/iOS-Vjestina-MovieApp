import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

let cellIdentifier = "cellId"
let allMovies = MovieUseCase().allMovies

class MovieListViewController: UIViewController {
    
//    private var scrollView: UIScrollView!
    private var collectionView: UICollectionView!
    
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
////        buildViews()
//
//        view.backgroundColor = .white
//        let tableView = UITableView(
//        frame: CGRect( x: 0,
//        y: 0,
//        width: view.bounds.width, height: view.bounds.height))
//        view.addSubview(tableView)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier) // 1.
//        tableView.dataSource = self // 2. }
//
//
//    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    private func createViews() {

//        scrollView = UIScrollView()
//        view.addSubview(scrollView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        
        view.addSubview(collectionView)


    }
    
    private func styleViews() {

        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func defineLayoutForViews() {

//        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.autoPinEdge(toSuperviewEdge: .top)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        collectionView.autoPinEdge(toSuperviewSafeArea: .leading)
        collectionView.autoPinEdge(toSuperviewSafeArea: .trailing)
//        collectionView.autoPinEdge(toSuperviewEdge: .top)
//        collectionView.autoPinEdge(toSuperviewEdge: .leading)
//        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
//        collectionView.autoSetDimension(.height, toSize: 84)
//        collectionView.autoPinEdge(toSuperviewEdge: .bottom)

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
        
        var wholeName = movie.name
        let year = (MovieUseCase().getDetails(id: movie.id)?.year)!
        wholeName += " ("
        wholeName += NumberFormatter.localizedString(from: NSNumber(value: year), number: .none)
        wholeName += ")"
        
        cell.setName(name: movie.name)
        cell.setSummary(summary: movie.summary)
        
        return cell
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Logic when cell is selected
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let emptySpace = 2*16
        let width = (Int(collectionView.frame.width) - emptySpace)
        return CGSize(width: width, height: 142)
    }
}

