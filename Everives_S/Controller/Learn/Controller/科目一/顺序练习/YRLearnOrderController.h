//
//  YRLearnOrderController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRLearnOrderController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *totalNum;
@property (weak, nonatomic) IBOutlet UILabel *errorNum;
@property (weak, nonatomic) IBOutlet UILabel *completeNum;
@property (weak, nonatomic) IBOutlet UIButton *goOnBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
- (IBAction)btnClick:(UIButton *)sender;

@end
