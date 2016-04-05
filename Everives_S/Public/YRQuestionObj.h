//
//  YRQuestionObj.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YRQuestionObj : NSObject
@property (nonatomic, strong) NSString *analy;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *option;
@property (nonatomic, strong) NSString *pics;
@property (nonatomic, assign) NSInteger answer;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger error;
@property (nonatomic, assign) NSInteger collect;
@property (nonatomic, assign) NSInteger already;
@property (nonatomic, assign) NSInteger chooseAnswer;
@property (nonatomic, assign) NSInteger currentError; //0未做  1做对  2做错
@end
