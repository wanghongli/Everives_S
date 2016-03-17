//
//  SchoolDataSource.h
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SchoolDataSource : NSObject<UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
-(void)getData;
@end
