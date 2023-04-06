import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

let cellIdentifier = "cellId"
let allMovies = MovieUseCase().allMovies

class MovieListViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var tableView: UITableView!
    private var collectionView: UICollectionView!
    
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(allMovies.count)
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

        scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        i = 0
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(
            frame: CGRect( x: 0,
                           y: 0,
                           width: view.bounds.width, height: view.bounds.height),
            collectionViewLayout: flowLayout)
        
        view.addSubview(collectionView)


    }
    
    private func styleViews() {

        scrollView.backgroundColor = .white
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func defineLayoutForViews() {

        scrollView.autoPinEdgesToSuperviewEdges()
        collectionView.autoPinEdgesToSuperviewSafeArea()

    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 70
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell( withReuseIdentifier: cellIdentifier,
                                                       for: indexPath)
//        OVERRIDE PREPAREFORREUSE
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 10).cgPath
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cell.layer.shadowRadius = 20
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 4)
        cell.layer.position = cell.center
        
        let movie = allMovies[i]
        
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
        
        let nameView = UILabel()
        let summaryView = UILabel()
        
        var str = movie.name
        let year = (MovieUseCase().getDetails(id: movie.id)?.year)!
        str += " ("
        str += NumberFormatter.localizedString(from: NSNumber(value: year), number: .none)
        str += ")"
        
        nameView.text = str
        
        nameView.textColor = .black
        nameView.font = UIFont(name: "ProximaNova-Bold", size: 16)
        nameView.textAlignment = .left
        
        summaryView.textColor = .black
        summaryView.font = UIFont(name: "ProximaNova-Regular", size: 14)
        summaryView.textAlignment = .left
        summaryView.numberOfLines = 0
        summaryView.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        summaryView.attributedText = NSMutableAttributedString(string: movie.summary, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        cell.addSubview(nameView)
        cell.addSubview(summaryView)
        
        nameView.autoSetDimension(.height, toSize: 20)
        nameView.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        nameView.autoPinEdge(.leading, to: .trailing, of: imgView, withOffset: 16)
        nameView.autoPinEdge(toSuperviewSafeArea: .trailing)
        
        summaryView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        summaryView.autoPinEdge(.leading, to: .trailing, of: imgView, withOffset: 16)
        summaryView.autoPinEdge(.top, to: .bottom, of: nameView, withOffset: 8)
        summaryView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 8)
        
        i += 1
        
        if(i == allMovies.count) {
            i = 0
        }
        
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

