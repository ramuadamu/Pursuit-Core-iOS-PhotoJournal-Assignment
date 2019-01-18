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
        
    }
    
    private func loadPhotosFromModel() {
        self.photos = PhotoJournalModel.getPhoto()
    }
    
    @IBAction func forShareButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "options", message: "make a selection", preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "edit", style: .default){_ in
            self.setView()
            print("clicked")
        }
        let delete = UIAlertAction(title: "delete", style: .destructive) { (action) in
           PhotoJournalModel.delete(index: sender.tag)
            self.loadPhotosFromModel()
            
        }
        let share = UIAlertAction(title: "share", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(share)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    func setView(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "photoView") as! PhotoViewController
        viewController.modalPresentationStyle = .currentContext
        present(viewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
       setView()
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
        cell.optionButton.tag = indexPath.row
        cell.photoImageView.image = UIImage(data:photo.imageData )
        return cell
    }
    
    
}
