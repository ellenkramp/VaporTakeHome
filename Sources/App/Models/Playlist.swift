import Vapor
import FluentPostgreSQL

final class Playlist: PostgreSQLModel {
    typealias Database = PostgreSQLDatabase

    var id: Int?
    var name: String
    var description: String
    var songs: [Int]

    /// Creates a new `User`.
    init(id: Int? = nil, name: String, description: String, songs: [Int]) {
        self.id = id
        self.name = name
        self.description = description
        self.songs = songs
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case songs
    }
}

extension Playlist: Content { }

extension Playlist: Parameter { }
