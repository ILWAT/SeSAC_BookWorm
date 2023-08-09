//
//  SearchViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    
    let placeHoderText = "검색할 내용을 입력해주세요"
    
    var searchResult: [Movie] = []{
        didSet{
            collectionView.reloadData()
        }
    }
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
        
        setCollectionViewLayout()
    }
    
    
    //MARK: - tappedClosedButton
    @objc func tappedClosedButton(_ sender: UIBarButtonItem){
        dismiss(animated: true)
    }
    
    func callRequest(){
        
    }

}


extension SearchViewController: UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
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

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setSearchBarUI(){
        searchBar.placeholder = placeHoderText
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let inputText = searchBar.text else {return}
        searchResult.removeAll()
        for element in MovieData.movie{
            if element.title.contains(inputText) {
                searchResult.append(element)
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputText = searchBar.text else {return}
        for element in MovieData.movie{
            if element.title.contains(inputText) {
                searchResult.append(element)
            }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResult.removeAll()
        searchBar.text = ""
    }
}
