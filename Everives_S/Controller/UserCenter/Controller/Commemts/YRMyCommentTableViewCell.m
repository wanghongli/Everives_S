
//
//  YRMyCommentTableViewCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/14.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyCommentTableViewCell.h"
#import "YRStarView.h"
#define kDistace 10
@interface YRMyCommentTableViewCell ()

@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) YRStarView *starView;
@property (nonatomic, weak) UILabel *pnameLabel;
@property (nonatomic, weak) UILabel *tnameLabel;
@property (nonatomic, weak) UIImageView *kindImg;

@end
@implementation YRMyCommentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    UIImageView *headimg = [[UIImageView alloc]init];
    headimg.image = [UIImage imageNamed:@"head_jiaolian"];
    [self addSubview:headimg];
    _headImg = headimg;

    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = kFontOfLetterBig;
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.textColor = [UIColor blackColor];
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    YRStarView *starview = [[YRStarView alloc]init];
    [self addSubview:starview];
    _starView = starview;
    
    UILabel *pnamelabel = [[UILabel alloc]init];
    pnamelabel.font = kFontOfLetterMedium;
    pnamelabel.textAlignment = NSTextAlignmentLeft;
    pnamelabel.textColor = [UIColor blackColor];
    [self addSubview:pnamelabel];
    _pnameLabel = pnamelabel;
   
    UILabel *tnamelabel = [[UILabel alloc]init];
    tnamelabel.font = kFontOfLetterMedium;
    tnamelabel.textAlignment = NSTextAlignmentLeft;
    tnamelabel.textColor = [UIColor blackColor];
    [self addSubview:tnamelabel];
    _tnameLabel = tnamelabel;
    
    UIImageView *kindimg = [[UIImageView alloc]init];
    kindimg.image = [UIImage imageNamed:@"class_three"];
    [self addSubview:kindimg];
    _kindImg = kindimg;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _headImg.frame = CGRectMake(kDistace, kDistace, 80, 80);
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = _headImg.height/2;
    NSString *dataWeek = [YRPublicMethod getDateAndWeekWith:_commentObj.date];
    CGSize namesize = [dataWeek sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGSize pnamesize = [_commentObj.tname sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat starWidth = [YRStarView getStarViewWight];
    CGFloat starHeight = 15;
    CGFloat viewDistace = (_headImg.height - starHeight - namesize.height - pnamesize.height*2)/3;
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImg.frame)+kDistace, _headImg.y, kScreenWidth - 2*kDistace-CGRectGetMaxX(_headImg.frame), namesize.height);
    _nameLabel.text = dataWeek;
    
    _starView.frame = CGRectMake(_nameLabel.x, CGRectGetMaxY(_nameLabel.frame)+viewDistace, starWidth, starHeight);
    _starView.starNu = 4;
    
    _pnameLabel.frame = CGRectMake(_nameLabel.x, CGRectGetMaxY(_starView.frame)+viewDistace, _nameLabel.width, pnamesize.height);
    _pnameLabel.text = _commentObj.pname;
    
    _tnameLabel.frame = CGRectMake(_nameLabel.x, CGRectGetMaxY(_pnameLabel.frame)+viewDistace, pnamesize.width, pnamesize.height);
    _tnameLabel.text = _commentObj.tname;
    
    _kindImg.frame = CGRectMake(CGRectGetMaxX(_tnameLabel.frame)+kDistace, _tnameLabel.y, 143*_tnameLabel.height/60, _tnameLabel.height);
    NSString *kindImgName = _commentObj.kind == 0 ?@"class_two":@"class_three";
    _kindImg.image = [UIImage imageNamed:kindImgName];
    
}
-(void)setCommentObj:(YRMyCommentObj *)commentObj
{
    _commentObj = commentObj;
}



@end
