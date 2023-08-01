//
//  ViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit

class DetailInfoViewController: UIViewController {
    var currentIndexPath = 0
    
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ImgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUI()
    }

    func setUI(){
        let data: Movie = MovieData.movie[currentIndexPath]
        
        //네비게이션 타이틀 설정
        self.navigationController?.title = data.title
        
        //하단 백그라운드 뷰 모서리 둥글게 설정
        bottomBackgroundView.layer.cornerRadius = 10
        bottomBackgroundView.layer.borderWidth = 1
        bottomBackgroundView.layer.borderColor = UIColor.black.cgColor
        
        //타이틀라벨 설정
        titleLabel.text = data.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        //이미지 설정
        ImgView.image = data.image ?? UIImage().withTintColor(.systemGray)
        
        //부가정보라벨 설정
        descriptionLabel.text = "\(data.runtime)분 | \(data.releaseDate)"
        descriptionLabel.font = .systemFont(ofSize: 15)
        
        //별점 라벨 설정
        rateLabel.text = "\(data.rate)"
        rateLabel.font = .systemFont(ofSize: 15)
        
        //버튼 설정
        LikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        LikeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        LikeButton.isSelected = data.like
        
        //핵심 내용 설정
        summaryTextView.text = data.overview
        summaryTextView.isEditable = false

    }
    
    @IBAction func tappedLikeButton(_ sender: UIButton) {
        LikeButton.isSelected = !LikeButton.isSelected
        MovieData.movie[currentIndexPath].like = sender.isSelected
    }
    
}

