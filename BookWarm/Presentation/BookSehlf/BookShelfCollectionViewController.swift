//
//  BookShelfCollectionViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit

class BookShelfCollectionViewController: UICollectionViewController {
    //MARK: - Properties
    
    
    //MARK: - properties
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionViewLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
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
    
    //MARK: - tappedSearchButton
    @IBAction func tappedSearchButton(_ sender: UIBarButtonItem) {
        let myStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = myStoryBoard.instantiateViewController(identifier: "SearchViewController")
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true)
    }
    
    
    //MARK: - numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieData.movie.count
    }


    
    //MARK: - cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //UINib 인스턴스 생성
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: .main)
        
        //UINib CollectionViewController에 등록
        self.collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        //재사용 셀 인스턴스 생성
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        
        cell.tag = indexPath.row
        
        //셀 UI 생성
//        cell.setCellUI(MovieData.movie[indexPath.row])
        
        //셀 생성
        return cell
        
    }
    
    
    //MARK: - didSelectItemAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //화면 전환  과제를 위해 변경
        let myStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = myStoryBoard.instantiateViewController(identifier: "DetailInfoViewController") as! DetailInfoViewController

        vc.currentIndexPath = indexPath.row

        self.navigationController?.pushViewController(vc, animated: true)
    }
}
