//
//  YRLearnCollectionCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnCollectionCell.h"
#import "YRExamHeadView.h"
#import "YRExamCell.h"
#import "YRExamDownView.h"
@interface YRLearnCollectionCell ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *menuArray;
}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) YRExamHeadView *headView;
@property (nonatomic, strong) YRExamDownView *downView;
@end
@implementation YRLearnCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        menuArray = @[@"1",@"2",@"4",@"8"];
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableview];
        _tableview.tableFooterView = [[UIView alloc]init];
        _headView = [[YRExamHeadView alloc]init];
        _downView = [[YRExamDownView alloc]init];
    }
    return self;
}
-(void)setQuestionOb:(YRQuestionObj *)questionOb
{
    _questionOb = questionOb;
    _headView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamHeadView examHeadViewHeight:questionOb]);
    _headView.ques = questionOb;
    _tableview.tableHeaderView = _headView;
    [self.tableview reloadData];
    if (self.examBool) {
        return;
    }
    if (_questionOb.currentError==2) {
        _downView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamDownView examDownViewHeight:_questionOb]);
        _downView.questOb = _questionOb;
        _tableview.tableFooterView = _downView;
    }else{
        _tableview.tableFooterView = [[UIView alloc]init];
    }
}
- (void)setMNCurrentID:(NSInteger)MNCurrentID
{
    _MNCurrentID = MNCurrentID;
    _headView.MNCurrentID = MNCurrentID;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_questionOb.option.count) {
        if ([_questionOb.option[0] length]) {
            return _questionOb.option.count;
        }
        return 2;
    }else
        return 2;
}
-(void)setShowAanly:(BOOL)showAanly
{
    _showAanly = showAanly;
    _downView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamDownView examDownViewHeight:_questionOb]);
    _downView.questOb = _questionOb;
    _tableview.tableFooterView = _downView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    YRExamCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRExamCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.examBool = self.examBool;
    if (_questionOb.option.count ==4) {
        cell.menuString = indexPath.row;
    }
    NSString *stringMsg = _questionOb.option[indexPath.row];
    cell.msgString = stringMsg;
    cell.quest = _questionOb;
    //做过后不能选择
    if (_questionOb.currentError) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (!_questionOb.currentError) {
            if ([menuArray containsObject:[NSString stringWithFormat:@"%ld",_questionOb.answer]]) {//单选题
                _questionOb.chooseAnswer = [menuArray[indexPath.row] integerValue];
                if (_questionOb.answer == _questionOb.chooseAnswer) {//答对了
                    MyLog(@"答对了");
                    _tableview.tableFooterView = [[UIView alloc]init];
                    _questionOb.error = 0;
                    _questionOb.currentError = 1;
                }else{//错误
                    MyLog(@"答错了");
                    if (self.examBool) {//考试状态
                        _tableview.tableFooterView = [[UIView alloc]init];
                    }else{
                        _downView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamDownView examDownViewHeight:_questionOb]);
                        _downView.questOb = _questionOb;
                        _tableview.tableFooterView = _downView;
                    }
                    _questionOb.error = 1;
                    _questionOb.currentError = 2;
                }
                _questionOb.already = 1;
                if (self.answerIsClickBlock) {
                    self.answerIsClickBlock(_questionOb);
                }
            }else{//多选题
                
            }
        }
        [tableView reloadData];
}
@end
