import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

public let details = MovieUseCase().getDetails(id: 111161)!

public var myCollectionView: UICollectionView!

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

class MovieDetailsViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
        
    private var movieView1: UIView!
    private var movieView2: UIView!
    
    private var imgView: UIImageView!
    
    private var userScoreView: UIView!
    private var score: UILabel!
    private var scoreLabel: UILabel!
    
    private var titleLabel: UIView!
    private var titleText: UILabel!
    private var titleYear: UILabel!
    
    private var genreView: UIView!
    private var dateLabel: UILabel!
    private var genreText: UILabel!
    private var durationText: UILabel!
    
    private var iconImage: UIImageView!
    private var iconView: UIView!
    
    private var label: UILabel!
    private var textBox: UILabel!
    private var box: UIView!
    
    private var collectionBox: UIView!
    private var flowLayout: UICollectionViewFlowLayout! = nil
    private var collectionView: UICollectionView! = nil
    private var collectionWidth: Float!
    let cellIdentifier = "cellId"
    
    private var imageHeight: CGFloat!
    
    override func viewDidLoad() {
        buildViews()
    }
    
    override func viewDidLayoutSubviews() {
        iconView.layer.cornerRadius = iconView.layer.bounds.width / 2
        iconView.clipsToBounds = true
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//            super.viewWillTransition(to: size, with: coordinator)
//            if UIDevice.current.orientation.isLandscape {
//                view.subviews.forEach({ $0.removeFromSuperview() })
//                buildViews()
//
//            } else {
//                view.subviews.forEach({ $0.removeFromSuperview() })
//                buildViews()
//            }
//    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        
//        scrollView = UIScrollView()
//        view.addSubview(scrollView)
//        contentView = UIView()
//        scrollView.addSubview(contentView)
        
        imgView = UIImageView()
        imgView.kf.setImage(with: URL(string: details.imageUrl))
        imageHeight = (327/852)*screenHeight
        
        movieView1 = UIView()
        movieView1.addSubview(imgView)
        view.addSubview(movieView1)
        
        userScoreView = UIView()
        movieView1.addSubview(userScoreView)
        
        score = UILabel()
        scoreLabel = UILabel()
        userScoreView.addSubview(score)
        userScoreView.addSubview(scoreLabel)
        
        titleLabel = UIView()
        movieView1.addSubview(titleLabel)
        
        titleText = UILabel()
        titleLabel.addSubview(titleText)
        titleYear = UILabel()
        titleLabel.addSubview(titleYear)
        
        dateLabel = UILabel()
        movieView1.addSubview(dateLabel)
        
        genreView = UIView()
        movieView1.addSubview(genreView)
        
        genreText = UILabel()
        durationText = UILabel()
        genreView.addSubview(genreText)
        genreView.addSubview(durationText)
        
        iconView = UIView()
        movieView1.addSubview(iconView)
        iconImage = UIImageView()
        iconView.addSubview(iconImage)
        
        movieView2 = UIView()
        view.addSubview(movieView2)
        
        label = UILabel()
        movieView2.addSubview(label)
        
        textBox = UILabel()
        movieView2.addSubview(textBox)

        flowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        movieView2.addSubview(collectionView)
    }
    
    private func styleViews() {
        
        movieView1.backgroundColor = .white
        movieView2.backgroundColor = .white
        
        label.textColor = .black
        label.font = UIFont(name: "ProximaNova-Bold", size: 20)
        label.textAlignment = .left
        label.text = "Overview"
        label.backgroundColor = .white
        
        textBox.textColor = .black
        textBox.font = UIFont(name: "ProximaNova-Regular", size: 14)
        textBox.textAlignment = .left
        
        textBox.numberOfLines = 0
        textBox.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        textBox.attributedText = NSMutableAttributedString(string: details.summary, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        score.textColor = .white
        score.font = UIFont(name: "ProximaNova-ExtraBold", size: 16) //EXTRABOLD
        score.text = NumberFormatter.localizedString(from: NSNumber(value: details.rating ), number: .decimal)
        
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont(name: "ProximaNova-SemiBold", size: 14) //semibold
        scoreLabel.text = "User score"
        
        titleText.font = UIFont(name: "ProximaNova-Bold", size: 22)
        titleYear.font = UIFont(name: "ProximaNova-Regular", size: 22)
        titleText.text = details.name
        var title2 = " ("
        title2 += NumberFormatter.localizedString(from: NSNumber(value: details.year), number: .none)
        title2 += ")"
        titleYear.text = title2
        titleText.textColor = .white
        titleYear.textColor = .white
        
        dateLabel.textColor = .white
        dateLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        let release = details.releaseDate
        let showDate = outputFormatter.date(from: release)!
        outputFormatter.dateFormat = "dd/MM/yyyy"
        var date = outputFormatter.string(from: showDate)
        date += " (US)"
        dateLabel.text = date
        
        let categories = details.categories
        var categoriesText = ""
        for c in categories {
            categoriesText += String(describing: c.self).capitalized + ", "
        }
        
        genreText.text = String(categoriesText.dropLast(2))
        genreText.textColor = .white
        genreText.font = UIFont(name: "ProximaNova-Regular", size: 14)
        
        let duration = details.duration
        let hours = duration / 60
        let minutes = duration % 60
        var d = String(" ")
        d += NumberFormatter.localizedString(from: NSNumber(value: hours ), number: .none)
        d += "h "
        d += NumberFormatter.localizedString(from: NSNumber(value: minutes ), number: .none)
        d += "m"
        durationText.text = d
        durationText.textColor = .white
        durationText.font = UIFont(name: "ProximaNova-Bold", size: 14)
        
        iconView.backgroundColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        
        let icon = UIImage(systemName: "star")
        iconImage.image = icon
        iconImage.tintColor = .white
        
        movieView2.backgroundColor = .white
        
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.minimumLineSpacing = 24
        
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    private func defineLayoutForViews(){
        
//        scrollView.autoPinEdgesToSuperviewEdges()
//        contentView.autoPinEdge(toSuperviewEdge: .top)
//        contentView.autoPinEdge(toSuperviewEdge: .bottom)
//        contentView.autoPinEdge(.leading, to: .leading, of: view)
//        contentView.autoPinEdge(.trailing, to: .trailing, of: view)
            
        movieView1.autoSetDimension(.height, toSize: imageHeight)
        movieView1.autoPinEdge(toSuperviewEdge: .top)
        movieView1.autoPinEdge(toSuperviewEdge: .leading)
        movieView1.autoPinEdge(toSuperviewEdge: .trailing)
        imgView.autoMatch(.height, to: .height, of: movieView1)
        
        imgView.contentMode = .scaleAspectFill
        imgView.autoPinEdge(toSuperviewEdge: .top)
        imgView.autoPinEdge(toSuperviewEdge: .leading)
        imgView.autoPinEdge(toSuperviewEdge: .trailing)
        imgView.autoPinEdge(toSuperviewEdge: .bottom)
        
        userScoreView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 75)
        userScoreView.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 20)
        userScoreView.autoSetDimension(.height, toSize: 19)
        
        score.autoPinEdge(toSuperviewEdge: .leading)
        score.autoPinEdge(toSuperviewEdge: .bottom)
        score.autoPinEdge(toSuperviewEdge: .top)
        
        scoreLabel.autoPinEdge(.leading, to: .trailing, of: score, withOffset: 8)
        scoreLabel.autoPinEdge(toSuperviewEdge: .trailing)
        scoreLabel.autoPinEdge(toSuperviewEdge: .bottom)
        scoreLabel.autoPinEdge(toSuperviewEdge: .top)
        
        titleLabel.autoSetDimension(.height, toSize: 34)
        titleLabel.autoPinEdge(.top, to: .bottom, of: userScoreView, withOffset: 16)
        titleLabel.autoPinEdge(.leading, to: .leading, of: userScoreView)
        
        titleText.autoPinEdge(toSuperviewEdge: .leading)
        titleText.autoPinEdge(toSuperviewEdge: .bottom)
        titleText.autoPinEdge(toSuperviewEdge: .top)
        titleYear.autoPinEdge(.leading, to: .trailing, of: titleText)
        titleYear.autoPinEdge(toSuperviewEdge: .trailing)
        titleYear.autoPinEdge(toSuperviewEdge: .bottom)
        titleYear.autoPinEdge(toSuperviewEdge: .top)
        
        dateLabel.autoSetDimension(.height, toSize: 20)
        dateLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 16)
        dateLabel.autoPinEdge(.leading, to: .leading, of: titleLabel)
        
        genreView.autoSetDimension(.height, toSize: 20)
        genreView.autoPinEdge(.top, to: .bottom, of: dateLabel)
        genreView.autoPinEdge(.leading, to: .leading, of: titleLabel)
        
        genreText.autoPinEdge(toSuperviewEdge: .leading)
        genreText.autoPinEdge(toSuperviewEdge: .bottom)
        genreText.autoPinEdge(toSuperviewEdge: .top)
        durationText.autoPinEdge(.leading, to: .trailing, of: genreText)
        durationText.autoPinEdge(toSuperviewEdge: .trailing)
        durationText.autoPinEdge(toSuperviewEdge: .bottom)
        durationText.autoPinEdge(toSuperviewEdge: .top)
        
        iconView.autoSetDimension(.height, toSize: 32)
        iconView.autoSetDimension(.width, toSize: 32)
        iconView.autoPinEdge(.top, to: .bottom, of: genreView, withOffset: 16)
        iconView.autoPinEdge(.leading, to: .leading, of: titleLabel)
        
        iconImage.autoSetDimension(.height, toSize: 13)
        iconImage.autoSetDimension(.width, toSize: 14)
        iconImage.autoCenterInSuperview()
        
