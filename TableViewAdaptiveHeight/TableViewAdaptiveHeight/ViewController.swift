//
//  ViewController.swift
//  TableViewAdaptiveHeight
//
//  Created by 星宇陈 on 15/1/24.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

let CellIdentifier = "CellIdentifier"

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  var model = Model()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    model.populate()
    
    tableView.dataSource = self;
    tableView.rowHeight = UITableViewAutomaticDimension // 很重要!
    tableView.estimatedRowHeight = 44.0
//    tableView.registerClass(NibTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
    tableView.registerNib(UINib(nibName: "XibTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: CellIdentifier)
    
  }
}

extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return model.dataArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    
    if let NibCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? XibTableViewCell {
      
      println("XibTableViewCell")
      
      let modelItem = model.dataArray[indexPath.row]
      
      NibCell.label.text = modelItem.body
      
      NibCell.setNeedsUpdateConstraints()
      NibCell.updateConstraintsIfNeeded()
      
      return NibCell
    }
    
    return UITableViewCell()
  }
}

