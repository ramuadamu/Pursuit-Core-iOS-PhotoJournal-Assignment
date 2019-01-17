//
//  ViewController.swift
//  Photo Journal
//
//  Created by Ramu on 1/14/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    private var imagePickerViewController: UIImagePickerController!
    private var photos = [PhotoJournal]() {
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosCollectionView.dataSource = self
        loadPhotosFromModel()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPhotosFromModel()
        photosCollectionView.reloadData()
        
    }
    
    private func loadPhotosFromModel() {
        self.photos = PhotosJournalModel.getPhoto()
    }
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "photoView") as! PhotoViewController
        viewController.modalPresentationStyle = .currentContext
        present(viewController, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.photoDate.text = photo.createdAt
        cell.photoDescription.text = photo.description
        cell.photoImageView.image = UIImage(data:photo.imageData )
        return cell
    }
    
    
}
