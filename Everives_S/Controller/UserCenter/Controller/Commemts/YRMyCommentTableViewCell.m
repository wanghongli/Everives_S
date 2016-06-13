
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
@property (nonatomic, weak) UIView *backView;
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
    UIView *backview = [[UIView alloc]init];
    [self addSubview:backview];
    _backView = backview;
    
    UIImageView *headimg = [[UIImageView alloc]init];
    headimg.image = [UIImage imageNamed:@"head_jiaolian"];
    [_backView addSubview:headimg];
    _headImg = headimg;

    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = kFontOfSize(17);
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.textColor = kCOLOR(27, 31, 31);
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    YRStarView *starview = [[YRStarView alloc]init];
    [self addSubview:starview];
    _starView = starview;
    
    UILabel *pnamelabel = [[UILabel alloc]init];
    pnamelabel.font = kFontOfLetterMedium;
    pnamelabel.textAlignment = NSTextAlignmentLeft;
    pnamelabel.textColor = kCOLOR(0, 5, 6);
    [self addSubview:pnamelabel];
    _pnameLabel = pnamelabel;
   
    UILabel *tnamelabel = [[UILabel alloc]init];
    tnamelabel.font = kFontOfLetterMedium;
    tnamelabel.textAlignment = NSTextAlignmentLeft;
    tnamelabel.textColor = kCOLOR(60, 63, 62);
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
    
    _backView.frame = CGRectMake(kDistace, kDistace, 80, 80);
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = _backView.height/2;
    _backView.layer.borderColor = kCOLOR(230, 230, 230).CGColor;
    _backView.layer.borderWidth = 2;
    
    _headImg.frame = CGRectMake(4, 4, 71, 71);
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = _headImg.height/2;

    NSString *dataWeek = [YRPublicMethod getDateAndWeekWith:_commentObj.date];
    CGSize namesize = [dataWeek sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGSize pnamesize = [_commentObj.tname sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat starWidth = [YRStarView getStarViewWight];
    CGFloat starHeight = 15;
    CGFloat viewDistace = (_backView.height - starHeight - namesize.height - pnamesize.height*2)/3;
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_backView.frame)+kDistace, _backView.y, kScreenWidth - 2*kDistace-CGRectGetMaxX(_backView.frame), namesize.height);
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
