//
//  CollectionViewCell.m
//  collectionViewLayout
//
//  Created by 星宇陈 on 14/11/20.
//  Copyright (c) 2014年 Emiaostein. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CollectionViewCell

- (void)awakeFromNib {

    self.contentView.backgroundColor = [UIColor lightGrayColor];
    self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.contentView.layer.borderWidth = 2;
}

+ (UINib *)nib {
    
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (void)setImage {
    
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", @(arc4random()%19+1)]];
}


@end
