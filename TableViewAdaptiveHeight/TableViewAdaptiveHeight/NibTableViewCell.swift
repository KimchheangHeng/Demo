//
//  NibTableViewCell.swift
//  TableViewAdaptiveHeight
//
//  Created by 星宇陈 on 15/1/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class NibTableViewCell: UITableViewCell {
  
  @IBOutlet weak var bodyLabel: UILabel!
  
  var label = UILabel()
  
  var didLayout = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    println("awakeFromNib")
  }
  required init(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
    
    println("aDecoder")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    //    self.bodyLabel.text = "sdfsdfsf"
    
    label.setTranslatesAutoresizingMaskIntoConstraints(false)
    label.numberOfLines = 0
    
    self.contentView.addSubview(label)
    
    //    label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida, felis orci dictum risus, sed sodales sem eros eget risus. Morbi imperdiet sed diam et sodales. Vestibulum ut est id mauris ultrices gravida. Nulla malesuada metus ut erat malesuada, vitae ornare neque semper. Aenean a commodo justo, vel placerat odio. Curabitur vitae consequat tortor. Aenean eu magna ante. Integer tristique elit ac augue laoreet, eget pulvinar lacus dictum. Cras eleifend lacus eget pharetra elementum. Etiam fermentum eu felis eu tristique. Integer eu purus vitae turpis blandit consectetur. Nulla facilisi. Praesent bibendum massa eu metus pulvinar, quis tristique nunc commodo. Ut varius aliquam elit, a tincidunt elit aliquam non. Nunc ac leo purus. Proin condimentum placerat ligula, at tristique neque scelerisque ut. Suspendisse ut congue enim. Integer id sem nisl. Nam dignissim, lectus et dictum sollicitudin, libero augue ullamcorper justo, nec consectetur dolor arcu sed justo. Proin rutrum pharetra lectus, vel gravida ante venenatis sed. Mauris lacinia urna vehicula felis aliquet venenatis. Suspendisse non pretium sapien. Proin id dolor ultricies, dictum augue non, euismod ante. Vivamus et luctus augue, a luctus mi. Maecenas sit amet felis in magna vestibulum viverra vel ut est. Suspendisse potenti. Morbi nec odio pretium lacus laoreet volutpat sit amet at ipsum. Etiam pretium purus vitae tortor auctor, quis cursus metus vehicula. Integer ultricies facilisis arcu, non congue orci pharetra quis. Vivamus pulvinar ligula neque, et vehicula ipsum euismod quis."
    
    
    
    println("reuseIdentifier")
  }
  
  override func updateConstraints() {
    
    if !didLayout {
      
      let padding = UIEdgeInsetsMake(10, 100, 10, 50)

      label.snp_makeConstraints { make in
        make.top.equalTo(self.contentView.snp_top).with.offset(padding.top) // with is an optional semantic filler
        make.left.equalTo(self.contentView.snp_left).with.offset(padding.left)
        make.bottom.equalTo(self.contentView.snp_bottom).with.offset(-padding.bottom)
        make.right.equalTo(self.contentView.snp_right).with.offset(-padding.right)
      }
      
//      UIView.autoSetPriority(1000) {
//        self.label.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
//        self.label.autoSetContentCompressionResistancePriorityForAxis(.Vertical)
//      }
      
//      label.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
//      label.autoPinEdgeToSuperviewEdge(.Leading, withInset: 50)
//      label.autoPinEdgeToSuperviewEdge(.Trailing, withInset: 50)
//      label.autoPinEdgesToSuperviewEdgesWithInsets(padding)
      
      // This constraint is an inequality so that if the cell is slightly taller than actually required, extra space will go here
//      label.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 10.0, relation: .GreaterThanOrEqual)
//      
//      bodyLabel.autoPinEdgeToSuperviewEdge(.Leading, withInset: kLabelHorizontalInsets)
//      bodyLabel.autoPinEdgeToSuperviewEdge(.Trailing, withInset: kLabelHorizontalInsets)
//      bodyLabel.autoPinEdgeToSuperviewEdge(.Bottom, withInset: kLabelVerticalInsets)
      
      didLayout = true
      
    }
    
    super.updateConstraints()
    
  }
  
}
