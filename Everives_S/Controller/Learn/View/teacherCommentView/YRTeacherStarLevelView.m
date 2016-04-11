//
//  YRTeacherStarLevelView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherStarLevelView.h"
#import "YRStarLevelDetailView.h"

#define kDistace 20
@interface YRTeacherStarLevelView ()<YRStarLevelDetailViewDelegate>

@property (nonatomic, strong) UILabel *firstLabel;

@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UILabel *thirdLabel;

@property (nonatomic, strong) YRStarLevelDetailView *starView;

@property (nonatomic, strong) YRStarLevelDetailView *starView1;

@property (nonatomic, strong) YRStarLevelDetailView *starView2;
@end
@implementation YRTeacherStarLevelView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{
    UILabel *firstlabel = [[UILabel alloc]init];
    firstlabel.text = @"描述相符";
    firstlabel.textAlignment = NSTextAlignmentCenter;
    firstlabel.font = kFontOfSize(14);
    [self addSubview:firstlabel];
    _firstLabel = firstlabel;
    
    YRStarLevelDetailView *starView = [[YRStarLevelDetailView alloc]init];
    starView.delegate = self;
//    starView.tag = 10;
    [self addSubview:starView];
    _starView = starView;
    
    UILabel *secondlabel = [[UILabel alloc]init];
    secondlabel.text = @"教学质量";
    secondlabel.textAlignment = NSTextAlignmentCenter;
    secondlabel.font = kFontOfSize(14);
    [self addSubview:secondlabel];
    _secondLabel = secondlabel;
    YRStarLevelDetailView *starView1 = [[YRStarLevelDetailView alloc]init];
    starView1.delegate = self;
//    starView1.tag = 11;
    [self addSubview:starView1];
    _starView1 = starView1;
    
    UILabel *thirdlabel = [[UILabel alloc]init];
    thirdlabel.text = @"服务态度";
    thirdlabel.textAlignment = NSTextAlignmentCenter;
    thirdlabel.font = kFontOfSize(14);
    [self addSubview:thirdlabel];
    _thirdLabel = thirdlabel;
    YRStarLevelDetailView *starView2 = [[YRStarLevelDetailView alloc]init];
    starView2.delegate = self;
//    starView2.tag = 12;
    [self addSubview:starView2];
    _starView2 = starView2;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height = self.height/7;
    CGSize titleSize = [@"服务态度" sizeWithFont:kFontOfSize(14) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    _firstLabel.frame = CGRectMake(kDistace, height, titleSize.width, height);
    _starView.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+kDistace, _firstLabel.y, kScreenWidth - CGRectGetMaxX(_firstLabel.frame) - 2*kDistace, height);

    _secondLabel.frame = CGRectMake(kDistace, height*3, titleSize.width, height);
    _starView1.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+kDistace, _secondLabel.y, kScreenWidth - CGRectGetMaxX(_firstLabel.frame) - 2*kDistace, height);

    _thirdLabel.frame = CGRectMake(kDistace, height*5, titleSize.width, height);
    _starView2.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+kDistace, _thirdLabel.y, kScreenWidth - CGRectGetMaxX(_firstLabel.frame) - 2*kDistace, height);

}
-(void)starLevelDetailViewWhichStarClick:(NSInteger)starTag with:(YRStarLevelDetailView *)starView
{
    if ([starView isEqual:_starView]) {//描述相符
        MyLog(@"描述相符 - %ld",starTag);
    }else if ([starView isEqual:_starView1]) {//教学质量
        MyLog(@"教学质量 - %ld",starTag);
    }else if ([starView isEqual:_starView2]) {//服务态度
        MyLog(@"服务态度 - %ld",starTag);
    }
}
@end
