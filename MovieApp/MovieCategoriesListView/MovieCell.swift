import UIKit
import PureLayout
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MovieCell.self)

    private var imgView: UIImageView!
    private var movieId: Int!
    private var iconImage: UIImageView!
    private var iconView: UIView!
    private var heart: UIButton!
    
    private let iconViewSize: CGFloat = 32
    private let cornerRadius: CGFloat = 10
    private let iconViewOffset: CGFloat = 8
    private var didTapHeart: (() -> Void)?
//    private weak var delegate: Delegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
        addActions()
    }

    private func createViews() {
        imgView = UIImageView()
        contentView.addSubview(imgView)
        
        heart = UIButton()
        contentView.addSubview(heart)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cornerRadius
        
        imgView.layer.cornerRadius = cornerRadius
        imgView.clipsToBounds = true
        
        heart.tintColor = .white
        heart.backgroundColor = Colors.iconBackgroundColor
        heart.layer.cornerRadius = 16
        heart.setImage(UIImage(systemName: "heart"), for: .normal)
        heart.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }

    private func defineLayout() {
        imgView.autoPinEdgesToSuperviewEdges()
        
        heart.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        heart.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        heart.autoSetDimensions(to: CGSize(width: 32, height: 32))
    }
    
    private func addActions() {
        heart.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
    }
    
    @objc
      private func tap(_ sender: UIButton!) {
          heart.isSelected = !heart.isSelected
          if heart.isSelected {
              Defaults.favoriteMoviesIds?.append(movieId)
          } else {
              let index = Defaults.favoriteMoviesIds?.firstIndex(of: movieId)
              if let index = index {
                  Defaults.favoriteMoviesIds?.remove(at: index)
              }
          }
    }
      
    override func prepareForReuse() {
        imgView.image = nil
    }
    
    public func configure(with url: URL?, movieId: Int, didTapHeart: @escaping () -> Void) {
        
        imgView.kf.setImage(with: url)
        self.didTapHeart = didTapHeart
        self.movieId = movieId
        
        let favIds = Defaults.favoriteMoviesIds
        if let favIds = favIds {
            if favIds.contains(movieId) {
                heart.isSelected = true
            } else {
                heart.isSelected = false
            }
        } else {
            heart.isSelected = false
        }
      }
}
