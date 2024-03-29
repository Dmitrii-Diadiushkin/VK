//
//  NetworkManager.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 29.12.2020.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://api.vk.com"
    private let version = "5.92"
    private let userID = VKSession.shared.userID
    
    private let baseUrlConstructor: URLComponents = {
        var baseURLComponetns = URLComponents()
        baseURLComponetns.scheme = "https"
        baseURLComponetns.host = "api.vk.com"
        baseURLComponetns.queryItems = [
            URLQueryItem(name: "v", value: "5.126"),
            URLQueryItem(name: "access_token", value: VKSession.shared.token)
        ]
        return baseURLComponetns
    }()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    private enum RequestType {
        case friendsRequest
        case albumsRequest
    }
    
    private func configureURL(requestType: RequestType, friendID: Int? = nil) -> URL? {
        switch requestType {
        case .friendsRequest:
            var UrlConstructor = baseUrlConstructor
            UrlConstructor.path = "/method/friends.get"
            UrlConstructor.queryItems?.append(URLQueryItem(name: "order", value: "name"))
            UrlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "name,photo_100"))
            
            let url = UrlConstructor.url
            
            return url
            
        case .albumsRequest:
            var UrlConstructor = baseUrlConstructor
            guard let friendID = friendID else { return nil}
            UrlConstructor.path = "/method/photos.getAlbums"
            UrlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(friendID)))
            UrlConstructor.queryItems?.append(URLQueryItem(name: "need_system", value: "1"))
            UrlConstructor.queryItems?.append(URLQueryItem(name: "need_covers", value: "1"))
            
            let url = UrlConstructor.url
            
            return url
        }
    }
    
    func getFriends(completion: ((Swift.Result<Friends, Error>) -> Void)? = nil) {
        
        guard let url = configureURL(requestType: .friendsRequest) else {
            print("URL Error!")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let recievedData = data else {return}
            do {
                let json = try JSONDecoder().decode(Friends.self, from: recievedData)
                completion?(.success(json))
            } catch {
                print(error.localizedDescription)
                completion?(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getFriendAlbums(friendID: Int, completion: ((Swift.Result<FriendsAlbums, Error>) -> Void)? = nil) {
        guard let url = configureURL(requestType: .albumsRequest, friendID: friendID) else {
            print("URL Error!")
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let recievedData = data else { return }
            do {
                let json = try JSONDecoder().decode(FriendsAlbums.self, from: recievedData)
                completion?(.success(json))
            } catch {
                print(error.localizedDescription)
                completion?(.failure(error))
            }
        }
        
        task.resume()
    }
}
