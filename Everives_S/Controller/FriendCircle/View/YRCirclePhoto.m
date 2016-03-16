//
//  YRCirclePhoto.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCirclePhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "NSString+Tools.h"
#define kQiniuThumbnailParam(scale) ([NSString stringWithFormat:@"?imageMogr2/thumbnail/!%dp", scale])

@implementation YRCirclePhoto

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        self.backgroundColor = [UIColor redColor];
        self.userInteractionEnabled = YES;
        // 添加9个子控件
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        [self setUpAllChildView];
    }
    return self;
}
// 添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.userInteractionEnabled = YES;
        // 裁剪图片，超出控件的部分裁剪掉
        imageV.clipsToBounds = YES;
        imageV.tag = i;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = (UIImageView*)tap.view;
    // CZPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSString *photo in _pic_urls) {
        
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo;
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

- (void)setPic_urls:(NSArray *)pic_urls
{
    // 4
    _pic_urls = pic_urls;
    int count = (int)self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        UIImageView *imageV = self.subviews[i];
        
        if (i < _pic_urls.count) { // 显示
            // 获取图片链接
            NSString *photo = _pic_urls[i];
            
            if ([photo containsString:@"qiniucdn"]) {
                if (_pic_urls.count == 1) {
                    photo = [photo addString:kQiniuThumbnailParam(60)];
                }else{
                    photo = [photo addString:kQiniuThumbnailParam(30)];
                }
            }
            self.image = nil;
            imageV.hidden = NO;
            [imageV sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        }else{
            imageV.hidden = YES;
        }
    }
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = 5;
    int col = 0;
    int rol = 0;
    int cols;
    int count1 = (int)_pic_urls.count;
    CGFloat photoWH;
    if (count1 ==1) {
        cols = 1;
        photoWH = kPICTURE_HW*3+20;
    }else if (count1 == 2 || count1 ==4){
        cols = 2;
        photoWH = (kPICTURE_HW*3+10)/2;
    }else{
        cols = 3;
        photoWH = kPICTURE_HW;
    }
    
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (photoWH + margin);
        y = rol * (photoWH + margin);
        imageV.frame = CGRectMake(x, y, photoWH, photoWH);
    }
}
@end