//        movieView2.autoPinEdge(toSuperviewEdge: .bottom)
        movieView1.autoSetDimension(.height, toSize: screenHeight - imageHeight)
        movieView2.autoPinEdge(.top, to: .bottom, of: movieView1)
        movieView2.autoPinEdge(toSuperviewEdge: .leading)
        movieView2.autoPinEdge(toSuperviewEdge: .trailing)
        
        label.autoPinEdge(toSuperviewEdge: .top, withInset: 22)
        label.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        label.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        textBox.autoPinEdge(.top, to: .bottom, of: label, withOffset: 8.38)
        textBox.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        textBox.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
        collectionView.autoPinEdge(.top, to: .bottom, of: textBox, withOffset: 27.62)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoSetDimension(.height, toSize: 84)
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(details.crewMembers.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView.register(personCell.self, forCellWithReuseIdentifier: "personCell")
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personCell.reuseIdentifier, for: indexPath)
                as? personCell,
            details.crewMembers.count > indexPath.item
                
        else { return UICollectionViewCell() }
//        print("DEBUG: cellForItemAt: \(indexPath)")
        cell.setName(name: String(details.crewMembers[indexPath.row].name))
        cell.setRole(role: String(details.crewMembers[indexPath.row].role))
        return cell
        
    }
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsInRow = 3
        let itemSpacing = 16
        
        let interItemSpacing = (numberOfItemsInRow - 1) * itemSpacing
        let margins = 2  * itemSpacing
        let emptySpace = interItemSpacing + margins
        let width = (Int(collectionView.frame.width) - emptySpace) / numberOfItemsInRow
        
        return CGSize(width: width, height: 40)
        
    }
    
}

