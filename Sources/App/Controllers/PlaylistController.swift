import Vapor

final class PlaylistController {
    
    /// Get playlists
    func getPlaylists(_ req: Request) throws -> Future<[Playlist]> {
        return Playlist.query(on: req).all()
    }

    /// Create new playlist
    func createPlaylist(_ req: Request) throws -> Future<Playlist> {
        return try req.content.decode(Playlist.self).flatMap { playlist in
            return playlist.save(on: req)
        } 
    }

    /// Find playlist by id
    func findPlaylistById(_ req: Request) throws -> Future<Playlist> {
        return try req.parameters.next(Playlist.self).flatMap { playlist in
            return req.future(playlist)
        }
    }

    /// Update playlist by id
    func updatePlaylist(_ req: Request) throws -> Future<Playlist> {
        return try req.parameters.next(Playlist.self).flatMap({ playlist -> EventLoopFuture<Playlist> in
            return try req.content.decode(Playlist.self).flatMap { updatedPlaylist -> EventLoopFuture<Playlist> in
                print(updatedPlaylist.name)
                print(updatedPlaylist.description)
                playlist.name = updatedPlaylist.name
                playlist.description = updatedPlaylist.description
                return playlist.update(on: req)
            }
        })
    }

    /// Delete playlist by id
    func deletePlaylist(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Playlist.self).flatMap { playlist in
            return playlist.delete(on: req)
        }.transform(to: .noContent)
    }

    /// Add song to playlist
    func addSongToPlaylist(_ req: Request) throws -> Future<Playlist> {
        return try req.parameters.next(Playlist.self).flatMap({ playlist -> EventLoopFuture<Playlist> in
                let releaseId = try req.parameters.next(Int.self)
                playlist.songs.append(releaseId)
                return playlist.update(on: req)
        })
    }

    /// Remove song from playlist
    func removeSongFromPlaylist(_ req: Request) throws -> Future<Playlist> {
        return try req.parameters.next(Playlist.self).flatMap({ playlist -> EventLoopFuture<Playlist> in
                let releaseId = try req.parameters.next(Int.self)
                if let index = playlist.songs.firstIndex(of: releaseId) {
                    playlist.songs.remove(at: index)
                }
            return playlist.update(on: req)
        })
    }
}
