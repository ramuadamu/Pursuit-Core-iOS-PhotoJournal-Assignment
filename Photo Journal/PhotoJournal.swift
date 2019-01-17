//
//  PhotoJournal.swift
//  Photo Journal
//
//  Created by Ramu on 1/15/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

final class PhotosJournalModel {
    private static let filename = "PhotoJournalList.plist"
    private init() {}
    
    
    
    private static var photos = [PhotoJournal]()
    
    static func getPhoto() -> [PhotoJournal] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    photos = try PropertyListDecoder().decode([PhotoJournal].self, from: data)
                } catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("data is nil")
            }
        } else {
            print("\(filename) does not exist")
        }
            photos = photos.sorted { $0.createdAt > $1.createdAt}
            return photos
        
            
            
        }
    
    
    static func save() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(photos)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding error: \(error)")
        }
    }
    

    static func addPhotos(photo: PhotoJournal) {
        photos.append(photo)
        save()
    }


}

