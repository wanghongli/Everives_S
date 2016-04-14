//
//  YRTeacherCommentCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//


#import "YRTeacherCommentCell.h"


#define kImgHW 44
#define kDistance 10
@interface YRTeacherCommentCell ()
@property (nonatomic, weak) UIImageView *headImg;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *commentLabel;

@property (nonatomic, weak) UIView *commentBackView;

@property (nonatomic, weak) UILabel *timeAddressLabel;
@end

@implementation YRTeacherCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self buildUI];
        
    }
    return self;
}
- (void)buildUI
{
    UIImageView *headimg = [[UIImageView alloc]init];
    [self addSubview:headimg];
    _headImg = headimg;
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = kFontOfLetterMedium;
    namelabel.textColor = kCOLOR(79, 79, 79);
    namelabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    UIView *commentbackview = [[UIView alloc]init];
    commentbackview.backgroundColor = kCOLOR(246, 246, 246);
    [self addSubview:commentbackview];
    _commentBackView = commentbackview;
    
    UILabel *commentlabel = [[UILabel alloc]init];
    commentlabel.font = kFontOfLetterBig;
    commentlabel.textAlignment = NSTextAlignmentLeft;
    commentlabel.numberOfLines = 0;
    commentlabel.textColor = kCOLOR(79, 79, 79);
    [_commentBackView addSubview:commentlabel];
    _commentLabel = commentlabel;
    
    
    UILabel *timeaddresslabel = [[UILabel alloc]init];
    timeaddresslabel.font = kFontOfLetterSmall;
    timeaddresslabel.textColor = kCOLOR(79, 79, 79);
    timeaddresslabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:timeaddresslabel];
    _timeAddressLabel = timeaddresslabel;
    
    for (int i = 0; i<9; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.tag = i+30;
        [self addSubview:img];
    }
    
    
}
-(void)setTeacherCommentObj:(YRTeacherCommentObj *)teacherCommentObj
{
    _teacherCommentObj = teacherCommentObj;
    
    _headImg.frame = CGRectMake(kDistance, kDistance, kImgHW, kImgHW);
    _headImg.image = [UIImage imageNamed:@"head_jiaolian"];
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = kImgHW/2;
    
    CGSize nameSize = [@"小王" sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLabel.frame = CGRectMake(_headImg.x, CGRectGetMaxY(_headImg.frame)+kDistance, kImgHW, nameSize.height);
    _nameLabel.text = teacherCommentObj.name;
    
    
    CGFloat commentX = CGRectGetMaxX(_headImg.frame)+kDistance;
    CGFloat commentY = _headImg.y;
    CGFloat commentW = kScreenWidth - 3*kDistance - kImgHW - kDistance;
    CGSize commentSize = [teacherCommentObj.content sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(commentW, MAXFLOAT)];
    CGFloat commentH = commentSize.height;
    _commentLabel.frame = CGRectMake(kDistance/2, kDistance/2, commentW, commentH);
    _commentLabel.text = teacherCommentObj.content;
    
    _commentBackView.frame = CGRectMake(commentX, commentY, kScreenWidth - 3*kDistance - kImgHW, commentH+kDistance);
    _commentBackView.layer.masksToBounds = YES;
    _commentBackView.layer.cornerRadius = 8;
    
    CGFloat timeY;
    if (CGRectGetMaxY(_nameLabel.frame)>=CGRectGetMaxY(_commentBackView.frame)) {
        timeY = CGRectGetMaxY(_nameLabel.frame)+kDistance;
    }else
        timeY = CGRectGetMaxY(_commentBackView.frame)+kDistance;
    if (teacherCommentObj.pics.count) {
        for (int i = 0; i<9; i++) {
            UIImageView *img = [self viewWithTag:i+30];
            if (i<teacherCommentObj.pics.count) {
                img.hidden = NO;
                CGFloat x = i%3;
                CGFloat y = i/3;
                CGFloat distace = 5;
                img.frame = CGRectMake(kDistance + x*(kPICTURE_HW+distace), CGRectGetMaxY(_nameLabel.frame)+kDistance+y*(kPICTURE_HW+distace), kPICTURE_HW, kPICTURE_HW);
                [img sd_setImageWithURL:[NSURL URLWithString:teacherCommentObj.pics[i]] placeholderImage:[UIImage imageNamed:@""]];
                timeY = CGRectGetMaxY(img.frame)+kDistance;
                
            }else{
                img.hidden = YES;
            }
        }
    }
    
    _timeAddressLabel.frame = CGRectMake(kDistance, timeY, kScreenWidth-2*kDistance, nameSize.height);
    NSString *str=[NSString stringWithFormat:@"%ld",teacherCommentObj.time];//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    MyLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    _timeAddressLabel.text = currentDateStr;
}

+ (CGFloat) getTeacherCommentCellHeightWith:(YRTeacherCommentObj *)teacherCommentObj
{
    CGFloat height;
    
    height+=kDistance;
    
    CGSize nameSize = [@"小王" sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat commentW = kScreenWidth - 3*kDistance - kImgHW;
    CGSize commentSize = [teacherCommentObj.content sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(commentW, MAXFLOAT)];
    
    if (nameSize.height+kDistance+kImgHW>=commentSize.height) {
        height+=(nameSize.height+kDistance+kImgHW+kDistance);
    }else
        height+=commentSize.height+kDistance;
    
    if (teacherCommentObj.pics.count) {
//        for (int i = 0; i<9; i++) {
//            if (i<teacherCommentObj.pics.count) {
                CGFloat y = teacherCommentObj.pics.count/3;
//                height += y*(kPICTURE_HW+5);
                height = height + y*(kPICTURE_HW+5) + kPICTURE_HW;
//                
//            }
//        }
        height+=kDistance;
    }
    height+=nameSize.height;
    height+=kDistance;
    
    return height;
}

@end
