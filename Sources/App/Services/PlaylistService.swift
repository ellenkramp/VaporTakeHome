import Foundation
import Vapor

protocol PlaylistService: Service {
    func getPlaylist(artist: String, on req: Request) throws -> Future<[Playlist]>
    func createPlaylist(artist: String, on req: Request) throws -> Future<[Playlist]>
    func findPlaylistById(artist: String, on req: Request) throws -> Future<[Playlist]>
    func updatePlaylist(artist: String, on req: Request) throws -> Future<[Playlist]>
    func deletePlaylist(artist: String, on req: Request) throws -> Future<[Playlist]>
    func addSongToPlaylist(artist: String, on req: Request) throws -> Future<[Playlist]>
    func removeSongFromPlaylist(artist: String, on req: Request) throws -> Future<[Playlist]>
}
