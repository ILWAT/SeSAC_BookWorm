//
//  BookCollectionViewCell.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "BookCollectionViewCell"
    
    let colorSet: [UIColor] = [.green, .systemGray2, .purple, .cyan, .systemMint, .magenta, .orange]

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var contentRateLabel: UILabel!
    
    var likeState: Bool = false

    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - setCellUI
    func setCellUI(_ data: Book){
        contentTitleLabel.text = data.title
        contentTitleLabel.setLabelColorWhite(true, false)
        
        let url = URL(string: data.thumbnail)
        contentImgView.kf.setImage(with: url)
        
        contentRateLabel.setLabelColorWhite(false, true)
        contentRateLabel.text = "\(data.contents)"
        
        //button의 isSelected를 활용하는 방식
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeButton.isSelected = data.like
        
        self.backgroundColor = colorSet.randomElement() ?? .clear
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    //MARK: - IBAction
    @IBAction func tappedLikeButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        MovieData.movie[self.tag].like = sender.isSelected
    }
    
    
    //MARK: - Helper
    //State에 따라 버튼의 이미지를 변경
//    func setLikeState(_ likeState: Bool){
//        if likeState{
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//
//        } else{
//            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        }
//    }
    

}
