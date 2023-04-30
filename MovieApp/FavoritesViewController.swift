import Foundation
import UIKit
import PureLayout
import MovieAppData

class FavoritesViewController: UIViewController {
    
    override func viewDidLoad() {
        buildViews()
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
