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
#import "SDImageCache.h"
#import "YRShaHeObjct.h"
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
//    int count = (int)self.subviews.count;
//    for (int i = 0; i < count; i++) {
//        
//        UIImageView *imageV = self.subviews[i];
//        
//        if (i < _pic_urls.count) { // 显示
//            // 获取图片链接
//            NSString *photo = _pic_urls[i];
//            
//            UIImage *imgMsg = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:photo];
//            if ([photo containsString:@"qiniucdn"]) {
//                if (_pic_urls.count == 1) {
//                    photo = [photo addString:kQiniuThumbnailParam(60)];
//                }else{
//                    photo = [photo addString:kQiniuThumbnailParam(30)];
//                }
//            }
//            self.image = nil;
//            imageV.hidden = NO;
//            if (imgMsg) {
//                NSData *fData;
//                if (_pic_urls.count == 1) {//图片压缩处理
//                    fData = UIImageJPEGRepresentation(imgMsg, 0.6);
//                }else
//                    fData = UIImageJPEGRepresentation(imgMsg, 0.3);
//
//                imageV.image = [UIImage imageWithData:fData];
//                imageV = nil;
//                fData = nil;
//            }else
//                [imageV sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
//        }else{
//            imageV.hidden = YES;
//        }
//    }
//    
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat margin = 5;
//    int col = 0;
//    int rol = 0;
//    int cols;
//    int count1 = (int)_pic_urls.count;
//    CGFloat photoWH;
//    if (count1 ==1) {
//        cols = 1;
//        photoWH = kPICTURE_HW*3+20;
//    }else if (count1 == 2 || count1 ==4){
//        cols = 2;
//        photoWH = (kPICTURE_HW*3+10)/2;
//    }else{
//        cols = 3;
//        photoWH = kPICTURE_HW;
//    }
//    
//    // 计算显示出来的imageView
//    for (int i = 0; i < _pic_urls.count; i++) {
//        col = i % cols;
//        rol = i / cols;
//        UIImageView *imageV = self.subviews[i];
//        x = col * (photoWH + margin);
//        y = rol * (photoWH + margin);
//        imageV.frame = CGRectMake(x, y, photoWH, photoWH);
//    }
}
-(void)setCircleModel:(YRWeibo *)circleModel
{
    _circleModel = circleModel;
    
    NSArray *pic_urls = [NSArray arrayWithArray:circleModel.pics];
    int count = (int)self.subviews.count;
    for (int i = 0; i < count; i++) {
        
        UIImageView *imageV = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示
            // 获取图片链接
            NSString *photo = pic_urls[i];
            UIImage *imgMsg;
            //四分钟以内的进行加载
            if ([self intervalSinceNow:circleModel.time] || [KUserManager.id isEqualToString:circleModel.uid]) {
//               imgMsg = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:photo];
                imgMsg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:photo];
//                imgMsg = [YRShaHeObjct loadNSDictionaryForDocument:photo];
            }
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                
            MyLog(@"%@",[paths objectAtIndex:0]);
            if ([photo containsString:@"qiniucdn"]) {
                if (pic_urls.count == 1) {
                    photo = [photo addString:kQiniuThumbnailParam(60)];
                }else{
                    photo = [photo addString:kQiniuThumbnailParam(30)];
                }
            }
            imageV.hidden = NO;
            if (imgMsg!=nil) {
//                dispatch_async(dispatch_get_main_queue(), ^{
                    imageV.image =imgMsg;
//                });
            }else{
                [imageV sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
            }
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
    int count1 = (int)pic_urls.count;
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
    for (int i = 0; i < pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (photoWH + margin);
        y = rol * (photoWH + margin);
        imageV.frame = CGRectMake(x, y, photoWH, photoWH);
    }
}
- (BOOL)intervalSinceNow:(NSString*) theDate
{
    BOOL imgBool;
    NSDate *d=[NSDate dateWithTimeIntervalSince1970:[theDate floatValue]];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha= now-late;
    
    //发表在一小时之内
    if(cha/3600<1) {
        if(cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        if ([timeString integerValue]<4) {
            imgBool = YES;
        }else
            imgBool = NO;
    }else
        imgBool = NO;
    return imgBool;

}
@end
