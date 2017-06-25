//
//  ViewController.swift
//  collectionDemo+
//
//  Created by liuhang on 17/6/25.
//  Copyright © 2017年 liuhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40, height: 40)
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.green
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseIdentifier")
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK 初始化UI
    private func setupUI() {
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
    }
    //MARK collectionDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
}
