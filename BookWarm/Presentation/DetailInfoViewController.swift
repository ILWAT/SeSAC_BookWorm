//
//  ViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit
import Kingfisher

class DetailInfoViewController: UIViewController {
    var currentIndexPath = 0
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ImgView: UIImageView!
    
    let TextViewPlaceHolder = "여기에 메모를 적어주세요."
    
    var bookData: Book? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if bookData != nil {
            setUI_Book()
        } else {
            setUI()
        }
        
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
        
        //메모 텍스트뷰 딜리게이트 설정
        memoTextView.delegate = self
        setTextFieldPlaceHoder(textView: memoTextView)

    }
    
    func setUI_Book(){
        guard let book = bookData else { return }
        //네비게이션 타이틀 설정
        self.navigationController?.title = book.title
        
        //하단 백그라운드 뷰 모서리 둥글게 설정
        bottomBackgroundView.layer.cornerRadius = 10
        bottomBackgroundView.layer.borderWidth = 1
        bottomBackgroundView.layer.borderColor = UIColor.black.cgColor
        
        //타이틀라벨 설정
        titleLabel.text = book.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        //이미지 설정
        let imageURL = URL(string: book.thumbnail)
        ImgView.kf.setImage(with: imageURL)
        
        //부가정보라벨 설정
        descriptionLabel.text = "출판사:\(book.publisher) | 판매 가격: \(book.salePrice)원"
        descriptionLabel.font = .systemFont(ofSize: 15)
        
        //별점 라벨 설정
        rateLabel.text = "\(book.datetime)"
        rateLabel.font = .systemFont(ofSize: 15)
        
        //버튼 설정
        LikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        LikeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        LikeButton.isSelected = book.like
    
        //핵심 내용 설정
        summaryTextView.text = book.contents
        summaryTextView.isEditable = false
        
        //메모 텍스트뷰 딜리게이트 설정
        memoTextView.delegate = self
        setTextFieldPlaceHoder(textView: memoTextView)

    }
    
    @IBAction func tappedLikeButton(_ sender: UIButton) {
        LikeButton.isSelected = !LikeButton.isSelected
        if bookData != nil {
            bookData?.like = LikeButton.isSelected
        } else {
            MovieData.movie[currentIndexPath].like = sender.isSelected
        }
        
    }

    @IBAction func tappedCancelButton(_ sender: UIButton) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    @IBAction func tappedGesture(_ sender: UITapGestureRecognizer) {
        self.memoTextView.endEditing(true)
    }
    
}

extension DetailInfoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == TextViewPlaceHolder{
            textView.text = ""
            textView.textColor = .black
        }
            
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        setTextFieldPlaceHoder(textView: textView)
    }

    func setTextFieldPlaceHoder(textView: UITextView){
        if textView.text.isEmpty {
            textView.text = TextViewPlaceHolder
            textView.textColor = .gray
        }
    }
}
