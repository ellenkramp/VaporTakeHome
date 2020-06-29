import Vapor
import FluentPostgreSQL

struct UpdatePlaylistRequest: Codable {
    var name: String?
    var description: String?

    enum CodingKeys: String, CodingKey {
        case name
        case description
    }
}

extension UpdatePlaylistRequest: Content { }
