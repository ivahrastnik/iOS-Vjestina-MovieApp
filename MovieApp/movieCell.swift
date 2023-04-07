import UIKit
import PureLayout
import Kingfisher

class movieCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: movieCell.self)

    private var titleView: UILabel!
    private var summaryView: UILabel!
    private var imgView: UIImageView!
    private var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(imageUrl: String) {
        imgView.kf.setImage(with: URL(string: "\(imageUrl)"))
    }

}

extension movieCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
    }

    private func defineLayout() {
        imgView.autoPinEdgesToSuperviewEdges()
    }

}
