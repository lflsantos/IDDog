//
//  LoginService.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation


class LoginService {
    
    //MARK: - Login
    func login(email: String, _ callback: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://iddog-api.now.sh/signup") else {
            print("Error creating Login URL")
            return
        }
        
        var loginRequest = URLRequest(url: url)
        loginRequest.httpMethod = "POST"
        loginRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let user = User(email: email)
        let encodedUser = try? JSONEncoder().encode(user)
        loginRequest.httpBody = encodedUser
        
        let task = URLSession.shared.dataTask(with: loginRequest) {(data, response, error) in
            guard let data = data, error == nil else{
                print(error!)
                return
            }
            
            let responseObject = self.parseJSON(data: data)
            guard let responseToken = responseObject?.user.token else {
                callback(false)
                return
            }
            UserDefaults.standard.set(responseToken, forKey: "token")
            callback(true)
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> LoginResponse?{
        do{
            return try JSONDecoder().decode(LoginResponse.self, from: data)
        } catch let jsonError{
            print("ERROR. Could not parse json. \(jsonError)")
            return nil
        }
    }
    
    //MARK: - Images Download
    
}
