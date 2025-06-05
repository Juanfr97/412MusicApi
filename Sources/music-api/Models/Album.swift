//
//  Album.swift
//  music-api
//
//  Created by Juan Frausto on 02/06/25.
//
import Fluent
import Foundation
import Vapor

final class Album : Model, @unchecked Sendable, Content {
    
    static let schema = "album"
    
    @ID(key: .id)
    var id : UUID?
    
    @Field(key:"title")
    var title : String
    
    @Field(key:"artist")
    var artist : String
    
    @Field(key:"description")
    var description : String
    
    @Field(key:"image")
    var image : String
    
    init() {}
    
    init(id: UUID? = nil, title: String, artist: String, description: String, image : String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.description = description
        self.image = image
    }
    
}
