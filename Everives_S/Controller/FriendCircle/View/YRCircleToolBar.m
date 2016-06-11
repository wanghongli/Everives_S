//
//  YRCircleToolBar.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleToolBar.h"
#import "YRWeibo.h"
#import "RequestData.h"
#import "YRPraiseMem.h"
#import "UIImageView+WebCache.h"
#define CZStatusCellMargin 10
#define CZNameFont [UIFont systemFontOfSize:13]
#define CZTimeFont [UIFont systemFontOfSize:12]
#define CZSourceFont CZTimeFont
#define CZTextFont [UIFont systemFontOfSize:15]
#define CZScreenW [UIScreen mainScreen].bounds.size.width
#define kQiniuThumbnailParam(scale) ([NSString stringWithFormat:@"?imageMogr2/thumbnail/!%dp", scale])
@interface YRCircleToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divideVs;

@property (nonatomic, weak) UILabel *address;//地址
@property (nonatomic, weak) UIButton *comment;//评论
@property (nonatomic, weak) UIButton *unlike;//赞

@end

@implementation YRCircleToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideVs
{
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    
    return _divideVs;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setUpAllChildView
{
    // 转发
    UILabel *address = [[UILabel alloc] init];
    address.font = CZNameFont;
    address.textColor = kCOLOR(153, 153, 153);
    [self addSubview:address];
    _address = address;
    
    // 评论
    UIButton *comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"SNS_Comment"]];
    [comment addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    comment.tag = 21;
    _comment = comment;
    
    // 赞
    UIButton *unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"SNS_unLike"]];
    [unlike setImage:[UIImage imageNamed:@"SNS_Likes"] forState:UIControlStateSelected];
    [unlike addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    unlike.tag = 22;
    _unlike = unlike;
    
    
    CGFloat w = (CZScreenW - CZStatusCellMargin) / 6;
    CGFloat ViewW = kScreenWidth-2*CZStatusCellMargin-2*w-5;
    int num = ViewW/30;
    NSLog(@"%d",num);
    for (int i = 0; i<num; i++) {
        CGFloat x = CZStatusCellMargin+i*30+5;
        CGFloat y = 5;
        CGFloat w = 25;
        CGFloat h = 25;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [self addSubview:img];
        img.layer.masksToBounds = YES;
        img.layer.cornerRadius = img.height/2;
        img.hidden = YES;
        img.clipsToBounds = YES;
        img.userInteractionEnabled = YES;
        img.tag = 100+i;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)];
        [img addGestureRecognizer:tap];
    }
}
#pragma mark - 点击图片的时候调用
- (void)headClick:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = (UIImageView*)tap.view;
    [self.delegate commentOrAttentTouch:tapView.tag];
}
- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:kCOLOR(153, 153, 153) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat addressX = CZStatusCellMargin;
    CGFloat addressY = 0;
    CGFloat addressH = self.height;
    CGFloat addressW = (CZScreenW - 2*CZStatusCellMargin)/2;
    self.address.frame = CGRectMake(addressX, addressY, addressW, addressH);
    
    // 设置按钮的frame
    CGFloat w = (CZScreenW - 2*CZStatusCellMargin) / 6;
    CGFloat h = self.height;
    CGFloat x = CGRectGetMaxX(self.address.frame);
    CGFloat y = 0;
    
    self.unlike.frame = CGRectMake(kScreenWidth-CZStatusCellMargin-2*w, y, w, h);
    self.unlike.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.comment.frame = CGRectMake(CGRectGetMaxX(self.unlike.frame), y, w, h);
    self.comment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}
-(void)setStatus:(YRWeibo *)status
{
    _status = status;
    
    // 设置转发的标题
    _address.text = status.address;
    
    // 设置评论的标题
    [self setBtn:_comment title:[status.commentCount intValue]];
    
    // 设置赞
    [self setBtn:_unlike title:[status.praise intValue]];
    
    self.unlike.selected = [status.praised boolValue];
    CGFloat w = (CZScreenW - CZStatusCellMargin) / 6;
    CGFloat ViewW = kScreenWidth-2*CZStatusCellMargin-2*w;
    int num = ViewW/30;
    NSLog(@"%d",num);
    for (int i = 0; i<num; i++) {
        if (status.address.length || [status.address containsString:@"暂无"]) {
            _address.hidden = YES;
        }else{
            _address.hidden = NO;
            return;
        }
        UIImageView *img = (UIImageView *)[self viewWithTag:i+100];
        if (status.praiseMem.count==0) {
            img.hidden = YES;
        }else{
            if (i<status.praiseMem.count) {
                if ((status.praiseMem.count == num) && i == num-1) {
                    img.image = [UIImage imageNamed:@"未标题-1三个点"];
                }else{
                    img.hidden = NO;
                    YRPraiseMem *prObj = status.praiseMem[i];
                    NSString *photo = prObj.avatar;
                    photo = [photo addString:kQiniuThumbnailParam(30)];
                    [img sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
                }
            }else{
                if (i == status.praiseMem.count && status.praiseMem.count<num) {
                    //                UIImageView *img1 = (UIImageView *)[self viewWithTag:i+1+100];
                    img.image = [UIImage imageNamed:@"未标题-1三个点"];
                    img.hidden = NO;
                    
                }else
                    img.hidden = YES;
            }
        }
    }
}
// 设置按钮的标题
- (void)setBtn:(UIButton *)btn title:(int)count
{
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{ // < 10000
            title = [NSString stringWithFormat:@"%d",count];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"0" forState:UIControlStateNormal];
    }
}
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 22) {
        if ([_status.praised boolValue]) {
            [RequestData DELETE:[NSString stringWithFormat:@"/seeds/praise/%@",_status.id] parameters:nil complete:^(NSDictionary *responseDic) {
                [self.delegate commentOrAttentTouch:sender.tag-20];
            } failed:^(NSError *error) {
                
            }];
        }else{
            [RequestData POST:WEIBO_PRAISE parameters:@{@"id":_status.id} complete:^(NSDictionary *responseDic) {
                [self.delegate commentOrAttentTouch:sender.tag-20];
            } failed:^(NSError *error) {
                
            }];
        }
        
    }else
        [self.delegate commentOrAttentTouch:sender.tag-20];
}
@end
