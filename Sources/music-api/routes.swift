import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, worrld!"
    }
    
    app.get("albums"){ req async throws -> [Album] in
        let albums = try await Album.query(on: req.db).all()
        return albums
    }
    // localhost:8080/albums/1/test
    app.get("albums",":id"){ req async throws -> Album in
        guard let album = try await Album.find(req.parameters.get("id"),on: req.db) else {
            throw Abort(.notFound,reason: "El registro no ha sido encontrado")
        }
        return album
    }
    
    app.post("albums"){ req async throws -> Album in
        let album = try req.content.decode(Album.self)
        try await album.save(on:req.db)
        return album
    }
    
    app.put("albums",":id"){ req async throws -> Album in
        guard let existingAlbum = try await Album.find(req.parameters.get("id"),on: req.db) else {
            throw Abort(.notFound,reason: "El registro no ha sido encontrado")
        }
        let updatedAlbum = try req.content.decode(Album.self)
        
        existingAlbum.title = updatedAlbum.title
        existingAlbum.description = updatedAlbum.description
        existingAlbum.artist = updatedAlbum.artist
        existingAlbum.image = updatedAlbum.image
        try await existingAlbum.update(on: req.db)
        return existingAlbum

    }

    try app.register(collection: TodoController())
}
