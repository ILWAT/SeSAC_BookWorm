//
//  ViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit
import Kingfisher
import RealmSwift

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
    
    var bookData: Book!
    var bookRealmData: RealmBookModel!
    
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try realm = Realm()
            print(realm.configuration.fileURL)
        } catch let error{
            print("Failed Create Realm",error)
        }
        
        print(bookData, bookRealmData)
        
        if let bookData {
            setUI_Book()
        } else if let bookRealmData {
            setUI()
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonClicked))
        
    }

    func setUI(){
//        let data: Movie = MovieData.movie[currentIndexPath]
        
        //네비게이션 타이틀 설정
        self.title = bookRealmData.title
        
        //하단 백그라운드 뷰 모서리 둥글게 설정
        bottomBackgroundView.layer.cornerRadius = 10
        bottomBackgroundView.layer.borderWidth = 1
        bottomBackgroundView.layer.borderColor = UIColor.black.cgColor
        
        //타이틀라벨 설정
        titleLabel.text = bookRealmData.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        //이미지 설정
//        ImgView.image = data.image ?? UIImage().withTintColor(.systemGray)
        let url = URL(string: bookRealmData.thumnail)
        ImgView.kf.setImage(with: url)
        
        //부가정보라벨 설정
        descriptionLabel.text = "판매 가격: \(bookRealmData.salePrice)원" //"\(data.runtime)분 | \(data.releaseDate)"
        descriptionLabel.font = .systemFont(ofSize: 15)
        
        //별점 라벨 설정
        rateLabel.text = "" //"\(data.rate)"
        rateLabel.font = .systemFont(ofSize: 15)
        
        //버튼 설정
        LikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        LikeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        LikeButton.isSelected = bookRealmData.like
    
        //핵심 내용 설정
        summaryTextView.text = bookRealmData.contents
        summaryTextView.isEditable = false
        
        //메모 텍스트뷰 딜리게이트 설정
        memoTextView.delegate = self
        setTextFieldPlaceHoder(textView: memoTextView)

    }
    
    func setUI_Book(){
        guard let book = bookData else { return }
        //네비게이션 타이틀 설정
        self.title = book.title

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
            
            let newRealmData = RealmBookModel(value: ["_id": bookRealmData._id, "like": LikeButton.isSelected])
            
            do{
                try realm.write({
                    realm.add(newRealmData, update: .modified)
                })
            } catch let error{
                print("Failed Update",error)
            }
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
    
    @objc func editButtonClicked(_ sender: UIBarButtonItem){
        updateMemoRealmData()
        
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    //MARK: - Helper
    func updateMemoRealmData(){
        guard let bookRealmData else {return}
        guard let inputText = memoTextView.text else {return}
        
        let updateRealmData = RealmBookModel(value: ["_id": bookRealmData._id, "memo": inputText])
        print(bookRealmData)
        
        do{
            try realm.write{
                realm.add(updateRealmData, update: .modified)
            }
        } catch let error{
            print("Failed Update",error)
        }
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
