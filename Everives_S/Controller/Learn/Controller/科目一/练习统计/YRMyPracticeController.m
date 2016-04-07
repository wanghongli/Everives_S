//
//  YRMyPracticeController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyPracticeController.h"
#import "XYPieChart.h"
#import "YRExamScorePercentView.h"
#import "YRMyPracticeView.h"
#import "YRFMDBObj.h"
@interface YRMyPracticeController ()<XYPieChartDelegate, XYPieChartDataSource>
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *numArray;
@property (nonatomic, strong) XYPieChart *pieChartView;

@property (nonatomic, strong) UILabel *currentState;
@property (nonatomic, strong) YRExamScorePercentView *scorePercentView;

@property (nonatomic, strong) YRMyPracticeView *myPracticeView;
@end

@implementation YRMyPracticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"练习统计";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pieChartView];
    [self setMsg];
   
}
-(void)setMsg{
    self.currentState.text = @"当前进度";
    
    NSArray *array = [YRFMDBObj getErrorAlreadyAndTotalQuestionWithType:self.objFour already:1];
    //未做过数量
    NSInteger firstInt = [array[0] integerValue] - [array[2] integerValue];
    //错题数
    NSInteger secondInt = [array[1] integerValue];
    //正确数
    NSInteger thirdInt = [array[2] integerValue] - [array[1] integerValue];
    
    int firstPercent = (int)firstInt*100/(thirdInt+secondInt+firstInt);
    int secondPercent = (int)secondInt*100/(thirdInt+secondInt+firstInt);
    int thridPercent = (int)thirdInt*100/(thirdInt+secondInt+firstInt);
    _numArray = @[[NSNumber numberWithInteger:firstPercent],[NSNumber numberWithInteger:secondPercent],[NSNumber numberWithInteger:thridPercent]];
    [self.pieChartView reloadData];
    
    int rightPercent;
    if (thirdInt+secondInt>0) {
        rightPercent = (int)thirdInt*100/(thirdInt+secondInt);
    }else
        rightPercent = 100;
        
    self.scorePercentView.headString = @"正确率";
    self.scorePercentView.scoreString =[NSString stringWithFormat:@"%d",rightPercent];
    
    self.myPracticeView = [[YRMyPracticeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scorePercentView.frame)+20, kScreenWidth, [YRMyPracticeView getHeight])];
    [self.view addSubview:self.myPracticeView];
    self.myPracticeView.msgArray = array;
}

-(NSArray *)colorArray
{
    if (_colorArray == nil) {
        _colorArray =[NSArray arrayWithObjects:
                        [UIColor lightGrayColor],
                        [UIColor redColor],
                        [UIColor greenColor],nil];
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

-(YRExamScorePercentView *)scorePercentView
{
    if (!_scorePercentView) {
        
        _scorePercentView = [[YRExamScorePercentView alloc]initWithFrame:CGRectMake(kScreenWidth/2-[YRExamScorePercentView getExamScorePercentViewHeight:@"99" withHeadString:@"正确率"]/2, CGRectGetMaxY(self.pieChartView.frame)+20, [YRExamScorePercentView getExamScorePercentViewHeight:@"99" withHeadString:@"正确率"], [@"99" sizeWithFont:kFontOfSize(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height)];
        [self.view addSubview:_scorePercentView];
        
    }
    return _scorePercentView;
}
@end
