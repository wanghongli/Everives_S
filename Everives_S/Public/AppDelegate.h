//
//  AppDelegate.h
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/17.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,REFrostedViewControllerDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableDictionary *circleCacheDic;
@end

