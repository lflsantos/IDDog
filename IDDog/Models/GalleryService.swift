//
//  GalleryService.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

class GalleryService{
    
    func fetchFeed(category: String, _ callback: @escaping ([String]) -> Void){
        guard let url = URL(string: "https://iddog-api.now.sh/feed?category=\(category)") else {
            print("Error creating Login URL")
            return
        }
        var feedRequest = URLRequest(url: url)
        feedRequest.httpMethod = "GET"
        feedRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        feedRequest.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: feedRequest) {data, response, error in
            guard let data = data, error == nil else{
                print(error!)
                return
            }
            
            guard let responseObject = self.parseJSON(data: data) else{
                return
            }
            
            callback(responseObject.list)
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> GalleryResponse?{
        do{
            return try JSONDecoder().decode(GalleryResponse.self, from: data)
        } catch let jsonError{
            print("ERROR. Could not parse json. \(jsonError)")
            return nil
        }
    }
}
