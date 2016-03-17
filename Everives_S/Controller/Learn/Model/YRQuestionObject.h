//
//  YRQuestionObject.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YRQuestionObject : NSObject

@property (nonatomic, strong) NSString *analy;
@property (nonatomic, assign) NSInteger answer;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, strong) NSArray *option;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, assign) NSInteger type;

@end
