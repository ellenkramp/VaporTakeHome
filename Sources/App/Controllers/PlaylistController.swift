import Vapor

final class PlaylistController {
    
    /// Get playlists
    func getPlaylists(_ req: Request) throws -> Future<[Playlist]> {
        print(req)
        return Playlist.query(on: req).all()
    }

    /// Create new playlist
    func createPlaylist(_ req: Request) throws -> Future<Playlist> {
        return try req.content.decode(Playlist.self).flatMap { playlist in
            return playlist.save(on: req)
        } 
    }

    /// Find playlist by id
    func findPlaylistById(_ req: Request) throws -> Future<[Playlist]> {
        let artist = try req.query.get(String.self, at: "q")
        let service = try req.make(PlaylistService.self)
        return try service.findPlaylistById(artist: artist, on: req)    
    }

    /// Update playlist by id
    func updatePlaylist(_ req: Request) throws -> Future<Playlist> {
        return try req.parameters.next(Playlist.self).flatMap({ playlist -> EventLoopFuture<Playlist> in
            return try req.content.decode(Playlist.self).flatMap { updatedPlaylist -> EventLoopFuture<Playlist> in
                playlist.name = updatedPlaylist.name
                playlist.description = updatedPlaylist.description
                playlist.songs = updatedPlaylist.songs
                return playlist.update(on: req)
            }
        })
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
