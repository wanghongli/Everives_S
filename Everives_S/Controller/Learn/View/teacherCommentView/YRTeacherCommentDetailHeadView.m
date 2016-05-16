//
//  YRTeacherCommentDetailHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherCommentDetailHeadView.h"
#import "YRTeacherStarLevelView.h"

#define kdistace 20
@interface YRTeacherCommentDetailHeadView ()
@property (nonatomic, weak) YRTeacherStarLevelView *starView;
@property (nonatomic, weak) UIImageView *imgView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *levelLabel;

@end
@implementation YRTeacherCommentDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    
    UIImageView *imgview = [[UIImageView alloc]init];
    [self addSubview:imgview];
    _imgView = imgview;
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = kFontOfLetterBig;
    namelabel.textColor = [UIColor blackColor];
    namelabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    UILabel *levellabel = [[UILabel alloc]init];
    levellabel.font = kFontOfLetterBig;
    levellabel.textColor = [UIColor blackColor];
    levellabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:levellabel];
    _levelLabel = levellabel;
    
    YRTeacherStarLevelView *starview = [[YRTeacherStarLevelView alloc]init];
    [self addSubview:starview];
    _starView = starview;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(kdistace, self.height/6, self.height*2/3, self.height*2/3);
    _imgView.image = [UIImage imageNamed:@"head_jiaolian"];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = _imgView.height/2;
    
//    CGSize nameSize = [@"罗纳尔多" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
//    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+kdistace, _imgView.y, nameSize.width, nameSize.height);
//    _nameLabel.text = @"罗纳尔多";
//    
//    _levelLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame)+kdistace, _imgView.y, nameSize.width, nameSize.height);
//    _levelLabel.text = @"4.0";
    
//    _starView.frame = CGRectMake(CGRectGetMaxX(_imgView.frame), CGRectGetMaxY(_nameLabel.frame), self.width-CGRectGetMaxX(_imgView.frame), _imgView.height - nameSize.height +10);
}
-(void)setDetailObj:(YRTeacherCommentDetailObj *)detailObj
{
    _detailObj = detailObj;
    
    _imgView.frame = CGRectMake(kdistace, self.height/6, self.height*2/3, self.height*2/3);
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = _imgView.height/2;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:detailObj.avatar] placeholderImage:[UIImage imageNamed:@"head_jiaolian"]];
   
    NSString *nameString = [NSString stringWithFormat:@"%@",detailObj.tname];
    MyLog(@"%@",nameString);
    CGSize nameSize = [nameString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];

    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_imgView.frame)+kdistace, _imgView.y, nameSize.width, nameSize.height);
    _nameLabel.text = nameString;
    
    _levelLabel.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame)+kdistace, _imgView.y, nameSize.width, nameSize.height);
    _levelLabel.text = detailObj.grade;
    
    
    _starView.frame = CGRectMake(CGRectGetMaxX(_imgView.frame), CGRectGetMaxY(_nameLabel.frame), self.width-CGRectGetMaxX(_imgView.frame), _imgView.height - nameSize.height +10);
    _starView.describeInt = detailObj.describe;
    _starView.qualityInt = detailObj.quality;
    _starView.attitudeInt = detailObj.attitude;
    _starView.teachTime = detailObj.teachTime;
    _starView.userInteractionEnabled = NO;
}
@end
