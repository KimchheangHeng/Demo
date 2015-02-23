//
//  SecondViewController.m
//  customTransation
//
//  Created by 星宇陈 on 12/13/14.
//  Copyright (c) 2014 Emiaostein. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)circleButtonClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
