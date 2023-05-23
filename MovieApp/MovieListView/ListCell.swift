import UIKit
import PureLayout
import Kingfisher

class ListCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: ListCell.self)

    private var nameView: UILabel!
    private var summaryView: UILabel!
    private var imgView: UIImageView!
    private let cornerRadiusSize: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, summary: String, imageUrl: String, year: Int) {
        var movieNameAndYearLabel = name
        movieNameAndYearLabel += " ("
        movieNameAndYearLabel += NumberFormatter.localizedString(from: NSNumber(value: year), number: .none)
        movieNameAndYearLabel += ")"
        nameView.text = movieNameAndYearLabel
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        summaryView.attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        imgView.kf.setImage(with: URL(string: imageUrl))
    }
}

extension ListCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        nameView = UILabel()
        summaryView = UILabel()
        imgView = UIImageView()
        contentView.addSubview(nameView)
        contentView.addSubview(summaryView)
        contentView.addSubview(imgView)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = cornerRadiusSize
        contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 10).cgPath
        contentView.layer.shadowColor = Colors.shadowColor.cgColor
        contentView.layer.shadowRadius = 20
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.position = contentView.center
        
        imgView.layer.cornerRadius = cornerRadiusSize
        imgView.clipsToBounds = true
        imgView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        nameView.textColor = .black
        nameView.font = UIFont(name: "ProximaNova-Bold", size: 16)
        nameView.textAlignment = .left

        summaryView.textColor = .black
        summaryView.font = UIFont(name: "ProximaNova-Regular", size: 14)
        summaryView.textAlignment = .left
        summaryView.numberOfLines = 0
        summaryView.lineBreakMode = .byWordWrapping
        
    }

    private func defineLayout() {
        nameView.autoSetDimension(.height, toSize: 20)
        nameView.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        nameView.autoPinEdge(.leading, to: .trailing, of: imgView, withOffset: 16)
        nameView.autoPinEdge(toSuperviewSafeArea: .trailing)
        
        summaryView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)
        summaryView.autoPinEdge(.leading, to: .trailing, of: imgView, withOffset: 16)
        summaryView.autoPinEdge(.top, to: .bottom, of: nameView, withOffset: 8)
        summaryView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 8)
        
        imgView.autoSetDimension(.width, toSize: 97)
        imgView.autoPinEdge(toSuperviewEdge: .top)
        imgView.autoPinEdge(toSuperviewEdge: .bottom)
        imgView.autoPinEdge(toSuperviewEdge: .leading)
    }
}
