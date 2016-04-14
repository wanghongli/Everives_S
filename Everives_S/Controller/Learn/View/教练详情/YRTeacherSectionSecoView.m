//
//  YRTeacherSectionSecoView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherSectionSecoView.h"

#define kDistace 10
@interface YRTeacherSectionSecoView ()

@property (nonatomic, weak) UILabel *headTitle;
@property (nonatomic, weak) UIButton *allMsgBtn;

@end

@implementation YRTeacherSectionSecoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        [self buildUI];
        
    }
    return self;
}
- (void)buildUI
{
    
    UILabel *headtitle = [[UILabel alloc]init];
    headtitle.font = kFontOfLetterBig;
    headtitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:headtitle];
    _headTitle = headtitle;
    
    UIButton *allmsgbtn = [[UIButton alloc]init];
    [allmsgbtn addTarget:self action:@selector(allMsgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [allmsgbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    allmsgbtn.titleLabel.font = kFontOfLetterMedium;
    allmsgbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    allmsgbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self addSubview:allmsgbtn];
    _allMsgBtn = allmsgbtn;
    
    
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _headTitle.frame = CGRectMake(kDistace, 0, titleSize.width, self.height);
    _headTitle.text = titleString;

    UIImage *img = [UIImage imageNamed:@"left_jian"];
    if ([titleString containsString:@"学员评价"]) {
        _allMsgBtn.hidden = NO;
        [_allMsgBtn setTitle:@"全部评论" forState:UIControlStateNormal];
        [_allMsgBtn setImage:img forState:UIControlStateNormal];
    }else if([titleString containsString:@"场地和车型照片"]){
        _allMsgBtn.hidden = NO;
        [_allMsgBtn setTitle:@"全部照片" forState:UIControlStateNormal];
        [_allMsgBtn setImage:img forState:UIControlStateNormal];
    }else{
        _allMsgBtn.hidden = YES;
    }
    
    CGSize btnSize = [@"全部照片" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_allMsgBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0 ,0, 0)];
    [_allMsgBtn setImageEdgeInsets:UIEdgeInsetsMake(0,btnSize.width, 0, 0)];
    _allMsgBtn.frame = CGRectMake(kScreenWidth - kDistace - 10 - btnSize.width, 0, btnSize.width + 10, self.height);
}

-(void)allMsgBtnClick:(UIButton *)sender
{
    if (self.moreCommentOrPicClickBlock) {
        self.moreCommentOrPicClickBlock(sender.titleLabel.text);
    }
}
@end
