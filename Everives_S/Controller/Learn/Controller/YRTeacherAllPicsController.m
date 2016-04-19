//
//  YRTeacherAllPicsController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/19.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherAllPicsController.h"

@interface YRTeacherAllPicsController ()
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation YRTeacherAllPicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部照片";
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
}
-(void)getData
{
    [RequestData GET:[NSString stringWithFormat:@"/account/teacherPics/%ld",self.teacherID] parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        _picArray = [NSArray arrayWithArray:(NSArray *)responseDic];
        MyLog(@"%@",_picArray);
        [self buildUI];
    } failed:^(NSError *error) {
        
    }];
}
-(void)buildUI
{

}
@end
