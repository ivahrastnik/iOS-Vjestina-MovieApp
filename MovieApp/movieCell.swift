import UIKit
import PureLayout
import Kingfisher

class movieCell: UICollectionViewCell {
    
//    override func viewDidLayoutSubviews() {
//        iconView.layer.cornerRadius = iconView.layer.bounds.width / 2
//        iconView.clipsToBounds = true
//    }

    static let reuseIdentifier = String(describing: movieCell.self)

    private var imgView: UIImageView!
    private var iconImage: UIImageView!
    private var iconView: UIView!
    
    private let iconViewSize: CGFloat = 32
    private let cornerRadius: CGFloat = 10
    private let iconViewOffset: CGFloat = 8

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
        
        iconView = UIView()
        imgView.addSubview(iconView)
        
        iconImage = UIImageView()
        iconView.addSubview(iconImage)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cornerRadius
        
        imgView.layer.cornerRadius = cornerRadius
        imgView.clipsToBounds = true
        
        iconView.backgroundColor = UIColor(red: 0.04, green: 0.15, blue: 0.25, alpha: 0.6)
        iconView.layer.cornerRadius = iconViewSize / 2
        iconView.clipsToBounds = true
        
        let icon = UIImage(systemName: "heart")
        iconImage.image = icon
        iconImage.tintColor = .white
    }

    private func defineLayout() {
        imgView.autoPinEdgesToSuperviewEdges()
        
        iconView.autoSetDimension(.height, toSize: iconViewSize)
        iconView.autoSetDimension(.width, toSize: iconViewSize)
        iconView.autoPinEdge(.top, to: .top, of: imgView, withOffset: iconViewOffset)
        iconView.autoPinEdge(.leading, to: .leading, of: imgView, withOffset: iconViewOffset)
        
        iconImage.autoSetDimension(.height, toSize: 16.13)
        iconImage.autoSetDimension(.width, toSize: 18)
        iconImage.autoCenterInSuperview()
    }

}
