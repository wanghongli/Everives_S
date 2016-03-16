//
//  YRCircleCellViewModel.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleCellViewModel.h"
#import "YRWeibo.h"

#define CZStatusCellMargin 10
#define CZNameFont [UIFont systemFontOfSize:13]
#define CZTimeFont [UIFont systemFontOfSize:12]
#define CZSourceFont CZTimeFont
#define CZTextFont [UIFont systemFontOfSize:15]
#define CZScreenW [UIScreen mainScreen].bounds.size.width
@implementation YRCircleCellViewModel

- (void)setStatus:(YRWeibo *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = CZScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}
#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = 0;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + CZStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize;
    if (_status.name.length) {
        nameSize = [_status.name sizeWithFont:CZNameFont maxSize:CGSizeMake(100, MAXFLOAT)];
    }else
        nameSize = [@"玉祥驾校" sizeWithFont:CZNameFont maxSize:CGSizeMake(100, MAXFLOAT)];

    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + CZStatusCellMargin;
    
    CGFloat textW = CZScreenW - 2 * CZStatusCellMargin;
    CGSize textSize = [_status.content sizeWithFont:CZTextFont maxSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + CZStatusCellMargin;
    
    // 配图
    if (_status.pics.count) {
        CGFloat photosX = CZStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + CZStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:(int)_status.pics.count];
        
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + CZStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = CZScreenW;
    
    _originalViewFrame = CGRectMake(originX+10, originY, originW, originH);
    
}
#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    CGFloat photoWH;
    int cols;
    if (count ==1) {
        cols = 1;
        photoWH = kPICTURE_HW*3+20;
    }else if (count == 2 || count ==4){
        cols = 2;
        photoWH = (kPICTURE_HW*3+10)/2;
    }else{
        cols = 3;
        photoWH = kPICTURE_HW;
    }
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count - 1) / cols + 1;
    CGFloat w = cols * photoWH + (cols - 1) * CZStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * CZStatusCellMargin;
    
    return CGSizeMake(w, h);
}
@end
