//
//  YRTeacherDetailCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherDetailCell.h"

#define kDistace 10
@interface YRTeacherDetailCell ()

@property (nonatomic, weak) UILabel *introLabel;

@property (nonatomic, weak) UILabel *introDetailLabel;

@end

@implementation YRTeacherDetailCell
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

    UILabel *introlabel = [[UILabel alloc]init];
    introlabel.font = kFontOfLetterBig;
    introlabel.text = @"简介";
    introlabel.textColor = kCOLOR(86, 86, 86);
    [self addSubview:introlabel];
    _introLabel = introlabel;
    
    UILabel *introdetaillabel = [[UILabel alloc]init];
    introdetaillabel.font = kFontOfLetterBig;
    introdetaillabel.numberOfLines = 0;
    introdetaillabel.textColor = kCOLOR(86, 86, 86);
    [self addSubview:introdetaillabel];
    _introDetailLabel = introdetaillabel;
}

- (void)setIntroduce:(NSString *)introduce
{
    _introduce = introduce;
    
    CGSize introSize = [@"简介" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _introLabel.frame = CGRectMake(kDistace, kDistace, introSize.width, introSize.height);
    
    CGFloat dX = CGRectGetMaxX(_introLabel.frame)+2*kDistace;
    CGFloat dY = _introLabel.y;
    CGFloat dW = kScreenWidth-kDistace-dX;
    CGSize detailSize = [introduce sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(dW, MAXFLOAT)];
    CGFloat dH = detailSize.height;
    _introDetailLabel.frame = CGRectMake(dX, dY, dW, dH);
    _introDetailLabel.text = introduce;
}

+ (CGFloat)getTeacherDetailCellHeightWith:(NSString *)introduce
{
    CGFloat height;
    
    height = kDistace*2;
    CGSize introSize = [@"简介" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat dX = introSize.width+3*kDistace;
    CGFloat dW = kScreenWidth-kDistace-dX;
    CGSize detailSize = [introduce sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(dW, MAXFLOAT)];
    height +=detailSize.height;
    return height;
}

@end
