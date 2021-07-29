//
//  ChatMessage.swift
//  ChatMessage
//
//  Created by Anton Novoselov on 29.07.2021.
//

import CloudKit

struct ChatMessage: Identifiable {
    let id: String
    let from: String
    let text: String
    let date: Date
    
    init(from record: CKRecord) {
        id = record.recordID.recordName
        from = record["from"] as? String ?? "No author"
        text = record["text"] as? String ?? "No text"
        date = record.creationDate ?? Date()
    }
}
