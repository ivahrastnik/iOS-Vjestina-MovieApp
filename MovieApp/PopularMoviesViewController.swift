import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher


class PopularMoviesViewController: UIViewController {
    
    
    private var scrollView: UIScrollView!
    private var tableView: UITableView!
    private var popularCollectionView: UICollectionView!
    private var freeCollectionView: UICollectionView!
    private var trendingCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView = UITableView(
        frame: CGRect( x: 0,
        y: 0,
        width: view.bounds.width, height: view.bounds.height))
        view.addSubview(tableView)
//        tableView.register(collectionCell.self, forCellReuseIdentifier: cellIdentifier) // 1.
        tableView.dataSource = self // 2.
        
        buildViews()
        
    }
    
    private func buildViews() {
//        createViews()
//        styleViews()
        defineLayoutForViews()
    }
    
    private func defineLayoutForViews() {
        
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        
    }
}
    
extension PopularMoviesViewController: UITableViewDataSource { // 3.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) // 4.
//        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration() // 5.
        
        self.tableView.register(collectionCell.self, forCellReuseIdentifier: "collectionCell")
        self.tableView.rowHeight = self.view.bounds.height / 3
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: collectionCell.reuseIdentifier, for: indexPath)
                as? collectionCell,
            3 > indexPath.item
                
        else { return UITableViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        
//
//        cellConfig.text = "Row \(indexPath.row)"
//        cellConfig.textProperties.color = .blue
//        cell.contentConfiguration = cellConfig
//        if (indexPath.row == 0) {
//            movieCategory = MovieUseCase().popularMovies
//            cell.setTitle(title: "What's popular")
//        } else if (indexPath.row == 1) {
//            movieCategory = MovieUseCase().freeToWatchMovies
//            cell.setTitle(title: "Free to watch")
//        } else {
//            movieCategory = MovieUseCase().trendingMovies
//            cell.setTitle(title: "Trending")
//        }
        
        cell.setCollectionCell(rowId: indexPath.row)
        
        
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.bounds.height / 3
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.bounds.height / 3
//    }
}
 
extension PopularMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Logic when cell is selected
    }
}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 358, height: 142)
    }
}
