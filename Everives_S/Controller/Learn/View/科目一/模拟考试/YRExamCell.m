//
//  YRExamCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamCell.h"
#import "YRChooseMenuView.h"
#define kDistace 10
@interface YRExamCell ()
{
    NSDictionary *answerDic;
}
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIView *centerView;
@property (nonatomic, weak) YRChooseMenuView *menuView;
@property (nonatomic, weak) UILabel *msgLabel;
@end
@implementation YRExamCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        answerDic = @{@"1":@"A",// A
                      @"2":@"B",// B
                      @"3":@"A,B",//A,B
                      @"4":@"C",//C
                      @"5":@"A,C",//A,C
                      @"6":@"B,C",//B,C
                      @"7":@"A,B,C",//A,B,C
                      @"8":@"D",//D
                      @"9":@"A,D",//A,D
                      @"10":@"B,D",//B,D
                      @"11":@"A,B,D",//A,B,D
                      @"12":@"C,D",//C,D
                      @"13":@"A,C,D",//A,C,D
                      @"14":@"B,C,D",//B,C,D
                      @"15":@"A,B,C,D",//A,B,C,D
                      };
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    UIView *backview = [[UIView alloc]init];
    [self addSubview:backview];
    _backView = backview;
    
    UIView *centerview = [[UIView alloc]init];
    [_backView addSubview:centerview];
    _centerView = centerview;
    
    YRChooseMenuView *menulabel = [[YRChooseMenuView alloc]init];
    [self addSubview:menulabel];
    _menuView = menulabel;
    
    UILabel *msglabel = [[UILabel alloc]init];
    msglabel.textAlignment = NSTextAlignmentLeft;
    msglabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:msglabel];
    _msgLabel = msglabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _backView.frame = CGRectMake(kDistace*2, kDistace, kDistace *2, kDistace*2);
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = _backView.height/2;
    _backView.layer.borderColor = [UIColor blueColor].CGColor;
    _backView.layer.borderWidth = 1;
    
    _centerView.frame = CGRectMake(0, 0, _backView.height/2, _backView.height/2);
    _centerView.center = CGPointMake(_backView.height/2, _backView.height/2);
    _centerView.layer.masksToBounds = YES;
    _centerView.layer.cornerRadius = _centerView.height/2;
