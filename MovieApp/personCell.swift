import UIKit
import PureLayout

class personCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: personCell.self)

    private var nameLabel: UILabel!
    private var roleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setName(name: String) {
        nameLabel.text = "\(name)"
    }
    
    func setRole(role: String) {
        roleLabel.text = "\(role)"
    }

}

extension personCell {

    private func buildViews() {
        createViews()
        styleViews()
        defineLayout()
    }

    private func createViews() {
        nameLabel = UILabel()
        roleLabel = UILabel()
        contentView.addSubview(nameLabel)
        contentView.addSubview(roleLabel)
    }

    private func styleViews() {
        contentView.backgroundColor = .white
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont(name: "ProximaNova-Bold", size: 14)
        nameLabel.textAlignment = .left

        roleLabel.textColor = .black
        roleLabel.font = UIFont(name: "ProximaNova-Regular", size: 14)
        roleLabel.textAlignment = .left
        
    }

    private func defineLayout() {
        nameLabel.autoSetDimension(.height, toSize: 20)
        roleLabel.autoSetDimension(.height, toSize: 20)

        nameLabel.autoPinEdge(toSuperviewEdge: .top)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading)
        roleLabel.autoPinEdge(.top, to: .bottom, of: nameLabel)
        roleLabel.autoPinEdge(.leading, to: .leading, of: nameLabel)
    }

}
