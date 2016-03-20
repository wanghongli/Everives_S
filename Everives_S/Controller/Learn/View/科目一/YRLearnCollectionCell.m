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
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) YRExamHeadView *headView;
@property (nonatomic, strong) YRExamDownView *downView;
@end
@implementation YRLearnCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
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
-(void)setQuestionOb:(YRQuestionObject *)questionOb
{
    _questionOb = questionOb;
    _headView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamHeadView examHeadViewHeight:questionOb]);
    _headView.ques = questionOb;
    _tableview.tableHeaderView = _headView;
    [self.tableview reloadData];
    if (_questionOb.chooseAnswer) {
        if ( [_questionOb.chooseAnswer integerValue] == _questionOb.answer) {
            _tableview.tableFooterView = [[UIView alloc]init];
        }else{
            _downView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamDownView examDownViewGetHeight:_questionOb.analy]);
            _downView.anayString = _questionOb.analy;
            _tableview.tableFooterView = _downView;
        }
    }else{
        _tableview.tableFooterView = [[UIView alloc]init];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_questionOb.option.count) {
        return _questionOb.option.count;
    }else
        return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    YRExamCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRExamCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (_questionOb.option.count) {
        NSString *stringMsg = _questionOb.option[indexPath.row];
        cell.msgString = stringMsg;
        if (_questionOb.option.count == 4) {
            cell.menuString = indexPath.row;
        }
    }else{
        cell.msgString = indexPath.row ? @"错误":@"正确";
    }
    cell.quest = _questionOb;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_questionOb.answer == indexPath.row) {
        MyLog(@"答对了");
        _tableview.tableFooterView = [[UIView alloc]init];
    }else{
        MyLog(@"答错了");
        _downView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamDownView examDownViewGetHeight:_questionOb.analy]);
        _downView.anayString = _questionOb.analy;
        _tableview.tableFooterView = _downView;
    }
    _questionOb.chooseAnswer = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    if (self.answerIsClickBlock) {
        self.answerIsClickBlock(_questionOb);
    }
}
@end
