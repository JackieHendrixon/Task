//
//  PageContentViewModel.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PlaceViewModel {
    
    private var place: PlaceModel
    var description: String
    var image: UIImage? {
        didSet{
            self.delegate?.refreshViews()
        }
    }
    var delegate: PlaceViewModelDelegate?
    init(place: PlaceModel) {
        self.place = place
        self.description = place.description
        NetworkingClient.instance.fetchImage(from: place.icon) {
            self.image = $0
        }
    }
}

protocol PlaceViewModelDelegate{
    func refreshViews()
}


