//
//  PlaceModel.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import Foundation

struct PlaceModel: Decodable {
    let description: String
    let icon: URL
    
    enum CodingKeys: String, CodingKey {
        case description = "desc"
        case icon
    }
}
