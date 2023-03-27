import Foundation
import UIKit
import PureLayout
import MovieAppData

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class MovieDetailsViewController: UIViewController {
    
    private var movieView1: UIView!
    private var movieView2: UIView!
    private let details: MovieDetailsModel! = nil
    private var img: UIImage!
    private var imgView: UIImageView!
    private var label: UILabel!
    private var textBox: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    private func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }
    
    private func createViews(){
        let details = MovieUseCase().getDetails(id: 111161)
        
//        img = UIImage()
        
        let url = URL(string: details?.imageUrl ?? "")!
//        downloadImage(from: url)
        
//        var imgView = UIImageView()
//        imgView.downloaded(from: url)

//        DispatchQueue.global().async {
//                // Fetch Image Data
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                        // Create Image and Update Image View
//                    self.imgView.image = UIImage(data: data)
//                }
//            }
//        }
        
        print(details)
//        view.addSubview(imgView)
//        movieView1 = UIView()
//        movieView1.addSubview(imgView)
//        view.addSubview(movieView1)
        movieView2 = UIView()
        view.addSubview(movieView2)
        
        label = UILabel()
        movieView2.addSubview(label)
        label.text = "Overview"
        
        textBox = UILabel()
        movieView2.addSubview(textBox)
//        textBox.text = details?.summary
        textBox.numberOfLines = 0
        textBox.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.4
        textBox.attributedText = NSMutableAttributedString(string: details?.summary ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        
    }
    
    private func styleViews(){
        
//        movieView1.backgroundColor = UIColor(patternImage: img)
        movieView2.backgroundColor = .white
        
        label.textColor = .black
        label.font = UIFont(name: "ProximaNova-Bold", size: 20)
        label.textAlignment = .left
        
        textBox.textColor = .black
        textBox.font = UIFont(name: "ProximaNova-Regular", size: 14)
        textBox.textAlignment = .left
        
    }
    
    private func defineLayoutForViews(){
        
//        movieView1.autoSetDimension(.height, toSize: 327)
//        movieView1.autoPinEdge(toSuperviewSafeArea: .top)
//        movieView1.autoPinEdge(toSuperviewEdge: .leading)
//        movieView1.autoPinEdge(toSuperviewEdge: .trailing)
        
        movieView2.autoSetDimension(.height, toSize: 500)
        movieView2.autoPinEdge(toSuperviewSafeArea: .top)
        movieView2.autoPinEdge(toSuperviewEdge: .leading)
        movieView2.autoPinEdge(toSuperviewEdge: .trailing)
        
        label.autoPinEdge(toSuperviewEdge: .top, withInset: 22)
        label.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        label.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        
        textBox.autoPinEdge(.top, to: .bottom, of: label, withOffset: 8.38)
        textBox.autoPinEdge(toSuperviewEdge: .leading, withInset: 16)
        textBox.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16)
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.img = UIImage(data: data)
            }
        }
    }
    
    
    
}

