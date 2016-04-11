//
// YRSchoolAnnotationCalloutView.h
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YRSchoolAnnotationCalloutView : UIView
@property(nonatomic,strong) NSString *imageurl;
@property(nonatomic,strong) NSString *namestr;
@property(nonatomic,strong) NSString *scorestr;
@property(nonatomic,strong) NSString *addrstr;
@property(nonatomic,strong) NSString *distancestr;
-(void)buildUI;
@end
