//
//  YRStudentAnnotationCalloutView.h
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YRStudentAnnotationCalloutView : UIView
@property(nonatomic,strong) NSString *imageurl;
@property(nonatomic,strong) NSString *namestr;
@property(nonatomic,strong) NSString *addrstr;
@property(nonatomic,strong) NSString *distancestr;
@property(nonatomic,strong) NSString *intro;
-(void)buildUI;
@end
