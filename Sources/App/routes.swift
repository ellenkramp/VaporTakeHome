import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Basic "Hello Universe" example
    router.get { req in
        return "Hello Universe"
    }

    // Example of configuring a controller
    let userController = UserController()
    router.post("users", use: userController.create)
    router.get("users", User.parameter, use: userController.find)
    router.get("users", use: userController.index)
    router.put("users", User.parameter, use: userController.update)
    router.delete("users", User.parameter, use: userController.delete)

    let artistController = ArtistController()
    router.get("artists/search", use: artistController.searchArtist)
    router.get("artists", Int.parameter, "songs/search", use: artistController.searchSong)

    let playlistController = PlaylistController()
    router.get("playlists", use: playlistController.getPlaylists)
    router.post("playlists", use: playlistController.createPlaylist)
    router.get("playlists", Playlist.parameter, use: playlistController.findPlaylistById)
    router.put("playlists", Playlist.parameter, use: playlistController.updatePlaylist)
    router.delete("playlists", Playlist.parameter, use: playlistController.deletePlaylist)
    router.post("playlists", Playlist.parameter, "songs", Int.parameter, use: playlistController.addSongToPlaylist)
    router.delete("playlists", Playlist.parameter, "songs", Int.parameter, use: playlistController.removeSongFromPlaylist)
}
