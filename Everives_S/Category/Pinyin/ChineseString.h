//
//  ChineseString.h
//  Everives_S
//
//  Created by darkclouds on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PinYin.h"
#import "YRUserStatus.h"
@interface ChineseString : NSObject
@property(retain,nonatomic) NSString *string;
@property(retain,nonatomic) NSString *pinYin;
@property(nonatomic,strong) YRUserStatus *myFriend;

/**
 *  TableView右方IndexArray
 */
+(NSMutableArray *) IndexArray:(NSArray *) stringArr;

/**
 *  文本列表
 */
+(NSMutableArray *) LetterSortArray:(NSArray *)stringArr;

/**
 *返回一组字母排列数组(中英混排)
 */
+(NSMutableArray *) SortArray:(NSArray *)stringArr;

@end
