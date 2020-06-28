import Foundation
import Vapor

protocol ArtistService: Service {
    func searchArtist(artist: String, on req: Request) throws -> Future<[Artist]>
    func searchSong(song: String, artistId: Int, on req: Request) throws -> Future<[Song]>
}
