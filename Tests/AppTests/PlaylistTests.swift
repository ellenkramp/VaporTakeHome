@testable import App
import FluentPostgreSQL
@testable import Vapor
import XCTest

class PlaylistTests: XCTestCase {

    var app: Application!
    var connection: PostgreSQLConnection!
    var request: Request!

    override func setUp() {
        do {
            try Application.reset()
            self.app = try Application.testable()
            self.connection = try self.app.newConnection(to: .psql).wait()
        }
        catch {
            fatalError(error.localizedDescription)
        }

        self.request = Request(using: self.app)
    }

    override func tearDown() {
        self.connection?.close()
        try? app.syncShutdownGracefully()
    }

    func testCreatePlaylist() throws {
        let newPlaylist = Playlist(name: "My Favorite Playlist", description: "the best", songs: [1, 2, 3])
        let playlist = try self.app.getResponse(to: "/playlists", method: .POST, data: newPlaylist, decodeTo: Playlist.self)

        XCTAssertTrue(playlist.id != nil)
        XCTAssertEqual(playlist.name, "My Favorite Playlist")
    }

    func testGetPlaylist() throws {
        let newPlaylist = Playlist(name: "Just a Playlist", description: "okay", songs: [11, 12, 13])
        let playlist = try self.app.getResponse(to: "/playlists", method: .POST, data: newPlaylist, decodeTo: Playlist.self)

        let playlistID = try playlist.requireID()
        let updatedPlaylist = try self.app.getResponse(to: "/playlists/\(playlistID)", decodeTo: Playlist.self)

        XCTAssertEqual(updatedPlaylist.id, playlistID)
        XCTAssertEqual(updatedPlaylist.name, "Just a Playlist")
    }

    func testUpdatePlaylist() throws {
        let newPlaylist = Playlist(name: "Party Time", description: "get down", songs: [4, 5, 6])
        let playlist = try self.app.getResponse(to: "/playlists", method: .POST, data: newPlaylist, decodeTo: Playlist.self)

        XCTAssertTrue(playlist.id != nil)
        XCTAssertEqual(playlist.name, "Party Time")

        playlist.name = "No Party"

        let playlistID = try playlist.requireID()
        let updatedPlaylist = try self.app.getResponse(to: "/playlists/\(playlistID)", method: .PUT, data: playlist, decodeTo: Playlist.self)

        XCTAssertEqual(updatedPlaylist.id, playlistID)
        XCTAssertEqual(updatedPlaylist.name, "No Party")
    }

    func testDeletePlaylist() throws {
        let newPlaylist = Playlist(name: "My Favorite Playlist", description: "the best", songs: [1, 2, 3])
        let playlist = try self.app.getResponse(to: "/playlists", method: .POST, data: newPlaylist, decodeTo: Playlist.self)

        let playlistID = try playlist.requireID()
        let retrievedPlaylist = try self.app.getResponse(to: "/playlists/\(playlistID)", decodeTo: Playlist.self)

        XCTAssertEqual(retrievedPlaylist.id, playlistID)

        let deleteResponse = try self.app.sendRequest(to: "/playlists/\(playlistID)", method: .DELETE)
        XCTAssertEqual(deleteResponse.http.status, .noContent)

        let notFoundResponse = try self.app.sendRequest(to: "/playlists/\(playlistID)", method: .GET)
        XCTAssertEqual(notFoundResponse.http.status, .notFound)
    }
}
