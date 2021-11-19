//
//  PhotosModel.swift
//  NetworkInfo
//
//  Created by Heiko von Wegerer on 03.11.21.
//

import Foundation

struct PhotoModel: Codable {
    let albumID: Int?
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
