//
//  YRPictureModel.h
//  Everives_S
//
//  Created by darkclouds on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRPictureModel : NSObject
/**
 *  {
 "url": "123",
 "intro": "Thisispics",
 }
 */
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *intro;
@end
