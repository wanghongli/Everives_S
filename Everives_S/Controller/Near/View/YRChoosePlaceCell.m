//
//  YRChoosePlaceCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/24.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRChoosePlaceCell.h"
#import "YRBriefPlaceModel.h"

@interface YRChoosePlaceCell()
@property(nonatomic,strong) UIView *placeItem;
@end
@implementation YRChoosePlaceCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}
-(void)setPlace:(YRBriefPlaceModel *)place{
    self.textLabel.text = place.name;
}
@end
