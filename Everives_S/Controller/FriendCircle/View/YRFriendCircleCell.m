//
//  YRFriendCircleCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFriendCircleCell.h"
#import "YRCircleUser.h"
#import "YRCircleToolBar.h"
#import "YRCircleCellViewModel.h"
#import "YRWeibo.h"
@interface YRFriendCircleCell ()<YRCircleToolBarDelegate,YRCircleUserDelegate>

@property (nonatomic, weak) YRCircleUser *originalView;
@property (nonatomic, weak) YRCircleToolBar *toolBar;

@property (nonatomic, weak) UIView *downLine;

@end
@implementation YRFriendCircleCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.userInteractionEnabled = YES;
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
// 添加所有子控件
- (void)setUpAllChildView
{
    // 内容部分
    YRCircleUser *originalView = [[YRCircleUser alloc] init];
    [self addSubview:originalView];
    originalView.delegate = self;
    _originalView = originalView;
    
    // 工具条
    YRCircleToolBar *toolBar = [[YRCircleToolBar alloc] init];
    [self addSubview:toolBar];
    toolBar.delegate = self;
    _toolBar = toolBar;
    
    UIView *down = [[UIView alloc]init];
    down.backgroundColor = kCOLOR(241, 241, 241);
    [self addSubview:down];
    _downLine = down;
}
-(void)userIconClick
{
    if (self.iconClickBlock) {
        self.iconClickBlock([KUserManager.id isEqualToString:_statusF.status.uid]);
    }
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setStatusF:(YRCircleCellViewModel *)statusF
{
    _statusF = statusF;
    self.backgroundColor = [UIColor whiteColor];//kCOLOR(241, 241, 241);
    // 设置原创微博frame
    _originalView.frame = _statusF.originalViewFrame;
    _originalView.statusF = statusF;
    
    // 设置工具条frame
    _toolBar.frame = statusF.toolBarFrame;
    _toolBar.status = statusF.status;
}
-(void)commentOrAttentTouch:(NSInteger)commentOrAttent
{
    if (self.commentOrAttentClickBlock) {
        self.commentOrAttentClickBlock(commentOrAttent);
    }
}
-(void)setLineBool:(BOOL)lineBool
{
    _lineBool = lineBool;
    _originalView.lineBool = lineBool;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