//    _centerView.backgroundColor = [UIColor blueColor];
    
    _menuView.frame = _backView.frame;
    
    _msgLabel.frame = CGRectMake(CGRectGetMaxX(_backView.frame)+kDistace, 0, kScreenWidth-kDistace*3-CGRectGetMaxX(_backView.frame), 40);
}
-(void)setExamBool:(BOOL)examBool
{
    _examBool = examBool;
}
-(void)setMsgString:(NSString *)msgString
{
    _msgString = msgString;
//    if ([@[@"正确",@"错误"] containsObject:msgString]) {
//        _menuView.hidden = YES;
//        _backView.hidden = NO;
//        _centerView.hidden = NO;
//    }
    _msgLabel.text = msgString;
}
-(void)setMenuString:(NSInteger)menuString
{
    _menuString = menuString;
    NSString *menuMsg;
    if (menuString == 0) {
        menuMsg = @"A";
    }else if (menuString == 1){
        menuMsg = @"B";
    }else if (menuString == 2){
        menuMsg = @"C";
    }else{
        menuMsg = @"D";
    }
    _menuView.menuString = menuMsg;
    _menuView.hidden = NO;
    
    _backView.hidden = YES;
    _centerView.hidden = YES;
}
-(void)setQuest:(YRQuestionObj *)quest
{
    _quest = quest;
    if (self.examBool) {//考试状态
        if (!quest.currentError) {
            _menuView.selectState = 0;
            return;
        }
         if (quest.option.count == 4) {//选择题
             if (![@[@"1",@"2",@"4",@"8"] containsObject:[NSString stringWithFormat:@"%ld",quest.answer]]) {//多选题
                 [self setMoreMenuWith];
             }else{
                 NSInteger chooseInt;
                 if (quest.chooseAnswer>2) {
                     chooseInt = quest.chooseAnswer==4?3:4;
                 }else
                     chooseInt = quest.chooseAnswer;
                 if ([quest.option[chooseInt-1] isEqualToString:_msgLabel.text]) {//选项
                     _menuView.selectState = 1;
                 }else{
                     _menuView.selectState = 0;
                 }
             }
         }else{//判断题
             if ([quest.option[quest.chooseAnswer-1] isEqualToString:_msgLabel.text]) {//选项正确
//                 _centerView.backgroundColor = [UIColor lightGrayColor];
                 _menuView.selectState = 1;
             }else{
//                 _centerView.hidden = YES;
                 _menuView.selectState = 0;
             }
         }
        return;
    }
    if (quest.option.count == 4) {//选择题
        if (![@[@"1",@"2",@"4",@"8"] containsObject:[NSString stringWithFormat:@"%ld",quest.answer]]) {//多选题
            if (quest.currentError == 0) {//没做过
                [self setMoreMenuWith];
            }else if (quest.currentError == 1){//做对
                
                NSString *string = answerDic[[NSString stringWithFormat:@"%ld",_quest.chooseAnswer]];
                NSArray *arrayMenu;
                arrayMenu = [string componentsSeparatedByString:@","];
                if ([arrayMenu containsObject:_menuView.menuString]) {
                    _menuView.showImgBool = YES;
                }else{
                    _menuView.selectState = 0;
                }

            }else{//做错
               
                NSString *answerString = answerDic[[NSString stringWithFormat:@"%ld",_quest.answer]];
                NSString *string = answerDic[[NSString stringWithFormat:@"%ld",_quest.chooseAnswer]];
                NSArray *arrayMenu = [string componentsSeparatedByString:@","];
                NSArray *answerMenu = [answerString componentsSeparatedByString:@","];
                if ([arrayMenu containsObject:_menuView.menuString]) {
                    if ([answerMenu containsObject:_menuView.menuString]) {
                        _menuView.showImgBool = YES;
                    }else
                        _menuView.showImgBool = NO;
                }else{
                    if ([answerMenu containsObject:_menuView.menuString]) {
                        _menuView.selectState = 2;
                    }else
                        _menuView.selectState = 0;
                }
            }
        }else{//单选题
            NSInteger chooseInt;
            if (quest.answer>2) {
                chooseInt = quest.answer==4?3:4;
            }else
                chooseInt = quest.answer;
            
            if (quest.currentError) {
                if ([quest.option[chooseInt-1] isEqualToString:_msgLabel.text]) {//选项正确
                    _menuView.showImgBool = YES;
                }else{
                    NSInteger errorInt;
                    if (quest.chooseAnswer>2) {
                        errorInt = quest.chooseAnswer==4?3:4;
                    }else
                        errorInt = quest.chooseAnswer;
                    
                    if (quest.currentError == 1) {
                        _menuView.selectState = 0;
                    }else{
                        if ([quest.option[errorInt-1] isEqualToString:_msgLabel.text]) {//选错的
                            _menuView.showImgBool = NO;
                        }
                    }
                }
                
            }else{
                _menuView.selectState = 0;
            }
        }
    }else{//判断题
        if (quest.chooseAnswer) {//选择了
            _centerView.hidden = NO;
            if (quest.chooseAnswer == quest.answer) {//选择正确
                if ([quest.option[quest.chooseAnswer-1] isEqualToString:_msgLabel.text]) {
//                    _centerView.backgroundColor = [UIColor greenColor];
                    _menuView.showImgBool = YES;
                }else{
//                    _centerView.hidden = YES;
                    _menuView.selectState = 0;
                }
            }else{//选错了
                if ([quest.option[quest.answer-1] isEqualToString:_msgLabel.text]) {
//                    _centerView.backgroundColor = [UIColor greenColor];
                    _menuView.showImgBool = YES;
                }else{
//                    _centerView.backgroundColor = [UIColor redColor];
                    _menuView.showImgBool = NO;
                }
            }
        }else{//新题
//            _centerView.hidden = YES;
            _menuView.selectState = 0;
        }
    }
}
//多项选择设置选择后状态
-(void)setMoreMenuWith
{
   
    NSString *string = answerDic[[NSString stringWithFormat:@"%ld",_quest.chooseAnswer]];
    NSArray *arrayMenu;
    if (string.length == 1) {
        arrayMenu=@[string];
    }else
        arrayMenu = [string componentsSeparatedByString:@","];
    if ([arrayMenu containsObject:_menuView.menuString]) {
        _menuView.selectState = 1;
    }else{
        _menuView.selectState = 0;
    }
}
@end
