//
//  YRFeedBackController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRFeedBackController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
- (IBAction)sendClick:(UIButton *)sender;

@end
