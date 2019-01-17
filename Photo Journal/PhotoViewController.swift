//
//  DetailViewController.swift
//  Photo Journal
//
//  Created by Ramu on 1/16/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoLibrary: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var imageDescription: UITextView!
    
    
    
    private var imagePickerViewcontroller: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()

       //updateUI()
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let text = imageDescription.text else {return}
    
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
        let modifiedTimestamp = isoDateFormatter.string(from: date)
        if let imageData = imageView.image?.jpegData(compressionQuality: 0.5) {
            let photoJournal = PhotoJournal.init(createdAt: modifiedTimestamp, imageData: imageData, description: text)
            PhotosJournalModel.addPhotos(photo: photoJournal)
        }
        dismiss(animated: true, completion: nil)
    }
    

    
    private func setupImagePickerViewController() {
        imagePickerViewcontroller = UIImagePickerController()
        imagePickerViewcontroller.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled = false
        }
}

    private func showImagePickerController() {
        present(imagePickerViewcontroller, animated: true, completion: nil)
}

    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewcontroller.sourceType = .photoLibrary
        showImagePickerController()
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePickerViewcontroller.sourceType = .camera
        showImagePickerController()
    }
    
    private func savePhotoJournal(image: UIImage) {
        // PhotoJournal: createdAt, description, imageData
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let photoJournal = PhotoJournal.init(createdAt: "no date", imageData: imageData, description: "cool wallpaper")
            PhotosJournalModel.addPhotos(photo: photoJournal)
        }
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Info dictionary of key and value(Image)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        } else {
            print("original image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
