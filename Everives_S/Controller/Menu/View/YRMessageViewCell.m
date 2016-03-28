//
//  YRMessageViewCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMessageViewCell.h"

@implementation YRMessageViewCell


- (IBAction)btnClick:(UIButton *)sender {
    [self friendsStatusChange:sender.tag-11];
}
-(void)friendsStatusChange:(NSInteger)btnTag
{
    [RequestData POST:@"/student/friendRes" parameters:@{@"id":_messageObj.id,@"status":[NSString stringWithFormat:@"%ld",btnTag]} complete:^(NSDictionary *responseDic) {
        if (self.friendsStautsChange) {
            self.friendsStautsChange(YES);
        }
        if (btnTag) {
            [MBProgressHUD showSuccess:@"添加成功" toView:GET_WINDOW];
        }else{
            [MBProgressHUD showSuccess:@"已拒绝" toView:GET_WINDOW];
        }

    } failed:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败" toView:GET_WINDOW];

    }];
}
-(void)setFriendsArray:(NSArray *)friendsArray
{
    _friendsArray = friendsArray;
}
-(void)setMessageObj:(YRMessageObject *)messageObj
{
    _messageObj = messageObj;
    
    BOOL isFriend = NO;
    for (int i = 0; i<_friendsArray.count; i++) {
        YRMyFriendsObject *friends = _friendsArray[i];
        if (friends.id == messageObj.link) {
            isFriend = YES;
            break;
        }
    }
    if (isFriend) {//是朋友
        self.acceptBtn.hidden = YES;
        self.refuseBtn.hidden = YES;
        self.statusLabel.hidden = NO;
        self.statusLabel.text = @"已添加";
    }else{//不是朋友
        if (messageObj.type ==100) {//好友申请
            self.acceptBtn.hidden = NO;
            self.refuseBtn.hidden = NO;
            self.statusLabel.hidden = YES;

        }else{
            self.statusLabel.text = [NSString intervalSinceNow:messageObj.time];
            self.acceptBtn.hidden = YES;
            self.refuseBtn.hidden = YES;
            self.statusLabel.hidden = NO;
        }
    }
    self.contentLabel.text = messageObj.msg;
    
}
@end
