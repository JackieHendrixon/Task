//
//  NetworkClient.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient{
    
    //MARK: - Instance
    
    static let instance: NetworkingClient = NetworkingClient()
    
    // MARK: - Fetching functions
    
    func fetchVoivodeship(completion: @escaping ([VoivodeshipModel]?) -> () )  {
        var result: [VoivodeshipModel]?
        Alamofire.request("http://sirocco.home.pl/apkftp/testy/ios/jsons/regions").responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do{
                        result = try JSONDecoder().decode([VoivodeshipModel].self, from: data)
                        completion(result)
                    }
                    catch let error as NSError{
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCities(completion: @escaping ([CityModel]?) -> () )  {
        var result: [CityModel]?
        Alamofire.request("http://sirocco.home.pl/apkftp/testy/ios/jsons/cities?region_id=1").responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do{
                        result = try JSONDecoder().decode([CityModel].self, from: data)
                        completion(result)
                    }
                    catch let error as NSError{
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> () ){
        Alamofire.request(url).responseData { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    let result = UIImage(data: data)
                    completion(result)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
