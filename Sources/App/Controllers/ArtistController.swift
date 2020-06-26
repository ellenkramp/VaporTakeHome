import Vapor

final class ArtistController {
    
    /// Searches for artists
    func searchArtist(_ req: Request) throws -> Future<[Artist]> {
        let artistString = try req.query.get(String.self, at: "q")
        let service = try req.make(ArtistService.self)
        return try service.searchArtist(artist: artistString, on: req)
    }

    /// Searches for song by artist id
    func searchSong(_ req: Request) throws -> Future<[Song]> {
        let artistId = try req.parameters.next(String.self)
        print(artistId)
        let songString = try req.query.get(String.self, at: "q")
        let service = try req.make(SongService.self)
        return try service.searchSong(song: songString, artistId: artistId, on: req)
    }
}
