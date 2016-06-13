//
//  YRSharedDateArray.m
//  Everives_S
//
//  Created by darkclouds on 16/6/12.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSharedDateArray.h"
@interface YRSharedDateArray()
@end

@implementation YRSharedDateArray
+ (instancetype)sharedInstance
{
    static YRSharedDateArray *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YRSharedDateArray alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init{
    if(self = [super init]){
        _timeStartArrayAll = @[@"00:00",@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00"
                               ,@"08:00",@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00"
                               ,@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"];
        _timeEndArrayAll = @[@"01:00",@"02:00",@"03:00",@"04:00",@"05:00",@"06:00",@"07:00",@"08:00"
                             ,@"09:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00"
                             ,@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00"];
        _timeArrayAll = @[@"00:00-01:00",@"01:00-02:00",@"02:00-03:00",@"03:00-04:00",@"04:00-05:00",@"05:00-06:00"
                          ,@"06:00-07:00",@"07:00-08:00",@"08:00-09:00",@"09:00-10:00",@"10:00-11:00",@"11:00-12:00"
                          ,@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"
                          ,@"18:00-19:00",@"19:00-20:00",@"20:00-21:00",@"21:00-22:00",@"22:00-23:00",@"23:00-24:00"];
        _timeStartArrayAllFloat = @[@"00:30",@"01:30",@"02:30",@"03:30",@"04:30",@"05:30",@"06:30",@"07:30"
                               ,@"08:30",@"09:30",@"10:30",@"11:30",@"12:30",@"13:30",@"14:30",@"15:30"
                               ,@"16:30",@"17:30",@"18:30",@"19:30",@"20:30",@"21:30",@"22:30",@"23:30"];
        _timeEndArrayAllFloat = @[@"01:30",@"02:30",@"03:30",@"04:30",@"05:30",@"06:30",@"07:30",@"08:30"
                             ,@"09:30",@"10:30",@"11:30",@"12:30",@"13:30",@"14:30",@"15:30",@"16:30"
                             ,@"17:30",@"18:30",@"19:30",@"20:30",@"21:30",@"22:30",@"23:30",@"24:30"];
        _timeArrayAllFloat = @[@"00:30-01:30",@"01:30-02:30",@"02:30-03:30",@"03:30-04:30",@"04:30-05:30",@"05:30-06:30"
                          ,@"06:30-07:30",@"07:30-08:30",@"08:30-09:30",@"09:30-10:30",@"10:30-11:30",@"11:30-12:30"
                          ,@"12:30-13:30",@"13:30-14:30",@"14:30-15:30",@"15:30-16:30",@"16:30-17:30",@"17:30-18:30"
                          ,@"18:30-19:30",@"19:30-20:30",@"20:30-21:30",@"21:30-22:30",@"22:30-23:30",@"23:30-24:30"];
    }
    return self;
}
-(void)setTimeArraysByArray:(NSArray *)array{
    NSMutableArray *ts = @[].mutableCopy;
    NSMutableArray *te = @[].mutableCopy;
    NSMutableArray *t = @[].mutableCopy;
    NSMutableArray *ta = _timeArrayAll.mutableCopy;
    NSMutableArray *tn = @[].mutableCopy;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (fabs([obj doubleValue]-[obj integerValue])>0.4) {//2.5  3.5之类 浮点数的比较不能直接用相等
            [ts addObject:_timeStartArrayAllFloat[[obj integerValue]]];
            [te addObject:_timeEndArrayAllFloat[[obj integerValue]]];
            [t addObject:_timeArrayAllFloat[[obj integerValue]]];
            ta[[obj integerValue]] = _timeArrayAllFloat[[obj integerValue]];
            [tn addObject:[NSString stringWithFormat:@"%.1f",[obj doubleValue]]];
        }else{//1  2  3之类
            [ts addObject:_timeStartArrayAll[[obj integerValue]]];
            [te addObject:_timeEndArrayAll[[obj integerValue]]];
            [t addObject:_timeArrayAll[[obj integerValue]]];
            [tn addObject:[NSString stringWithFormat:@"%li",[obj integerValue]]];
        }
    }];
    
    _timeStartArray = ts.copy;
    _timeEndArray = te.copy;
    _timeArray = t.copy;
    _timeNumArray = tn.copy;
    _timeArrayAllFact = ta.copy;
}
@end
