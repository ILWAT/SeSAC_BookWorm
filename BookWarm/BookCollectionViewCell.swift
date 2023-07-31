//
//  BookCollectionViewCell.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    let colorSet: [UIColor] = [.green, .systemGray2, .purple, .cyan, .systemMint, .magenta, .orange]

    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var contentRateLabel: UILabel!
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - setCellUI
    func setCellUI(_ data:Movie){
        contentTitleLabel.text = data.title
        
        contentImgView.image = data.image ?? UIImage(named: "Star")
        contentRateLabel.text = "\(data.rate)"
        
        
        contentRateLabel.setLabelColorWhite(false, true)
        contentTitleLabel.setLabelColorWhite(true, false)
        
        self.backgroundColor = colorSet.randomElement() ?? .clear
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

}
