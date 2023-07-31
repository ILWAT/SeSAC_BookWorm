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
    
}
