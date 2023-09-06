//
//  RealmManager.swift
//  BookWarm
//
//  Created by 문정호 on 2023/09/06.
//

import RealmSwift
import UIKit


class RealmMananger{
    private var realm: Realm!
    
    init() {
        do{
            try realm = Realm()
        } catch {
            print(error)
        }
    }
    
    ///DB에 검색 결과 저장하기
    func insertRealm(bookData: Book){
        let authorArray = bookData.author
        
        do{
            try realm.write{
                //작가 데이터 형식에 맞춰 변환
                let authorList = List<Author>()
                
                for author in authorArray{
                    let author = Author(name: author)
                    authorList.append(author)
                }
                
                //recod 생성
                let realmBookModel = RealmBookModel(author: authorList, thumnail: bookData.thumbnail, title: bookData.title, publisher: bookData.publisher, salePrice: bookData.salePrice, url: bookData.url, contents: bookData.contents, isbn: bookData.isbn, datetime: bookData.datetime)
                
                //table에 recod 추가
                realm.add(realmBookModel)
                
                print("realm Add Success")
            }
        } catch {
            print(error)
            
        }
    }
    
    func fetch() -> Results<RealmBookModel>{
        return realm.objects(RealmBookModel.self).sorted(byKeyPath: "title")
    }
    
    func updtaeRealmLikeData(bookRealmData: RealmBookModel, isSelected: Bool){
        do{
            try realm.write{
                realm.create(RealmBookModel.self,
                             value: ["_id": bookRealmData._id, "like": isSelected],
                             update: .modified)
            }
        } catch let error{
            print("Failed Update",error)
        }
    }
    
    func updateMemoRealmData(bookRealmData: RealmBookModel, memo: String){
        do{
            try realm.write{
                realm.create(RealmBookModel.self,
                             value: ["_id": bookRealmData._id, "memo": memo],
                             update: .modified)
            }
        } catch let error{
            print("Failed Update",error)
        }
    }
    
    func deleteRealm(bookRealmData: RealmBookModel) {
        do{
            try realm.write {
                realm.delete(bookRealmData)
            }
        } catch {
            print(error)
        }
        
    }
}
