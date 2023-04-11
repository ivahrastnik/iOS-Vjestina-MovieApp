import Foundation
import UIKit
import PureLayout
import MovieAppData
import Kingfisher

public var categoryId: Int!

class PopularMoviesViewController: UIViewController {
    
    private var tableView: UITableView!
    private let tableViewCellHeight: CGFloat = 263
    private let numberOfMovieCategories: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView = UITableView(
        frame: CGRect( x: 0,
        y: 0,
        width: view.bounds.width, height: view.bounds.height))
        view.addSubview(tableView)
        tableView.dataSource = self
        buildViews()
    }
    
    private func buildViews() {
        styleViews()
        defineLayoutForViews()
    }
    
    private func styleViews(){
        tableView.separatorStyle = .none
    }
    
    private func defineLayoutForViews() {
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
    }
}
    
extension PopularMoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfMovieCategories
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        categoryId = indexPath.row
        self.tableView.register(collectionCell.self, forCellReuseIdentifier: "collectionCell")
        self.tableView.rowHeight = tableViewCellHeight
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: collectionCell.reuseIdentifier, for: indexPath)
                as? collectionCell,
            3 > indexPath.item
                
        else { return UITableViewCell() }
        print("DEBUG: cellForItemAt: \(indexPath)")
        
        return cell
    }
}
