//
//  YREditUserController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YREditUserController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
- (IBAction)headBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UITextField *nickNameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextView *signText;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIView *manBack;
@property (weak, nonatomic) IBOutlet UIView *manCenter;
@property (weak, nonatomic) IBOutlet UIView *womenBack;
@property (weak, nonatomic) IBOutlet UIView *womenCenter;
- (IBAction)sexChoose:(UIButton *)sender;

- (IBAction)sureClick:(id)sender;

@end
