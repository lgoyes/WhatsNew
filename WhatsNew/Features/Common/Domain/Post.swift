//
//  Post.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

struct Post: Identifiable {
    let id: Int
    let description: String
    let visited: Bool
    let favorite: Bool
    let fetchDate: Date
}
