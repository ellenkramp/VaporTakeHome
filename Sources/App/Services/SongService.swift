import Foundation
import Vapor

protocol SongService: Service {
    func searchSong(song: String, artistId: String, on req: Request) throws -> Future<[Song]>
}
