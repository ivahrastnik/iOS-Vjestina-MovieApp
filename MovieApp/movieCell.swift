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

    

}

extension movieCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
    }

    private func styleViews() {
        contentView.backgroundColor = .systemPink
        contentView.layer.cornerRadius = 10
    }

    private func defineLayout() {
        
    }

}
