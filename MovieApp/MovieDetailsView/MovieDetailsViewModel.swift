import Foundation

class MovieDetailsViewModel {
    
    @Published var movieDetails: MovieDetailsModel = MovieDetailsModel()
    private let movieUseCase: MovieUseCase!
    var id: Int = 0
    
    init(id: Int, movieUseCase: MovieUseCase) {
            self.id = id
            self.movieUseCase = movieUseCase
    }
    
    func getMovieDetails() {
        Task {
            let movie = await movieUseCase.getMovieDetails(id: id)
            if let movie = movie {
                self.movieDetails = movie
            }
        }
    }
}
