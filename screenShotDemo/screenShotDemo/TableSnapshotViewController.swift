//
//  TableSnapshotViewController.swift
//  screenShotDemo
//
//  Created by 星宇陈 on 15/3/4.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class TableSnapshotViewController: UITableViewController, SnapshotDelegate {
  
  var numbers = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
      for number in 1..<100 {
        
        numbers.append(number)
      }
    
      tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numbers.count
    }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
    cell.textLabel?.text = "\(numbers[indexPath.row])"
    
    return cell
  }
  
  
  
// snapshot for all cells
//  func snapshotForSpecialView() -> UIView {
//    let originContentOffSet = tableView.contentOffset
//    tableView.contentOffset = CGPointZero
//    
//    let scrollView = UIScrollView(frame: tableView.bounds)
//    scrollView.contentSize = tableView.contentSize
//    
//    let height = scrollView.bounds.height
//    let width = scrollView.bounds.width
//    
//    let remainer = tableView.contentSize.height % tableView.bounds.height
//    let times = Int((tableView.contentSize.height - remainer) / tableView.bounds.height)
//    var y = 0.0
//    var lastIndexPath: NSIndexPath!
//    
//    for _ in 0..<times {
//      let rect = CGRectMake(0, CGFloat(y), width, height)
//      tableView.scrollRectToVisible(rect, animated: false)
//      let indexPaths = tableView.indexPathsForRowsInRect(rect)
//      for indexPath in indexPaths {
//        let cell = tableView.cellForRowAtIndexPath(indexPath as NSIndexPath)!
//        let snap = cell.snapshotViewAfterScreenUpdates(true)
//        snap.frame = cell.frame;
//        scrollView.addSubview(snap)
//      }
//      y += Double(height)
//    }
//    
//    tableView.contentOffset = originContentOffSet
//    
//    return scrollView
//  }

//  snapshot for special cells
  func snapshotForSpecialView() -> UIView {
    let originContentOffSet = tableView.contentOffset
    tableView.contentOffset = CGPointZero
    
    let scrollView = UIScrollView(frame: tableView.bounds)
//    scrollView.contentSize = tableView.contentSize
    
    let height = scrollView.bounds.height
    let width = scrollView.bounds.width
    
    let remainer = tableView.contentSize.height % tableView.bounds.height
    let times = Int((tableView.contentSize.height - remainer) / tableView.bounds.height)
    
    let indexPathsFunc = {(numbers:Range<Int>) -> [NSIndexPath] in
      var array = [NSIndexPath]()
      
      for number in numbers {
        let indexPath = NSIndexPath(forRow: number, inSection: 0)
        array.append(indexPath)
      }
      
      return array
    }

//    let indexPaths = indexPathsFunc(20, 40, 60, 80, 91)
    let indexPaths = indexPathsFunc(20..<40)
    var y:CGFloat = 0.0
    
    for indexPath in indexPaths {
      
      let rect = tableView.rectForRowAtIndexPath(indexPath)
      println(rect)
      tableView.scrollRectToVisible(rect, animated: false)
      let cell = tableView.cellForRowAtIndexPath(indexPath)!
      let snap = cell.snapshotViewAfterScreenUpdates(true)
      scrollView.contentSize.height += snap.frame.height
      snap.frame.origin.y = y
      scrollView.addSubview(snap)
      
      y += snap.frame.height
      println(cell.textLabel?.text)
      
    }

    tableView.contentOffset = originContentOffSet
    
    return scrollView
  }
  
}
