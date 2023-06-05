import Foundation

class MovieListViewModel {
    
    @Published var allMovies: [MovieListModel] = []
    let movieUseCase: MovieUseCase!
        
    init(movieUseCase: MovieUseCase!) {
        self.movieUseCase = movieUseCase
    }
    
    func getAllMovies() {
        
        Task {
            var popularMovies = await movieUseCase.getPopularMovies(criteria: "FOR_RENT")
            popularMovies.append(contentsOf: await movieUseCase.getPopularMovies(criteria: "IN_THEATERS"))
            popularMovies.append(contentsOf: await movieUseCase.getPopularMovies(criteria: "ON_TV"))
            popularMovies.append(contentsOf: await movieUseCase.getPopularMovies(criteria: "STREAMING"))
            
            var freeToWatchMovies = await movieUseCase.getFreeToWatchMovies(criteria: "MOVIE")
            freeToWatchMovies.append(contentsOf: await movieUseCase.getFreeToWatchMovies(criteria: "TV_SHOW"))
                       
            var trendingMovies = await movieUseCase.getTrendingMovies(criteria: "THIS_WEEK")
            trendingMovies.append(contentsOf: await movieUseCase.getTrendingMovies(criteria: "TODAY"))
            
            self.allMovies = freeToWatchMovies + popularMovies + trendingMovies
        }
    }
}
