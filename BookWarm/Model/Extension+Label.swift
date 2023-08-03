//
//  Extension+Label.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import Foundation
import UIKit


extension UILabel{
    func setLabelColorWhite(_ bold: Bool, _ adjustFontSize: Bool){
        self.textColor = .white
        
        if bold {
            self.font = .boldSystemFont(ofSize: 20)
        } else {
            self.font = .systemFont(ofSize: 15)
        }
        
        if adjustFontSize {
            self.adjustsFontSizeToFitWidth = true
        } else {
            self.adjustsFontSizeToFitWidth = false
        }

    }
    
    func setDefaultTagUI(){
        self.isHidden = true
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 5
        self.layer.shadowRadius = 10
        self.textColor = .red
    }
    
}
