//
//  BookShelfCollectionViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit

class BookShelfCollectionViewController: UICollectionViewController {
    //MARK: - Properties
    let movieList = MovieData()
    
    
    //MARK: - properties
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        setCollectionViewLayout()
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
        return movieList.movie.count
    }


    
    //MARK: - cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        
        cell.setCellUI(movieList.movie[indexPath.row])
        
        return cell
        
    }
    
    
    //MARK: - didSelectItemAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = myStoryBoard.instantiateViewController(identifier: "DetailInfoViewController") as! DetailInfoViewController
        vc.title = movieList.movie[indexPath.row].title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
