//
//  YRReservationDetailVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationDetailVC.h"
#import "YRChatViewController.h"
@interface YRReservationDetailVC ()
@property (weak, nonatomic) IBOutlet UIButton *MsgOrCommentBtn;

@end

@implementation YRReservationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)MsgOrCommentBtnClick:(UIButton *)sender {
    YRChatViewController *conversationVC = [[YRChatViewController alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    conversationVC.targetId = @"stu16";
    conversationVC.title = @"王二狗";
    [self.navigationController pushViewController:conversationVC animated:YES];
}

@end
