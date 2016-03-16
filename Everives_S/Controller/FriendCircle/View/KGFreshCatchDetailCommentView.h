//
//  KGFreshCatchDetailCommentView.h
//  SkyFish
//
//  Created by 李洪攀 on 15/11/23.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRCircleComment.h"
@interface KGFreshCatchDetailCommentView : UIView
@property (strong, nonatomic) YRCircleComment *comment;
@property (nonatomic, assign) BOOL leftImgHidden;
//回复被点击
@property (nonatomic, strong) void (^replyTapClickBlock)(BOOL iconBool,YRCircleComment *user);

+(CGFloat)detailCommentViewWith:(YRCircleComment*)comment;
@end
