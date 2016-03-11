//
//  YRPullListView.h
//  Everives_S
//
//  Created by darkclouds on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRPullListView : UIView
@property(nonatomic,assign) CGFloat cellHeight;
@property(nonatomic,strong,readonly) NSMutableArray *selectedArray;
-(instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray*) array;
@end
