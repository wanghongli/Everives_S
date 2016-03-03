//
//  CWSReadPolicyView.h
//  测试demo
//
//  Created by 李散 on 15/9/24.
//  Copyright © 2015年 cheweishi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CWSReadPolicyViewDelegate <NSObject>

- (void)readPolicyViewTochDown:(BOOL)readOrPolicy;
- (void)readPolicyViewTurnToPolicyVC;
@end
@interface CWSReadPolicyView : UIView

@property (nonatomic, assign) id<CWSReadPolicyViewDelegate>delegate;

@end
