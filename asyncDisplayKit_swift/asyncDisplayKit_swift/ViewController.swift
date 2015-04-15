//
//  ViewController.swift
//  AsyncDisplayKitInSwift
//
//  Created by 星宇陈 on 4/15/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var cellVMs: [cellViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellVMs = dataCreator.createCellViewModels(10)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellVMs.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! pageCollectionViewCell
        let cellVM = cellVMs[indexPath.item]
        cell.configCell(cellVM)

        return cell
    }
    
}

