//
//  FriendsAlbums.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 03.05.2021.
//

import Foundation

struct FriendsAlbums: Decodable {
    let albums: [Album]
    let count: Int
    
    enum BaseCodingKeys: String, CodingKey {
        case response
    }
    
    enum NestedCodingKeys: String, CodingKey {
        case items
        case count
    }
    
    init(from decoder: Decoder) throws {
        let responce = try decoder.container(keyedBy: BaseCodingKeys.self)
        let items = try responce.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .response)
        
        self.albums = try items.decode([Album].self, forKey: .items)
        print("Step 1")
        self.count = try items.decode(Int.self, forKey: .count)
    }
}

struct Album: Decodable {
    let title: String
    let thumbSrc: String
    let id: Int
    
    enum AlbumKeys: String, CodingKey {
        case id
        case title
        case thumbSrc = "thumb_src"
    }
    
    init(from decoder: Decoder) throws {
        let album = try decoder.container(keyedBy: AlbumKeys.self)
        self.title = try album.decode(String.self, forKey: .title)
        self.id = try album.decode(Int.self, forKey: .id)
        self.thumbSrc = try album.decode(String.self, forKey: .thumbSrc)
    }
}
