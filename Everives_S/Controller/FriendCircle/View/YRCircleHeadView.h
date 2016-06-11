//
//  YRCircleHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRCircleHeadView : UIImageView
-(void)setUserMsgWithName:(NSString *)name gender:(BOOL)gender sign:(NSString *)sign;
@property (nonatomic, strong) NSString *headImgUrl;
@property (nonatomic, strong) UIImageView *imgView;
@end
