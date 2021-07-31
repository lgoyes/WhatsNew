//
//  LocalizedKey.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import Foundation

struct LocalizedKey {
    struct Main {
        struct SegmentControl {
            static let all = "main.segmentcontroloption.all"
            static let favorites = "main.segmentcontroloption.favorites"
        }
        static let posts = "main.posts"
        static let deleteAll = "main.deleteall"
        static let emptyPosts = "main.emptyposts"
    }
    struct Detail {
        static let post = "detail.post"
        static let description = "detail.description"
        static let user = "detail.user"
        static let comments = "detail.comments"
    }
}
