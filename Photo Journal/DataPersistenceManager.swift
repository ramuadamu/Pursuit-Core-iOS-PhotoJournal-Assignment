//
//  DataPersistingManager.swift
//  Photo Journal
//
//  Created by Ramu on 1/15/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
   
    
    // path to documents directory
    // "..../Documents"
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // file path using filename to documents directory
    // "....Documents/PhotoJournalList.plist
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
