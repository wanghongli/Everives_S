//
//  YRSharedDateArray.h
//  Everives_S
//
//  Created by darkclouds on 16/6/12.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRSharedDateArray : NSObject
+ (instancetype)sharedInstance;
- (void)setTimeArraysByArray:(NSArray*)array;
/**
 *  当前后台设置的实际有效时间
 */
@property(nonatomic,strong) NSArray *timeStartArray;
@property(nonatomic,strong) NSArray *timeEndArray;
@property(nonatomic,strong) NSArray *timeArray;
@property(nonatomic,strong) NSArray *timeArrayAllFact;//处理过后的全部时间
@property(nonatomic,strong) NSArray *timeNumArray;

/**
 *  所有时间相关
 */
@property(nonatomic,strong) NSArray *timeStartArrayAll;
@property(nonatomic,strong) NSArray *timeEndArrayAll;
@property(nonatomic,strong) NSArray *timeArrayAll;
@property(nonatomic,strong) NSArray *timeStartArrayAllFloat;
@property(nonatomic,strong) NSArray *timeEndArrayAllFloat;
@property(nonatomic,strong) NSArray *timeArrayAllFloat;
@end
