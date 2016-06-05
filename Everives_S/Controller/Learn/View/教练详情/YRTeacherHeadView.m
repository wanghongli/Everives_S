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
    _headImg.layer.borderWidth = 1;
    _headImg.layer.borderColor = kCOLOR(108, 85, 122).CGColor;
    
    _menuView.frame = CGRectMake(0, CGRectGetMaxY(_starView.frame)+5, kScreenWidth, 20);
    NSString *kindString;
    if (_kind) {
        kindString = [_kind integerValue] ==0 ? @"科目二": (teacherObj.kind == 1 ? @"科目三":@"科目二 科目三");
    }else
        kindString = teacherObj.kind ==0 ? @"科目二": (teacherObj.kind == 1 ? @"科目三":@"科目二 科目三");
    _menuView.menuArray = @[[NSString stringWithFormat:@"%ld年",teacherObj.year],kindString,[NSString stringWithFormat:@"%ld人",teacherObj.student]];
}
-(void)setKind:(NSString *)kind
{
    _kind = kind;
    
}
@end
