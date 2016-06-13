//
//  YRTeacherCommentDownView.m
//  Everives_T
//
//  Created by 李洪攀 on 16/4/13.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherCommentDownView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#define kDistace 10
#define kImgWH (kScreenWidth - 7*kDistace/2)/3
@interface YRTeacherCommentDownView ()
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@end
@implementation YRTeacherCommentDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = kFontOfLetterBig;
    contentLabel.textColor = kCOLOR(60, 63, 62);
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:contentLabel];
    _contentLabel = contentLabel;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = kFontOfLetterMedium;
    timeLabel.textColor = kCOLOR(60, 63, 62);
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    for (int i = 0; i<9; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.tag = i+30;
        img.userInteractionEnabled = YES;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [img addGestureRecognizer:tap];
        [self addSubview:img];
        MyLog(@"%d",img.userInteractionEnabled);
        
    }
}
-(void)imageTap:(UITapGestureRecognizer *)sender
{
    UIImageView *tapView = (UIImageView*)sender.view;
    // CZPhoto -> MJPhoto
    int i = 0;
    NSArray *pics = (NSArray *)[_detailObj.pics mj_JSONObject];
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSString *photo in pics) {
        MJPhoto *p = [[MJPhoto alloc] init];
        p.url = [NSURL URLWithString:photo];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag-30;
    [brower show];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentSize = [_detailObj.content sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    _contentLabel.frame = CGRectMake(kDistace, kDistace, kScreenWidth-2*kDistace, contentSize.height);
    _contentLabel.text = _detailObj.content;
    
    NSArray *pics = (NSArray *)[_detailObj.pics mj_JSONObject];
    CGFloat maxY = 0;
    if (pics.count) {
        for (int i = 0; i<9; i++) {
            UIImageView *img = [self viewWithTag:i+30];
            if (i<pics.count) {
                img.hidden = NO;
                CGFloat x = i%3;
                CGFloat y = i/3;
                CGFloat distace = 5;
                img.frame = CGRectMake(kDistace + x*(kImgWH+distace), CGRectGetMaxY(_contentLabel.frame)+kDistace+y*(kImgWH+distace), kImgWH, kImgWH);
                [img sd_setImageWithURL:[NSURL URLWithString:pics[i]] placeholderImage:[UIImage imageNamed:@""]];
                maxY = CGRectGetMaxY(img.frame);
            }else{
                img.hidden = YES;
            }
        }
    }else
        maxY = CGRectGetMaxY(_contentLabel.frame);
    
    CGSize timeSize = [[NSString intervalSinceNow:_detailObj.time] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    _timeLabel.frame = CGRectMake(kDistace, maxY+kDistace, kScreenWidth-2*kDistace, timeSize.height);
    _timeLabel.text = [NSString intervalSinceNow:_detailObj.time];
}
-(void)setDetailObj:(YRTeacherCommentDetailObj *)detailObj
{
    _detailObj = detailObj;
}
+ (CGFloat)getTeacherCommentDownViewObj:(YRTeacherCommentDetailObj *)detailObj
{
    CGFloat height;
    height+=kDistace;
    CGSize contentSize = [detailObj.content sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    height+=contentSize.height;
    height+=kDistace;
    NSArray *pics = (NSArray *)[detailObj.pics mj_JSONObject];
    if (pics.count) {
        CGFloat y = pics.count/3;
        height = height + y*(kImgWH+5) + kImgWH;
        height+=kDistace;
    }
    
    CGSize timeSize = [[NSString intervalSinceNow:detailObj.time] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    height+=timeSize.height;
    height+=kDistace;
    
    return height;
}

@end
