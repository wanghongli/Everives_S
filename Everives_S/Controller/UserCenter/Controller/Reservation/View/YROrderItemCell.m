//
//  YROrderItemCell.m
//  Everives_S
//
//  Created by darkclouds on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YROrderItemCell.h"
#import "YRReservationModel.h"
#import "YRSharedDateArray.h"
@interface YROrderItemCell(){
    NSArray *_times;
}
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
@implementation YROrderItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    _times = [YRSharedDateArray sharedInstance].timeArrayAllFact;
}

-(void)configCellWithModel:(YRReservationModel *)model{
    NSString *datey = [model.date substringToIndex:4];
    NSString *datem = [model.date substringWithRange:NSMakeRange(5, 2)];
    NSString *dated = [model.date substringFromIndex:8];
    _date.text = [NSString stringWithFormat:@"%@年%@月%@日",datey,datem,dated];
    _time.text = _times[[model.time integerValue]];
    _place.text = model.place;
    _price.text = [NSString stringWithFormat:@"￥%@",model.price];
}
@end
