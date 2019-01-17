//
//  PhotoJournalModel.swift
//  Photo Journal
//
//  Created by Ramu on 1/15/19.
//  Copyright © 2019 Ramu. All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
    let createdAt: String
    let imageData: Data
    let description: String
}
