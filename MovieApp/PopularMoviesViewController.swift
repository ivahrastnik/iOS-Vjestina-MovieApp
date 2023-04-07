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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier) // 1.
        tableView.dataSource = self // 2.
        
        buildViews()
        
    }
    
    private func buildViews() {
        createViews()
//        styleViews()
//        defineLayoutForViews()
    }
    
    private func createViews() {
        
//        popularCollectionView = UICollectionView()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        popularCollectionView = UICollectionView(
            frame: CGRect( x: 0,
                           y: 0,
                           width: view.bounds.width/3, height: view.bounds.height/3),
            collectionViewLayout: flowLayout)
        popularCollectionView.backgroundColor = .systemMint
        tableView(tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)).addSubview(popularCollectionView)
        freeCollectionView = UICollectionView()
        trendingCollectionView = UICollectionView()
        
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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) // 4.
        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration() // 5.
        cellConfig.text = "Row \(indexPath.row)"
        cellConfig.textProperties.color = .blue
        cell.contentConfiguration = cellConfig
        
        let movie = allMovies[indexPath.row]
        
        let imgView = UIImageView()
        imgView.kf.setImage(with: URL(string: movie.imageUrl))
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        imgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        cell.addSubview(imgView)
        imgView.autoSetDimension(.width, toSize: 97)
        imgView.autoPinEdge(toSuperviewEdge: .top)
        imgView.autoPinEdge(toSuperviewEdge: .bottom)
        imgView.autoPinEdge(toSuperviewEdge: .leading)
        self.tableView.rowHeight = view.bounds.height / 3
        
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
