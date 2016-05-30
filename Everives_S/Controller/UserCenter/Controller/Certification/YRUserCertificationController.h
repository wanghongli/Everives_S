//
//  YRUserCertificationController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/5/30.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRUserCertificationController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *carIDtext;
- (IBAction)addCarIDImg:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *doneClick;
- (IBAction)addMsgClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
