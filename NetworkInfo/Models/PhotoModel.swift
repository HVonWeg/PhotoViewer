//
//  PhotosModel.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 03.11.21.
//

import Foundation

struct PhotoModel: Codable {
    var albumID: Int?
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
