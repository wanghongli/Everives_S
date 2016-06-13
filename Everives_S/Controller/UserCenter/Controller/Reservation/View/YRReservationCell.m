//
//  YRReservationCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationCell.h"
#import "YROrderedPlaceModel.h"
#import <UIImageView+WebCache.h>
#import "NSString+Tools.h"
#import "UIColor+Tool.h"
#import "GBPathImageView.h"
#import "YRSharedDateArray.h"

@interface YRReservationCell(){
    NSArray *_times;
    NSArray *_statusArr;
    NSArray *_statusColor;
}

@property (strong, nonatomic) GBPathImageView *avatar;
@property (strong, nonatomic) GBPathImageView *partnerAvatar;
@property (strong, nonatomic) GBPathImageView *myAvatar;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *coach;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIImageView *course;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *weekday;
@property (strong, nonatomic) UIImageView *arrowHead;


@end
@implementation YRReservationCell

- (void)awakeFromNib {
    
    

    _time.backgroundColor = kCOLOR(204, 204, 204);
    _time.textColor = [UIColor whiteColor];
    _time.layer.cornerRadius = 10;
    _time.layer.masksToBounds = YES;
    _price.textColor = [UIColor colorWithRed:250/255.0 green:126/255.0 blue:48/255.0 alpha:1];
    _status.textColor = [UIColor colorWithRed:250/255.0 green:126/255.0 blue:48/255.0 alpha:1];
    _coach.textColor = [UIColor colorWithRed:118/255.0 green:119/255.0 blue:121/255.0 alpha:1];
    _date.textColor = KDarkColor;
    _place.textColor = KDarkColor;
    _weekday.textColor = KDarkColor;
    _times = [YRSharedDateArray sharedInstance].timeArrayAllFact;
    _statusArr = @[@"未支付" ,@"已支付",@"已支付", @"已完成" ,@"已评价",@"已取消"];
    _statusColor = @[@"F82119",@"FA8038",@"FA8038",@"FA8038",@"8B8C8D",@"8B8C8D"];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configCellWithModel:(YROrderedPlaceModel *)model{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:model.avatar]
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            }
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                               if (image && finished) {
                                   _avatar = [[GBPathImageView alloc] initWithFrame:CGRectMake(8, 8, 90, 90) image:image pathType:GBPathImageViewTypeCircle pathColor:kCOLOR(230, 230, 230) borderColor:[UIColor whiteColor] pathWidth:4.0];
                                   [self.contentView addSubview:_avatar];
                               }
                               if (model.partner) {

                                   [manager downloadImageWithURL:[NSURL URLWithString:model.partner.avatar]
                                                         options:0
                                                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                        }
                                                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                           if (image && finished) {
                                                               _partnerAvatar = [[GBPathImageView alloc] initWithFrame:CGRectMake(6, 54, 45, 45) image:image pathType:GBPathImageViewTypeCircle pathColor:kCOLOR(230, 230, 230) borderColor:[UIColor whiteColor] pathWidth:4.0];
                                                               [self.contentView addSubview:_partnerAvatar];
                                                           }
                                                           [manager downloadImageWithURL:[NSURL URLWithString:KUserManager.avatar]
                                                                                 options:0
                                                                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                                                }
                                                                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                                                   if (image && finished) {
                                                                                       _myAvatar = [[GBPathImageView alloc] initWithFrame:CGRectMake(55, 54, 45, 45) image:image pathType:GBPathImageViewTypeCircle pathColor:kCOLOR(230, 230, 230) borderColor:[UIColor whiteColor] pathWidth:4.0];
                                                                                       [self.contentView addSubview:_myAvatar];
                                                                                   }
                                                                                   _arrowHead = [[UIImageView alloc] initWithFrame:CGRectMake(42, 68.5, 22, 15.5)];
                                                                                   _arrowHead.image = [UIImage imageNamed:@"BespeakDetail_Arrow"];
                                                                                   [self.contentView addSubview:_arrowHead];
                                                                               }
                                                            ];
                                                       }
                                    ];
                                   
                               }
                           }
     ];
    NSString *datey = [model.date substringToIndex:4];
    NSString *datem = [model.date substringWithRange:NSMakeRange(5, 2)];
    NSString *dated = [model.date substringFromIndex:8];
    _date.text = [NSString stringWithFormat:@"%@年%@月%@日",datey,datem,dated];
    _time.text = [NSString stringWithFormat:@"%@%@",_times[[model.time integerValue]],[model.more integerValue] ==1 ?@"更多":@""];
    CGRect rectBefore = _time.frame;
    CGSize size = [_time.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(kScreenWidth, 40)];
    _time.frame = CGRectMake(rectBefore.origin.x, rectBefore.origin.y, size.width, rectBefore.size.height);
    _place.text = model.pname;
    _coach.text= model.tname;
    _status.text = _statusArr[[model.status integerValue]];
    _status.textColor = [UIColor colorWithHexString:_statusColor[[model.status integerValue]]];
    _course.image = [UIImage imageNamed:[model.kind isEqualToString:@"0"]?@"class_two":@"class_three"];
    _price.text = [NSString stringWithFormat:@"￥%@",model.price];
    _weekday.text = [NSString getTheDayInWeek:model.date];
    
    
}
@end
