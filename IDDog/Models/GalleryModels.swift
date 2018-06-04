//
//  ImageModels.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

struct GalleryResponse: Decodable {
    let category: String
    let list: [String]
}
