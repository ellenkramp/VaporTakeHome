import Foundation
import Vapor
@testable import App

class MockArtistService: ArtistService, Service {
    var artistsToReturn: [Artist] = []
    var searchedArtists: [String] = []
    var songsToReturn: [Song] = []
    var searchedSongs: [Song] = []

    func reset() {
        artistsToReturn = []
        searchedArtists = []
        songsToReturn = []
        searchedSongs = []
    }

    // MARK - ArtistService
    func searchArtist(artist: String, on req: Request) throws -> EventLoopFuture<[Artist]> {
        searchedArtists.append(artist)
        return req.future(artistsToReturn)
    }
    
    func searchSong(song: String, artistId: Int, on req: Request) throws -> EventLoopFuture<[Song]> {
        searchedArtists.append(song)
        return req.future(songsToReturn)
    }
    
}
