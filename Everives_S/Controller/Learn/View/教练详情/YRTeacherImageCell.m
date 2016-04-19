//
//  YRTeacherImageCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherImageCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#define kDistace 10
@interface YRTeacherImageCell ()


@end

@implementation YRTeacherImageCell

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
    for (int i = 0; i < 3; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.userInteractionEnabled = YES;
        // 裁剪图片，超出控件的部分裁剪掉
        imageV.clipsToBounds = YES;
        imageV.image = [UIImage imageNamed:@"Login_addAvatar"];
        imageV.tag = i;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }

}

-(void)setImgArray:(NSArray *)imgArray
{
    _imgArray = imgArray;
    
    for (int i = 0 ; i<3; i++) {
        
        UIImageView *imageV = self.subviews[i+1];
        CGFloat imgY = 0;
        CGFloat imgW = (kScreenWidth - 4*kDistace)/3;
        CGFloat imgH = imgW;
        CGFloat imgX = kDistace + (kDistace + imgW) * i;

        imageV.frame = CGRectMake(imgX, imgY, imgW, imgH);
        imageV.image = [UIImage imageNamed:@"Login_addAvatar"];
        if (imgArray.count) {
            YRTeacherPicsObj *pic = imgArray[i];
            [imageV sd_setImageWithURL:[NSURL URLWithString:pic.url] placeholderImage:[UIImage imageNamed:@"Login_addAvatar"]];
        }

    }
}

-(void)imageTap:(UITapGestureRecognizer *)sender
{
    
    UIImageView *tapView = (UIImageView*)sender.view;
    // CZPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (YRTeacherPicsObj *photo in _imgArray) {
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo.url;
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];

}

@end
