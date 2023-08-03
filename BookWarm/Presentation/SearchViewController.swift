//
//  SearchViewController.swift
//  BookWarm
//
//  Created by 문정호 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "검색 화면"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(tappedClosedButton(_ :)))
    }
    
    
    //MARK: - tappedClosedButton
    @objc func tappedClosedButton(_ sender: UIBarButtonItem){
        dismiss(animated: true)
    }

}
