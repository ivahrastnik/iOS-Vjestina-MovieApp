import Foundation

enum Defaults {
    private static let favoriteMoviesIdsKey = "favoriteMoviesIdsKey"
      
      static var favoriteMoviesIds: [Int]? {
        get {
          guard let _ = UserDefaults.standard.array(forKey: favoriteMoviesIdsKey) as? [Int] else {
            let list: [Int] = .init()
            UserDefaults.standard.set(list, forKey: favoriteMoviesIdsKey)
            return list
          }
          return UserDefaults.standard.array(forKey: favoriteMoviesIdsKey) as? [Int]
        }
        set {
          UserDefaults.standard.set(newValue, forKey: favoriteMoviesIdsKey)
        }
      }
}
