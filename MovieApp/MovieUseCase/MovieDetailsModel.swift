import Foundation

class MovieDetailsModel: Codable {
    public let id: Int
    public let name: String
    public let summary: String
    public let imageUrl: String
    public let releaseDate: String
    public let year: Int
    public let duration: Int
    public let rating: Double
    public let categories: [String]
    public let crewMembers: [MovieCrewMemberModel]
    
    init() {
        id = 0
        name = ""
        summary = ""
        imageUrl = ""
        releaseDate = ""
        year = 0
        duration = 0
        rating = 0
        categories = []
        crewMembers = []
    }
}

class MovieCrewMemberModel: Codable {
    let name: String
    let role: String
}
