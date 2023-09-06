//
//  FileManger+Extension.swift
//  BookWarm
//
//  Created by 문정호 on 2023/09/06.
//

import UIKit

extension UIViewController{
    
    func saveImageToDocument(fileName: String, image: UIImage){
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        guard let data = image.jpegData(compressionQuality: 0.3) else {return}
        
        do{
            try data.write(to: fileURL)
        } catch let error{
            print("failed File Write",error)
        }
    }
    
    
    func getImageFromDocument(fileName: String) -> UIImage{
        guard let directoryDoucment = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return UIImage(systemName: "book")!}
        
        let fileURL = directoryDoucment.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
        
    }
    
    func removeImageInDocument(fileName: String){
        guard let directoryDocument = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileURL = directoryDocument.appendingPathComponent(fileName)
        
        do{
            try FileManager.default.removeItem(atPath: fileURL.path)
        }catch let error{
            print("Failed remove Image", error)
        }
        
    }
}
