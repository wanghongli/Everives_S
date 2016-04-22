//
//  YROrderPartnerModel.h
//  Everives_S
//
//  Created by darkclouds on 16/4/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YROrderPartnerModel : NSObject
/**
 *  avatar = "http://7xr6ql.com1.z0.glb.clouddn.com/9d156c902e017ae388aacc3712e86a46.jpg";
 id = 12;
 name = "\U738b\U4e8c\U72d7";
 */
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *name;
@end
