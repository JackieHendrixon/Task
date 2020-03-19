//
//  File.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import Foundation

struct VoivodeshipModel{
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

extension VoivodeshipModel: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard let idInt = Int( try values.decode(String.self, forKey: .id)) else {
            fatalError("Id is not an Int")
        }
        id = idInt
        name = try values.decode(String.self, forKey: .name)
    }
}


