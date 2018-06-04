//
//  GalleryViewController.swift
//  IDDog
//
//  Created by Lucas Santos on 03/06/18.
//  Copyright © 2018 Lucas Santos. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter = GalleryPresenter(service: GalleryService())
    private var huskyUrls: [String]?
    private var houndUrls: [String]?
    private var pugUrls: [String]?
    private var labradorUrls: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
        presenter.attachView(self)
        
        presenter.fetchImages(category: "husky")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showError(message: String){
        let alertController = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func switchedCategory(_ sender: UISegmentedControl) {
        presenter.fetchImages(category: sender.titleForSegment(at: sender.selectedSegmentIndex)!)
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            guard let count = huskyUrls?.count else{ return 0 }
            return count
        case 1:
            guard let count = houndUrls?.count else{ return 0 }
            return count
        case 2:
            guard let count = pugUrls?.count else{ return 0 }
            return count
        case 3:
            guard let count = labradorUrls?.count else{ return 0 }
            return count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension GalleryViewController: GalleryView{
    func startLoading() {
        self.activityIndicator.startAnimating()
        self.segmentedControl.isUserInteractionEnabled = false
    }
    
    func finishLoading() {
        self.activityIndicator.stopAnimating()
        self.segmentedControl.isUserInteractionEnabled = true
    }
    
    func setImages(_ imagesUrl: [String]) {
        self.imagesUrls = imagesUrl
        self.collectionView.reloadData()
    }
    
    func onErrorLoadingImages() {
        showError(message: "Erro ao carregar as imagens")
    }
    
    
}
