//
//  KGFreshCatchDetailZanView.m
//  SkyFish
//
//  Created by 李洪攀 on 15/11/22.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import "KGFreshCatchDetailZanView.h"
#import "UIImageView+WebCache.h"
#import "YRPraiseMem.h"

#define CZStatusCellMargin 10
@interface KGFreshCatchDetailZanView ()

@property (nonatomic, weak) UIView *topLine;

@property (nonatomic, weak) UIImageView *leftImg;

@end

@implementation KGFreshCatchDetailZanView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        // 添加所有子控件
        [self setUpAllChildView];
    }
    return self;
}
//添加子控件
-(void)setUpAllChildView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kCOLOR(230, 230, 230);
    [self addSubview:view];
    _topLine = view;
    

    //左边点赞图片
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:@"SNS_Detail_LikesList"];
    [self addSubview:imgView];
    _leftImg = imgView;
    
    int btnCount = (kScreenWidth - 2*CZStatusCellMargin - 15)/(34+CZStatusCellMargin/2);
    for (int i = 0; i < btnCount; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 17;
        imageV.layer.borderWidth = 1;
        imageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // 裁剪图片，超出控件的部分裁剪掉
        imageV.clipsToBounds = YES;
        imageV.tag = i+10;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}
//手势点击事件
-(void)tap:(UITapGestureRecognizer *)gestrue
{
    MyLog(@"%s",__func__);
     UIImageView *tapView = (UIImageView*)gestrue.view;
    [self.delegate zanViewWhichUserClick:tapView.tag-10];
}
//添加视图
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.topLine.frame = CGRectMake(0, 0, kSizeOfScreen.width, 1);
    
    _leftImg.frame = CGRectMake(CZStatusCellMargin, 15, 14, 14);
    
    
    int btnCount = (kScreenWidth - 2*CZStatusCellMargin - 10)/(34+CZStatusCellMargin/2);
    CGFloat w = 34;
    CGFloat h = 34;
    // 计算显示出来的imageView
    for (int i = 0; i < btnCount; i++) {
        UIImageView *imageV = [self viewWithTag:i+10];
        CGFloat x = i * (w + 5)+CGRectGetMaxX(_leftImg.frame)+5;
        imageV.frame = CGRectMake(x, 5, w, h);
    }
}
//导入数据源
-(void)setStatusArray:(NSArray *)statusArray
{
    _statusArray = statusArray;
    int count = (kScreenWidth - 2*CZStatusCellMargin - 15)/(34+CZStatusCellMargin/2);

    for (int i = 0; i < count; i++) {
        
        UIImageView *imageV = [self viewWithTag:i+10];
        if (statusArray.count>count) {//只显示cout个数据
            YRPraiseMem *member = statusArray[i];
            // 获取图片链接
            NSString *photo = member.avatar;
            imageV.hidden = NO;
            // 赋值
            [imageV sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        }else{//只显示有的数据
            if (i < statusArray.count) { // 显示
                imageV.hidden = NO;
                YRPraiseMem *member = statusArray[i];
                // 获取图片链接
                NSString *photo = member.avatar;
                // 赋值
                [imageV sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
            }else{
                imageV.hidden = YES;
            }
        }
    }

}
@end
