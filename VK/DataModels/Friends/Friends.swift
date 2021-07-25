//
//  Friends.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 29.12.2020.
//

import Foundation

struct Friends: Decodable {
    let friends: [Friend]

    enum BaseCodingKeys: String, CodingKey {
        case response
    }

    enum NestedCodingKeys: String, CodingKey {
        case items
    }

    init(from decoder: Decoder) throws {
        let responce = try decoder.container(keyedBy: BaseCodingKeys.self)
        let items = try responce.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .response)

        self.friends = try items.decode([Friend].self, forKey: .items)
    }
}

struct Friend: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String

    enum FriendKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }

    init(from decoder: Decoder) throws {
        let friend = try decoder.container(keyedBy: FriendKeys.self)
        self.id = try friend.decode(Int.self, forKey: .id)
        self.firstName = try friend.decode(String.self, forKey: .firstName)
        self.lastName = try friend.decode(String.self, forKey: .lastName)
        self.photo = try friend.decode(String.self, forKey: .photo)
    }
}
