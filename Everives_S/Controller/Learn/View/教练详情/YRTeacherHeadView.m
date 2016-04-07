//
//  YRTeacherHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherHeadView.h"
#import "UIImageView+WebCache.h"

#import "YRNameSexView.h"
#import "YRStarView.h"
#import "YRMenuView.h"
@interface YRTeacherHeadView ()

@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) YRNameSexView *nameLabel;
@property (nonatomic, weak) YRStarView *starView;
@property (nonatomic, weak) YRMenuView *menuView;
@end

@implementation YRTeacherHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"background_1"];
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{

    UIImageView *imgview = [[UIImageView alloc]init];
    [self addSubview:imgview];
    _headImg = imgview;
    
    YRNameSexView *namelabel = [[YRNameSexView alloc]init];
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    YRStarView *startview = [[YRStarView alloc]init];
    [self addSubview:startview];
    _starView = startview;
    
    YRMenuView *menuview = [[YRMenuView alloc]init];
    [self addSubview:menuview];
    _menuView = menuview;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
//    _starView.frame = CGRectMake(0, self.height-50, [YRStarView getStarViewWight], 20);
//    _starView.center = CGPointMake(kScreenWidth/2, _starView.center.y);
//    _starView.starNu = 3;
//    
//    _nameLabel.frame = CGRectMake(0, _starView.y - 20, kScreenWidth, [@"罗纳尔多" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)].height);
////    [_nameLabel nameWith:@"罗拉尔多" sex:1];
//    
//    _headImg.frame = CGRectMake(0, (self.height - 70)*0.3/2+5, (self.height - 70)*0.7, (self.height - 70)*0.7);
////    _headImg.image = [UIImage imageNamed:@"head_jiaolian"];
//    _headImg.center = CGPointMake(kScreenWidth/2, _headImg.center.y);
//    _headImg.layer.masksToBounds = YES;
//    _headImg.layer.cornerRadius = _headImg.height/2;
//    
//    _menuView.frame = CGRectMake(0, CGRectGetMaxY(_starView.frame)+5, kScreenWidth, 20);
////    _menuView.menuArray = @[@"7年",@"科二",@"122人"];
}
-(void)setTeacherObj:(YRTeacherDetailObj *)teacherObj
{
    _teacherObj = teacherObj;
    _starView.frame = CGRectMake(0, self.height-50, [YRStarView getStarViewWight], 20);
    _starView.center = CGPointMake(kScreenWidth/2, _starView.center.y);
    _starView.starNu = [teacherObj.grade integerValue];
    
    _nameLabel.frame = CGRectMake(0, _starView.y - 20, kScreenWidth, [teacherObj.name sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)].height);
        [_nameLabel nameWith:teacherObj.name sex:1];
    
    _headImg.frame = CGRectMake(0, (self.height - 70)*0.3/2+5, (self.height - 70)*0.7, (self.height - 70)*0.7);
    //    _headImg.image = [UIImage imageNamed:@"head_jiaolian"];
    [_headImg sd_setImageWithURL:[NSURL URLWithString:teacherObj.avatar] placeholderImage:[UIImage imageNamed:@"head_jiaolian"]];
    
    _headImg.center = CGPointMake(kScreenWidth/2, _headImg.center.y);
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = _headImg.height/2;
    
    _menuView.frame = CGRectMake(0, CGRectGetMaxY(_starView.frame)+5, kScreenWidth, 20);
    
    NSString *kindString = teacherObj.kind ==0 ? @"科目二": (teacherObj.kind == 1 ? @"科目三":@"科目二 科目三");
    _menuView.menuArray = @[[NSString stringWithFormat:@"%ld年",teacherObj.year],kindString,[NSString stringWithFormat:@"%ld人",teacherObj.student]];
}
@end
