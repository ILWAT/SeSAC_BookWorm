//
//  LookAroundViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController {

    @IBOutlet weak var recentLookCollectionView: UICollectionView!
    @IBOutlet weak var contentTableView: UITableView!
    
    var recentLookData: [Movie] = []{
        didSet{
            recentLookCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: RecentPopularTableViewCell.identifier, bundle: .main)
        contentTableView.register(nib, forCellReuseIdentifier: RecentPopularTableViewCell.identifier)
        
        contentTableView.dataSource = self
        contentTableView.delegate = self
        
        let nib2 = UINib(nibName: RecentLookCollectionViewCell.identifier, bundle: .main)
        recentLookCollectionView.register(nib2, forCellWithReuseIdentifier: RecentLookCollectionViewCell.identifier)
        
        recentLookCollectionView.dataSource = self
        recentLookCollectionView.delegate = self
        
        setrecentLookCollectionView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        recentLookCollectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print(#function)
        super.viewWillDisappear(animated)
    }
    
    func setrecentLookCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 150)
//        layout.minimumInteritemSpacing = 15 //아이템 사이의 간격 but, 한줄일때는 작동하지 않는 듯 함
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        recentLookCollectionView.collectionViewLayout = layout
        recentLookCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func chekRecentLookDataOverFlow(){
        if recentLookData.count == 10{
            recentLookData.remove(at: recentLookData.count-1)
        }
    }
    
    
}


extension LookAroundViewController:
    UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: - TableView
    
    //row의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieData.movie.count
    }
    
    //섹션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //각 셀에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentPopularTableViewCell.identifier) as! RecentPopularTableViewCell
        
        cell.setUI(data: MovieData.movie[indexPath.row])
        
        return cell
    }
    
    //각 셀의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    //셀을 선택했을때 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailInfoViewController") as! DetailInfoViewController
        
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.modalTransitionStyle = .coverVertical
        
        detailVC.currentIndexPath = indexPath.row
        
        recentLookData.insert(MovieData.movie[indexPath.row], at: 0)
        chekRecentLookDataOverFlow()
        
        self.present(detailVC, animated: true) {
            
        }
    }
    
    //MARK: - CollectionView

    //콜렉션 아이템의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentLookData.count
        
    }

    //각 아이템별 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentLookCollectionViewCell.identifier, for: indexPath) as! RecentLookCollectionViewCell

        cell.setUI(data: recentLookData[indexPath.row])

        return cell
    }
    
    
}
