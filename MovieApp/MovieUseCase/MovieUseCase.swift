import Foundation

class MovieUseCase {
    
    private let key = String("Bearer Zpu7bOQYLNiCkT32V3c9BPoxDMfxisPAfevLW6ps")
    
    private func urlRequest(for urlString: String) -> URLRequest? {
            guard let url = URL(string: urlString)
            else { return nil }
            
            var request = URLRequest(url: url)
            request.setValue(key, forHTTPHeaderField: "Authorization")
            
            return request
    }
    
    func getPopularMovies(criteria: String) async -> [MovieListModel] {
        guard let request = urlRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/popular?criteria=\(criteria)")
        else { return [] }
            
        async let (data, _) = try await URLSession.shared.data(for: request)
        let movies = try? await JSONDecoder().decode([MovieListModel].self, from: data)

        return movies ?? []
    }
    
    func getTrendingMovies(criteria: String) async -> [MovieListModel] {
        guard let request = urlRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/trending?criteria=\(criteria)")
        else { return [] }
            
        async let (data, _) = try await URLSession.shared.data(for: request)
        let movies = try? await JSONDecoder().decode([MovieListModel].self, from: data)

        return movies ?? []
    }
    
    func getFreeToWatchMovies(criteria: String) async -> [MovieListModel] {
        guard let request = urlRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/free-to-watch?criteria=\(criteria)")
        else { return [] }
            
        async let (data, _) = try await URLSession.shared.data(for: request)
        let movies = try? await JSONDecoder().decode([MovieListModel].self, from: data)

        return movies ?? []
    }
    
    func getMovieDetails(id: Int) async -> MovieDetailsModel? {
            guard
                let request = urlRequest(for: "https://five-ios-api.herokuapp.com/api/v1/movie/\(id)/details")
            else { return nil }
            
            async let (data, _) = try await URLSession.shared.data(for: request)
            let movies = try? await JSONDecoder().decode(MovieDetailsModel.self, from: data)

            return movies ?? nil
        }
}
