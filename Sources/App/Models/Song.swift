import Vapor

struct Song: Codable {
    let id: Int
    let title: String
    let label: String
    let thumb: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case label
        case thumb
    }
}

extension Song: Content { }
