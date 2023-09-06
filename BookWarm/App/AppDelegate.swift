//
//  AppDelegate.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let config = Realm.Configuration(schemaVersion: 5) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.renameProperty(onType: RealmBookModel.className(), from: "thumnail", to: "thumbnail") //컬럼명 변경
            }
            
            if oldSchemaVersion < 2 { } //price 컬럼 추가
            
            if oldSchemaVersion < 3 { //discounted 컬럼 추가
                migration.enumerateObjects(ofType: RealmBookModel.className()) { oldObject, newObject in
                    guard let new = newObject else {return} //바뀌는 테이블
                    guard let old = oldObject else {return} //이전 테이블
                    
                    new["discountedPrice"] = (old["price"] as! Int) - (old["salePrice"] as! Int)
                }
            }
            
            if oldSchemaVersion < 4 { //한줄 책 정보, 평점 컬럼 생성 //다수 수정도 가능
                migration.enumerateObjects(ofType: RealmBookModel.className()) { oldObject, newObject in
                    guard let new = newObject else {return} //바뀌는 테이블
                    guard let old = oldObject else {return} //이전 테이블
                    
                    new["oneLineDescription"] = "책 제목: \(old["title"]) / 판매가격: \(old["salePrice"])"
                    
                    new["rate"] = 0
                }
            }
            
            if oldSchemaVersion < 5 { } //한줄 책정보 컬럼 삭제
            
            
        }
    
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

