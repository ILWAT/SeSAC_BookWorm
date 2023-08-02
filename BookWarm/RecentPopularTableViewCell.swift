//
//  RecentPopularTableViewCell.swift
//  BookWarm
//
//  Created by 문정호 on 2023/08/02.
//

import UIKit

class RecentPopularTableViewCell: UITableViewCell {
    static let identifier = "RecentPopularTableViewCell"

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentDescriptionLabel: UILabel!
    @IBOutlet weak var contentTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(data: Movie){
        contentImageView.image = data.image
        contentImageView.layer.cornerRadius = 10
        
        contentTitleLabel.text = data.title
        contentTitleLabel.font = .systemFont(ofSize: 17)
        
        contentDescriptionLabel.text = "\(data.releaseDate) | \(data.runtime)분"
        contentDescriptionLabel.font = .systemFont(ofSize: 15)
        contentDescriptionLabel.textColor = .systemGray
    }
    
}
