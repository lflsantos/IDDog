//
//  GalleryPresenter.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import Foundation

protocol GalleryView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setImages(_ imagesUrl: [String])
    func onErrorLoadingImages()
}

class GalleryPresenter{
    private weak var view: GalleryView!
    private let service: GalleryService
    
    init(service: GalleryService){
        self.service = service
    }
    
    func attachView(_ view: GalleryView){
        self.view = view
    }
    
    func fetchImages(category: String){
        self.view.startLoading()
        self.service.fetchFeed(category: category){ imagesUrl -> Void in
            DispatchQueue.main.async {
                self.view.finishLoading()
                self.view.setImages(imagesUrl)
            }
            
        }
    }
}
