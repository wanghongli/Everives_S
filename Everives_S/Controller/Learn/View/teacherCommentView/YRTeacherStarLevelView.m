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

@property (nonatomic, strong) UILabel *fourLabel;

@property (nonatomic, strong) YRStarLevelDetailView *starView;

@property (nonatomic, strong) YRStarLevelDetailView *starView1;

@property (nonatomic, strong) YRStarLevelDetailView *starView2;

@property (nonatomic, strong) YRStarLevelDetailView *starView3;
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
    firstlabel.text = @"车容车貌";
    firstlabel.textAlignment = NSTextAlignmentCenter;
    firstlabel.font = kFontOfSize(14);
    firstlabel.textColor = kCOLOR(60, 63, 62);
    [self addSubview:firstlabel];
    _firstLabel = firstlabel;
    
    YRStarLevelDetailView *starView = [[YRStarLevelDetailView alloc]init];
    starView.delegate = self;
//    starView.tag = 10;
    [self addSubview:starView];
    _starView = starView;
    
    UILabel *secondlabel = [[UILabel alloc]init];
    secondlabel.text = @"教学质量";
    secondlabel.textColor = kCOLOR(60, 63, 62);
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
    thirdlabel.textColor = kCOLOR(60, 63, 62);
    thirdlabel.textAlignment = NSTextAlignmentCenter;
    thirdlabel.font = kFontOfSize(14);
    [self addSubview:thirdlabel];
    _thirdLabel = thirdlabel;
    
    YRStarLevelDetailView *starView2 = [[YRStarLevelDetailView alloc]init];
    starView2.delegate = self;
    [self addSubview:starView2];
    _starView2 = starView2;
    
    UILabel *fourlabel = [[UILabel alloc]init];
    fourlabel.text = @"满时教学";
    fourlabel.textColor = kCOLOR(60, 63, 62);
    fourlabel.textAlignment = NSTextAlignmentCenter;
    fourlabel.font = kFontOfSize(14);
    [self addSubview:fourlabel];
    _fourLabel = fourlabel;
    
    YRStarLevelDetailView *starView3 = [[YRStarLevelDetailView alloc]init];
    starView3.delegate = self;
    [self addSubview:starView3];
    _starView3 = starView3;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height = self.height/6.5;
    CGSize titleSize = [@"服务态度" sizeWithFont:kFontOfSize(14) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    _firstLabel.frame = CGRectMake(kDistace, height/2, titleSize.width, height);
    _starView.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+kDistace, _firstLabel.y, kScreenWidth - CGRectGetMaxX(_firstLabel.frame) - 2*kDistace, height);

    _secondLabel.frame = CGRectMake(kDistace, height*2, titleSize.width, height);
    _starView1.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+kDistace, _secondLabel.y, kScreenWidth - CGRectGetMaxX(_firstLabel.frame) - 2*kDistace, height);

    _thirdLabel.frame = CGRectMake(kDistace, height*3.5, titleSize.width, height);
    _starView2.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+kDistace, _thirdLabel.y, kScreenWidth - CGRectGetMaxX(_firstLabel.frame) - 2*kDistace, height);
    
    _fourLabel.frame = CGRectMake(kDistace, height*5, titleSize.width, height);
    _starView3.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame)+kDistace, _fourLabel.y, kScreenWidth - CGRectGetMaxX(_firstLabel.frame) - 2*kDistace, height);

}
-(void)starLevelDetailViewWhichStarClick:(NSInteger)starTag with:(YRStarLevelDetailView *)starView
{
    NSString *menu;
    if ([starView isEqual:_starView]) {//车容车貌
        menu = @"describe";
        MyLog(@"描述相符 - %ld",starTag);
    }else if ([starView isEqual:_starView1]) {//教学质量
        MyLog(@"教学质量 - %ld",starTag);
        menu = @"quality";
    }else if ([starView isEqual:_starView2]) {//服务态度
        MyLog(@"服务态度 - %ld",starTag);
        menu = @"attitude";
    }else if ([starView isEqual:_starView3]){//满时教学
        menu = @"teachTime";
    }
    [self.delegate teacherStarLevelMenu:menu starLevel:starTag];
}
-(void)setQualityInt:(NSInteger)qualityInt
{
    _qualityInt = qualityInt;
    _starView1.starNum = qualityInt;
}
-(void)setAttitudeInt:(NSInteger)attitudeInt
{
    _attitudeInt = attitudeInt;
    _starView2.starNum = attitudeInt;
}
-(void)setDescribeInt:(NSInteger)describeInt
{
    _describeInt = describeInt;
    _starView.starNum = describeInt;

}
-(void)setTeachTime:(NSInteger)teachTime
{
    _teachTime = teachTime;
    _starView3.starNum = teachTime;
}

@end
