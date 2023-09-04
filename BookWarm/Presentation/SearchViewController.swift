//
//  SearchViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import RealmSwift

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    let placeHoderText = "검색할 내용을 입력해주세요"
    
//    var searchResult: [Movie] = []{
//        didSet{
//            collectionView.reloadData()
//        }
//    }
    
    var searchResult: [Book] = []
    
    //Realm으로 대체 해보기(과제)
    var task: Results<RealmBookModel>!
    
    var isEnd = false
    var page = 1
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "검색 화면"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(tappedClosedButton(_ :)))
        self.navigationItem.titleView = searchBar
        
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        setCollectionViewLayout()
        
        //Realm Code 추가
        let realm = try! Realm()
        
        task = try! realm.objects(RealmBookModel.self).sorted(byKeyPath: "title")
        
    }
    
    
    //MARK: - tappedClosedButton
    @objc func tappedClosedButton(_ sender: UIBarButtonItem){
        dismiss(animated: true)
    }
    
    func callRequest(query: String, page: Int){
        let query2 = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query2)&page=\(page)&size=30"
        
        let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKeys.kakaoAPIKey)"]
        
        let realm = try! Realm()
        
        AF.request(url, method: .get, headers: header).validate().responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                self.isEnd = json["meta"]["is_end"].boolValue
                
                for item in json["documents"].arrayValue{
                    var authorArray: [String] = []
                    for item2 in item["authors"].arrayValue{
                        authorArray.append(item2.stringValue)
                    }
                    let contents = item["contents"].stringValue
                    let datetime = item["datetime"].stringValue
                    let isbn = item["isbn"].stringValue
                    let price = item["price"].intValue
                    let publisher = item["publisher"].stringValue
                    let salePrice = item["sale_price"].intValue
                    let status = item["status"].stringValue
                    let thumbnail = item["thumbnail"].stringValue
                    let title = item["title"].stringValue
                    let url = item["url"].stringValue
                    let translator = item["translator"].stringValue
                    
                    self.searchResult.append(Book(author: authorArray, contents: contents, datetime: datetime, isbn: isbn, price: price, publisher: publisher, salePrice: salePrice, thumbnail: thumbnail, url: url, title: title, status: status, translator: translator, like: false))
                    
                    
                    //DB에 검색 결과 저장하기
                    try! realm.write{
                        //작가 데이터 형식에 맞춰 변환
                        var authorList = List<Author>()
                        for author in authorArray{
                            let author = Author(name: author)
                            authorList.append(author)
                        }
                        
                        //recod 생성
                        let realmBookModel = RealmBookModel(author: authorList, thumnail: thumbnail, title: title, publisher: publisher, salePrice: salePrice, url: url, contents: contents, isbn: isbn, datetime: datetime)
                        
                        //table에 recod 추가
                        realm.add(realmBookModel)
                        
                        print("realm Add Success")
                    }
                    
                }
                
//                print(self.searchResult)
                
                
                self.collectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
            
        }
    }

}


extension SearchViewController: UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    //MARK: - setCollectionViewLayout
    func setCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    //MARK: - numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }


    
    //MARK: - cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //UINib 인스턴스 생성
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: .main)
        
        //UINib CollectionViewController에 등록
        self.collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        //재사용 셀 인스턴스 생성
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        cell.tag = indexPath.row
        
        //셀 UI 생성
        cell.setCellUI(searchResult[indexPath.row])
        
        //셀 생성
        return cell
        
    }
    
    
    //MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = myStoryBoard.instantiateViewController(identifier: "DetailInfoViewController") as! DetailInfoViewController

        vc.currentIndexPath = indexPath.row
        vc.bookData = searchResult[indexPath.row]

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setSearchBarUI(){
        searchBar.placeholder = placeHoderText
        searchBar.showsCancelButton = true
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard let inputText = searchBar.text else {return}
//        searchResult.removeAll()
//        callRequest(query: inputText, page: page)
//    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputText = searchBar.text else {return}
        page = 1
        searchResult.removeAll()
        task = nil
        callRequest(query: inputText, page: page)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResult.removeAll()
        task = nil
        searchBar.text = ""
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print(indexPath)
            if searchResult.count-2 == indexPath.row && page<50 && !isEnd{
                page += 1
                callRequest(query: searchBar.text!, page: page)
                print("prefecth")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소")
    }
    
    
}
