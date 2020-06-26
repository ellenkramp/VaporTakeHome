import Vapor

struct DiscogService: ArtistService {
    private let searchURL = "https://api.discogs.com/database/search"

    private let headers: HTTPHeaders = [
        "Authorization": "Discogs token=\(Environment.apiToken)"
    ]

    func searchArtist(artist: String, on req: Request) throws -> Future<[Artist]> {
        var components = URLComponents(string: searchURL)
        components?.queryItems = [URLQueryItem(name: "q", value: artist), URLQueryItem(name: "type", value: "artist")]

        guard let url = components?.url else {
            fatalError("Couldn't create search URL")
        }

        return try req.client().get(url, headers: headers).flatMap({ response in
            return try response.content.decode(ArtistSearchResponse.self).flatMap({ artistSearch in
                return req.future(artistSearch.results)
            })
        })
    }
    func searchSong(song: String, artistId: String, on req: Request) throws -> Future<[Song]> {
        var components = URLComponents(string: searchURL)
        components?.queryItems = [URLQueryItem(name: "q", value: song), URLQueryItem(name: "type", value: "song"), URLQueryItem(name: "artist", value: artistId)]

        guard let url = components?.url else {
            fatalError("Couldn't create search URL")
        }

        return try req.client().get(url, headers: headers).flatMap({ response in
            return try response.content.decode(SongSearchResponse.self).flatMap({ songSearch in
                return req.future(songSearch.results)
            })
        })
    }
}
