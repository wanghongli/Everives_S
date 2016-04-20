//
//  YRCoachDataSource.h
//  Everives_S
//
//  Created by darkclouds on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachDataSource : NSObject<UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong)  NSMutableArray *coachArray;
-(void)getDataWithParameters:(NSDictionary*)parameters;
-(void)loadMoreData;
@end
