//
//  YRTeacherPlaceCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherPlaceCell.h"

#define kImgHW 20
#define kDistace 10
@interface YRTeacherPlaceCell ()

@property (nonatomic, weak) UIImageView *leftImg;
@property (nonatomic, weak) UILabel *schoolNameLabel;
@property (nonatomic, weak) UILabel *addressLabel;

@end
@implementation YRTeacherPlaceCell
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
    UIImageView *leftimg = [[UIImageView alloc]init];
    leftimg.image = [UIImage imageNamed:@"Neig_Coach_Field"];
    [self addSubview:leftimg];
    _leftImg = leftimg;
    
    UILabel *schoolnamelabel = [[UILabel alloc]init];
    schoolnamelabel.font = kFontOfLetterBig;
    schoolnamelabel.textColor = kCOLOR(79, 79, 79);
    schoolnamelabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:schoolnamelabel];
    _schoolNameLabel = schoolnamelabel;
    
    UILabel *addresslabel = [[UILabel alloc]init];
    addresslabel.font = kFontOfLetterBig;
    addresslabel.textColor = kCOLOR(79, 79, 79);
    addresslabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:addresslabel];
    _addressLabel = addresslabel;
}

-(void)teacherPlaceGetSchoolName:(NSString *)schoolName address:(NSString *)address
{
    _leftImg.frame = CGRectMake(kDistace, 12, kImgHW, kImgHW);
    
    CGSize schoolSize = [schoolName sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _schoolNameLabel.frame = CGRectMake(CGRectGetMaxX(_leftImg.frame)+kDistace, 0, schoolSize.width, self.height);
    _schoolNameLabel.text = schoolName;
    
    CGSize addressSize = [address sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _addressLabel.frame = CGRectMake(kScreenWidth-kDistace-addressSize.width, 0, addressSize.width, self.height);
    _addressLabel.text = address;
}

@end
