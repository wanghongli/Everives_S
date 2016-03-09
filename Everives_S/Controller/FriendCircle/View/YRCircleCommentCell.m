//
//  YRCircleCommentCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleCommentCell.h"
#import "YRCircleComment.h"
@interface YRCircleCommentCell ()

@property (nonatomic, weak) UILabel *user;
@property (nonatomic, weak) UIButton *fisrtUserBtn;
@property (nonatomic, weak) UIButton *secondUserBtn;
@property (nonatomic, weak) UILabel *commentMsg;

@end
@implementation YRCircleCommentCell
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
-(void)setUpAllChildView
{
    UILabel *comment = [[UILabel alloc]init];
    comment.font = [UIFont systemFontOfSize:13];
    comment.numberOfLines = 0;
    comment.textColor = kCOLOR(99, 99, 99);
    [self addSubview:comment];
    _commentMsg = comment;
    
    UIButton *btnFirst = [[UIButton alloc]init];
    [self addSubview:btnFirst];
    [btnFirst addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btnFirst.tag = 10;
    _fisrtUserBtn  = btnFirst;
    
    UIButton *btnSeconod = [[UIButton alloc]init];
    [self addSubview:btnSeconod];
    [btnSeconod addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btnSeconod.tag = 11;
    _secondUserBtn = btnSeconod;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell1";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setArray:(NSArray *)array
{
    _array = array;
    if (array.count == 1) {
        YRCircleComment *comment = array[0];
        NSString *string = [NSString stringWithFormat:@"%@:%@",comment.name,comment.content];
        NSRange range1=[string rangeOfString:comment.name];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        [str addAttribute:NSForegroundColorAttributeName value:kCOLOR(241, 145, 91) range:NSMakeRange(range1.location,range1.length)];
        
        _commentMsg.attributedText = str;
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        _commentMsg.frame = CGRectMake(55, 5, kSizeOfScreen.width-10-55, size.height);
        
        CGSize size1 = [comment.name sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        _fisrtUserBtn.frame = CGRectMake(_commentMsg.x, 0, size1.width, size1.height+5);
    }else if(array.count == 2){
        
        YRCircleComment *comment1 = array[0];
        YRCircleComment *comment2 = array[1];
        NSString *string = [NSString stringWithFormat:@"%@回复%@:%@",comment2.name,comment1.name,comment2.content];
        
        NSRange range1=[string rangeOfString:comment2.name];
        NSRange range2=[string rangeOfString:[NSString stringWithFormat:@"%@:",comment1.name]];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        [str addAttribute:NSForegroundColorAttributeName value:kCOLOR(241, 145, 91) range:NSMakeRange(range1.location,range1.length)];
        [str addAttribute:NSForegroundColorAttributeName value:kCOLOR(241, 145, 91) range:NSMakeRange(range2.location,range2.length-1)];
        _commentMsg.attributedText = str;
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        _commentMsg.frame = CGRectMake(55, 5, kSizeOfScreen.width-10-55, size.height);
        
        
        CGSize size1 = [comment2.name sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        _fisrtUserBtn.frame = CGRectMake(_commentMsg.x, 0, size1.width, size1.height+5);
        
        NSString *string2 = [NSString stringWithFormat:@"%@回复",comment2.name];
        CGSize size2 = [string2 sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        CGSize size3 = [comment1.name sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        _secondUserBtn.frame = CGRectMake(_commentMsg.x+size2.width, 0, size3.width, size3.height+5);
    }
}
+(CGFloat)detailCommentCellWith:(NSArray*)commentArray
{
    CGFloat height = 5;
    if (commentArray.count == 1) {
        YRCircleComment *comment = commentArray[0];
        NSString *string = [NSString stringWithFormat:@"%@:%@",comment.name,comment.content];
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        height+=size.height;
    }else if(commentArray.count == 2){
        
        YRCircleComment *comment1 = commentArray[0];
        YRCircleComment *comment2 = commentArray[1];
        NSString *string = [NSString stringWithFormat:@"%@回复%@:%@",comment2.name,comment1.name,comment2.content];
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(kSizeOfScreen.width-10-55, MAXFLOAT)];
        height+=size.height;
    }
    height+=5;
    return height;
}
-(void)btnClick:(UIButton *)sender
{
    NSInteger i = sender.tag - 10;
    if (self.userNameTapClickBlock) {
        self.userNameTapClickBlock(_array[i]);
    }
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
