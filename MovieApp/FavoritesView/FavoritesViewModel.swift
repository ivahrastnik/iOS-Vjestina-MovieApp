import Foundation

class FavoritesViewModel {
    
    @Published var favMovies: [MovieDetailsModel] = []
    private let movieUseCase: MovieUseCase!
    
    var ids: [Int] = []
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func getMovieDetails() {
        favMovies = []
        ids = Defaults.favoriteMoviesIds ?? []
        ids.forEach({ id in
            Task {
                let movie = await movieUseCase.getMovieDetails(id: id)
                if let movie = movie {
                    self.favMovies.append(movie)
                }
            }
        })
    }
    
}
