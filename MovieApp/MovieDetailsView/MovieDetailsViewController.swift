import Foundation
import UIKit
import PureLayout
import Kingfisher
import Combine

class MovieDetailsViewController: UIViewController {
    
    private var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    private var movieView1: UIView!
    private var movieView2: UIView!
    
    private var imgView: UIImageView!
    private var animatedTitleView: UIView!
    
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
    
    private var flowLayout: UICollectionViewFlowLayout! = nil
    private var collectionView: UICollectionView! = nil
    private var collectionWidth: Float!
    let cellIdentifier = "cellId"
    
    private var imageHeight: CGFloat!
    
    private var router: RouterProtocol!
    private var movieId: Int!
    
    private var movieDetailsViewModel: MovieDetailsViewModel!
    private var disposeables = Set<AnyCancellable>()
    private var movieDetails: MovieDetailsModel = MovieDetailsModel()
    
    init(router: RouterProtocol, movieDetailsViewModel: MovieDetailsViewModel) {
        self.movieDetailsViewModel = movieDetailsViewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        buildViews()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        iconView.layer.cornerRadius = iconView.layer.bounds.width / 2
        iconView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animatedTitleView.transform = animatedTitleView.transform.translatedBy(x: -view.frame.width, y: 0)
        textBox.transform = textBox.transform.translatedBy(x: -view.frame.width, y: 0)
        self.collectionView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.animatedTitleView.transform = .identity
                self.textBox.transform = .identity
            })
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.5,
                animations: {
                    self.collectionView.alpha = 1.0
            })
    }
    
    private func loadData() {
        movieDetailsViewModel.getMovieDetails()
                
        movieDetailsViewModel
            .$movieDetails
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movie in
                guard let self = self else { return }
                self.movieDetails = movie
                self.fillViewsWithData()
            }
            .store(in: &disposeables)
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        imgView = UIImageView()
        imageHeight = (327/852)*screenHeight
        
        animatedTitleView = UIView()
        
        movieView1 = UIView()
        movieView1.addSubview(imgView)
        movieView1.addSubview(animatedTitleView)
        view.addSubview(movieView1)
        
        userScoreView = UIView()
        animatedTitleView.addSubview(userScoreView)
        
        score = UILabel()
        scoreLabel = UILabel()
        userScoreView.addSubview(score)
        userScoreView.addSubview(scoreLabel)
        
        titleLabel = UIView()
        animatedTitleView.addSubview(titleLabel)
        
        titleText = UILabel()
        titleLabel.addSubview(titleText)
        titleYear = UILabel()
        titleLabel.addSubview(titleYear)
        
        dateLabel = UILabel()
        animatedTitleView.addSubview(dateLabel)
        
        genreView = UIView()
        animatedTitleView.addSubview(genreView)
        
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
        
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: PersonCell.reuseIdentifier)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
        label.textColor = .black
        label.font = UIFont(name: "ProximaNova-Bold", size: 20)
        label.textAlignment = .left
        label.backgroundColor = .white
        
        textBox.textColor = .black
        textBox.font = UIFont(name: "ProximaNova-Regular", size: 14)
        textBox.textAlignment = .left
        
        textBox.numberOfLines = 0
        textBox.lineBreakMode = .byWordWrapping
        
        score.textColor = .white
        score.font = UIFont(name: "ProximaNova-ExtraBold", size: 16)
        
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont(name: "ProximaNova-SemiBold", size: 14)
        
        titleText.font = UIFont(name: "ProximaNova-Bold", size: 22)
        titleYear.font = UIFont(name: "ProximaNova-Regular", size: 22)
        
        titleText.textColor = .white
        titleYear.textColor = .white
        
        dateLabel.textColor = .white
        dateLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)
        
        genreText.textColor = .white
        genreText.font = UIFont(name: "ProximaNova-Regular", size: 14)
        
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
    
    private func fillViewsWithData(){
        imgView.kf.setImage(with: URL(string: movieDetails.imageUrl))
        label.text = "Overview"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        textBox.attributedText = NSMutableAttributedString(string: movieDetails.summary, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        scoreLabel.text = "User score"
        score.text = NumberFormatter.localizedString(from: NSNumber(value: movieDetails.rating), number: .decimal)
        
        titleText.text = movieDetails.name
        var title2 = " ("
        title2 += NumberFormatter.localizedString(from: NSNumber(value: movieDetails.year), number: .none)
        title2 += ")"
        titleYear.text = title2
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        let release = movieDetails.releaseDate
        if let showDate = outputFormatter.date(from: release){
            outputFormatter.dateFormat = "dd/MM/yyyy"
            var date = outputFormatter.string(from: showDate)
            date += " (US)"
            dateLabel.text = date
        }
        
        let categories = movieDetails.categories
        var categoriesText = ""
        for c in categories {
            categoriesText += String(describing: c.self).capitalized + ", "
        }
        genreText.text = String(categoriesText.dropLast(2))
        
        let duration = movieDetails.duration
        let hours = duration / 60
        let minutes = duration % 60
        var d = String(" ")
        d += NumberFormatter.localizedString(from: NSNumber(value: hours ), number: .none)
        d += "h "
        d += NumberFormatter.localizedString(from: NSNumber(value: minutes ), number: .none)
        d += "m"
        durationText.text = d
        
        collectionView.reloadData()
    }
    
    private func defineLayoutForViews(){
            
        movieView1.autoSetDimension(.height, toSize: imageHeight)
        movieView1.autoPinEdge(toSuperviewSafeArea: .top)
        movieView1.autoPinEdge(toSuperviewEdge: .leading)
        movieView1.autoPinEdge(toSuperviewEdge: .trailing)
        animatedTitleView.autoPinEdgesToSuperviewEdges()
        imgView.autoMatch(.height, to: .height, of: movieView1)
        
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
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
        
        movieView2.autoSetDimension(.height, toSize: screenHeight - imageHeight)
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
        collectionView.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(movieDetails.crewMembers.count)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionView.register(PersonCell.self, forCellWithReuseIdentifier: "personCell")
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseIdentifier, for: indexPath)
                as? PersonCell,
            movieDetails.crewMembers.count > indexPath.item
                
        else { return UICollectionViewCell() }
        cell.setName(name: String(movieDetails.crewMembers[indexPath.row].name))
        cell.setRole(role: String(movieDetails.crewMembers[indexPath.row].role))
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
