import Vapor

final class PlaylistController {
    
    /// Get playlists
    func getPlaylist(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.getPlaylist(artist: artist, on: req)
    }

    /// Create new playlist
    func createPlaylist(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.createPlaylist(artist: artist, on: req)    
    }

    /// Find playlist by id
    func findPlaylistById(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.findPlaylistById(artist: artist, on: req)    
    }

    /// Update playlist by id
    func updatePlaylist(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.updatePlaylist(artist: artist, on: req)    
    }

    /// Delete playlist by id
    func deletePlaylist(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.deletePlaylist(artist: artist, on: req)    
    }

    /// Add song to playlist
    func addSongToPlaylist(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.addSongToPlaylist(artist: artist, on: req)    
    }

    /// Remove song from playlist
    func removeSongFromPlaylist(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.removeSongFromPlaylist(artist: artist, on: req)    
    }
}
