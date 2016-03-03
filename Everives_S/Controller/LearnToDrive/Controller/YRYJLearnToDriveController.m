//
//  YRYJLearnToDriveController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/18.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJLearnToDriveController.h"
#import "YRYJFirstClassController.h"
#import "YRYJSecondClassController.h"
#import "YRYJThirdClassController.h"
#import "YRYJFourthClassController.h"
#import "YRYJNavigationController.h"
@interface YRYJLearnToDriveController ()

@end

@implementation YRYJLearnToDriveController

//重载init方法
- (instancetype)init
{
    if (self = [super initWithTagViewHeight:49])
    {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tagItemSize = CGSizeMake(self.view.frame.size.width/4, 49);
    self.title = @"蚁人学车";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(YRYJNavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArray = @[
                            @"科目一",
                            @"科目二",
                            @"科目三",
                            @"科目四",
                            ];
    
    NSArray *classNames = @[
                            [YRYJFirstClassController class],
                            [YRYJSecondClassController class],
                            [YRYJThirdClassController class],
                            [YRYJFourthClassController class]
                            ];
    
    NSArray *params = @[
                        @"XBParamImage",
                        @"TableView",
                        @"CollectionView",
                        @"XBParamImage"
                        ];
    
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:params];
    
}


@end
