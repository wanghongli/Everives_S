//
//  KGFreshCatchDetailZanView.h
//  SkyFish
//
//  Created by 李洪攀 on 15/11/22.
//  Copyright © 2015年 SkyFish. All rights reserved.
//
@protocol KGFreshCatchDetailZanViewDelegate <NSObject>

-(void)zanViewWhichUserClick:(NSInteger)nubInt;

@end
#import <UIKit/UIKit.h>
@class KGFreshCatchCellFrame;
@interface KGFreshCatchDetailZanView : UIImageView
@property (nonatomic, assign) id<KGFreshCatchDetailZanViewDelegate>delegate;
@property (nonatomic,strong) NSArray *statusArray;

@end
