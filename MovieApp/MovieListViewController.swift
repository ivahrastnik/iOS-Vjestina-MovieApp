import Foundation
import UIKit
import PureLayout

let cellIdentifier = "cellId"

class MovieListViewController: UIViewController {
    
    
    
    private var scrollView: UIScrollView!
    private var tableView: UITableView!
    
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: CGRect( x: 0,
                           y: 0,
                           width: view.bounds.width, height: view.bounds.height),
            collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
//    private func buildViews() {
//        createViews()
//        styleViews()
//        defineLayoutForViews()
//    }
//
//    private func createViews() {
//
////        scrollView = UIScrollView()
////        view.addSubview(scrollView)
////
////        tableView = UITableView()
////        scrollView.addSubview(tableView)
//
//
//    }
    
//    private func styleViews() {
//
//        scrollView.backgroundColor = .white
//        tableView.backgroundColor = .systemMint
//
//
//
//
//    }
//
//    private func defineLayoutForViews() {
//
//        scrollView.autoPinEdgesToSuperviewEdges()
//        tableView.autoPinEdgesToSuperviewEdges()
//
//    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: cellIdentifier,
                                                       for: indexPath)
        cell.backgroundColor = .blue
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
        return CGSize(width: 358, height: 142)
    }
}

//extension MovieListViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(
//            withIdentifier: cellIdentifier,
//            for: indexPath)
//
//        var cellConfig: UIListContentConfiguration = cell.defaultContentConfiguration() // 5.
//
//        let cellView = UIView()
//        cell.addSubview(cellView)
//        cellView.autoSetDimension(.height, toSize: 142)
//        cellView.autoSetDimension(.width, toSize: 358)
//        cellView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
//        cellView.layer.cornerRadius = 10
//        cell.con
//
//        cellConfig.text = "Row \(indexPath.row)"
//        cellConfig.textProperties.color = .blue
//        cell.contentConfiguration = cellConfig
//        return cell
//    }
    
//    func styleCell() {
//
//    }
    
