//
//  YRCircleCellViewModel.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YRWeibo;
@interface YRCircleCellViewModel : NSObject
/**
 *  微博数据
 */
@property (nonatomic, strong) YRWeibo *status;


// 顶部视图frame
@property (nonatomic, assign) CGRect originalViewFrame;

/**   ******顶部视图子空间控件frame**** */
// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect originalPhotosFrame;

// 工具条frame
@property (nonatomic, assign) CGRect toolBarFrame;



// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
