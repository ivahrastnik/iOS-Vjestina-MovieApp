import Foundation
import UIKit
import PureLayout
import MovieAppData

class FavoritesViewController: UIViewController {
    
    private var favoritesViewModel: FavoritesViewModel!
        
    init(favoritesViewModel: FavoritesViewModel) {
        self.favoritesViewModel = favoritesViewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        loadData()
    }
    
    private func loadData() {
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){}
    
    private func styleViews(){
        view.backgroundColor = .white
    }
    
    private func defineLayoutForViews(){}
}
