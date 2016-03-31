//
//  YRMyPracticeController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyPracticeController.h"
#import "XYPieChart.h"
@interface YRMyPracticeController ()<XYPieChartDelegate, XYPieChartDataSource>
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *numArray;
@property (nonatomic, strong) XYPieChart *pieChartView;

@property (nonatomic, strong) UILabel *currentState;
@end

@implementation YRMyPracticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"练习统计";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pieChartView];

    self.currentState.text = @"当前进度";
    [self.pieChartView reloadData];
}


-(NSArray *)colorArray
{
    if (_colorArray == nil) {
        _colorArray =[NSArray arrayWithObjects:
                        [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                        [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                        [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    }
    return _colorArray;
}
-(UILabel *)currentState
{
    if (_currentState == nil) {
        _currentState = [[UILabel alloc]initWithFrame:CGRectMake(0, self.pieChartView.y-30, kScreenWidth, 20)];
        _currentState.textAlignment = NSTextAlignmentCenter;
        _currentState.textColor = [UIColor grayColor];
        _currentState.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_currentState];
    }
    return _currentState;
}
-(NSArray *)numArray
{
    if (_numArray == nil) {
        _numArray = @[[NSNumber numberWithInteger:30],[NSNumber numberWithInteger:20],[NSNumber numberWithInteger:50]];
    }
    return _numArray;
}

-(XYPieChart *)pieChartView
{
    if (_pieChartView == nil) {
        _pieChartView = [[XYPieChart alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, kScreenWidth/3) Center:CGPointMake(kScreenWidth/6, kScreenWidth/6) Radius:kScreenWidth/6];
        _pieChartView.center = CGPointMake(kScreenWidth/2, 64+60+_pieChartView.height/2);
        [_pieChartView setDelegate:self];
        [_pieChartView setDataSource:self];
        [_pieChartView setShowPercentage:YES];
        [_pieChartView setLabelColor:[UIColor blackColor]];
        _pieChartView.userInteractionEnabled = NO;
    }
    return _pieChartView;
}
#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.numArray.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.numArray objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
//    if(pieChart == self.pieChartRight)
//        return nil;
    return [self.colorArray objectAtIndex:(index % self.colorArray.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %lu",(unsigned long)index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %lu",(unsigned long)index);
//    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.numArray objectAtIndex:index]];
}
@end
