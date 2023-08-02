//
//  RecentLookCollectionViewCell.swift
//  BookWarm
//
//  Created by 문정호 on 2023/08/02.
//

import UIKit

class RecentLookCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentLookCollectionViewCell"

    @IBOutlet weak var contentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUI(data: Movie?){
        guard let data else {
            contentImageView.isHidden = true
            return
        }
        if contentImageView.isHidden { contentImageView.isHidden = !contentImageView.isHidden }
        contentImageView.image = data.image
        contentImageView.layer.cornerRadius = 10
    }

}
