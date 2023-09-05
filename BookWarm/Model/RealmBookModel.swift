//
//  RealmModel.swift
//  BookWarm
//
//  Created by 문정호 on 2023/09/04.
//

import Foundation
import RealmSwift

class RealmBookModel: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var author: List<Author>
    @Persisted var thumnail: String
    @Persisted var title: String
    @Persisted var publisher: String
    @Persisted var salePrice: Int
    @Persisted var url: String
    @Persisted var status: String?
    @Persisted var translator: String?
    @Persisted var like: Bool
    @Persisted var contents: String
    @Persisted var isbn: String
    @Persisted var datetime: String
    @Persisted var memo: String?
    
    convenience init(author: List<Author>, thumnail: String, title: String, publisher: String, salePrice: Int, url: String, status: String? = nil, translator: String? = nil, contents: String, isbn: String, datetime: String) {
        self.init()
        
        self.author = author
        self.thumnail = thumnail
        self.title = title
        self.publisher = publisher
        self.salePrice = salePrice
        self.url = url
        self.status = status
        self.translator = translator
        self.contents = contents
        self.isbn = isbn
        self.datetime = datetime
        self.like = false
        self.memo = nil
    }
}

class Author: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String
    
    convenience init(name: String) {
        self.init()
        
        self.name = name
    }
}
