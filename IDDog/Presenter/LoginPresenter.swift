//
//  LoginPresenter.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

protocol LoginView: NSObjectProtocol{
    func startLoading()
    func finishLoading()
    func loginSuccessful()
    func errorOnLogin(message: String?)
}

class LoginPresenter {
    private weak var loginView: LoginView!
    private let service: APIService
    
    init(service: APIService){
        self.service = service
    }
    
    func attachView(_ view: LoginView){
        self.loginView = view
    }
    
    func login(email: String){
        self.loginView.startLoading()
        self.service.login(email: email){ (isLogged) -> Void in
            self.loginView.finishLoading()
            if(isLogged){
                self.loginView.loginSuccessful()
            } else {
                self.loginView.errorOnLogin(message: "Erro ao efetuar Login")
            }
        }
    }
}
