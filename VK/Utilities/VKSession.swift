//
//  VKSession.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 07.12.2020.
//

import Foundation

class VKSession {
    var token: String = ""
    var userID: Int = 0
    
    static let shared = VKSession()
    
    private init() {}
}
