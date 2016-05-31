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
    NSMutableArray *answerArray;
    //多项选择时是否显示底部按钮
    BOOL showSectionFooter;
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
        answerArray = [NSMutableArray array];
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableview];
        _tableview.tableFooterView = [[UIView alloc]init];
        _headView = [[YRExamHeadView alloc]init];
        _downView = [[YRExamDownView alloc]init];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self.tableview addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}
-(void)keyboardHide:(UIPanGestureRecognizer *)sender
{
    MyLog(@"%s",__func__);
    if (self.questionOb.currentError==2) {
        if (self.anserErrorClickBlock) {
            self.anserErrorClickBlock();
        }
    }
}
-(void)setQuestionOb:(YRQuestionObj *)questionOb
{
    _questionOb = questionOb;

    //判断是否显示多选确定按钮
    if (![menuArray containsObject:[NSString stringWithFormat:@"%ld",_questionOb.answer]] && _questionOb.currentError==0) {
        showSectionFooter = YES;
    }else
        showSectionFooter = NO;
    
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
    if (showAanly) {
        _downView.frame = CGRectMake(0, 0, kScreenWidth, [YRExamDownView examDownViewHeight:_questionOb]);
        _downView.questOb = _questionOb;
        _tableview.tableFooterView = _downView;
    }else{
        
        _tableview.tableFooterView = [[UIView alloc]init];;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    YRExamCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRExamCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.examBool = self.examBool;
    cell.menuString = indexPath.row;
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!showSectionFooter) {
        return 0.1;
    }
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    if (!showSectionFooter) {
        view.backgroundColor = [UIColor clearColor];
    }else{
//        view.backgroundColor = [UIColor redColor];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 3, kScreenWidth-200, 44)];
        [btn setTitle:@"确认答案" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor blueColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = btn.height/2;
        [btn addTarget:self action:@selector(sureAnswerClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }

    return view;
}
-(void)sureAnswerClick
{
    if (![menuArray containsObject:[NSString stringWithFormat:@"%ld",_questionOb.chooseAnswer]]) {
        showSectionFooter = NO;
        //判断正确与否
        [self hasBeenAnswerQuetion];
        [self.tableview reloadData];
    }else{
        [MBProgressHUD showError:@"此题是多项选择题" toView:GET_WINDOW];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![menuArray containsObject:[NSString stringWithFormat:@"%ld",_questionOb.answer]]) {//多项选择题
        NSString *chooseAnswer = [menuArray objectAtIndex:indexPath.row];
        if ([answerArray containsObject:chooseAnswer]) {
            [answerArray removeObject:chooseAnswer];
        }else
            [answerArray addObject:chooseAnswer];
        NSInteger answer = 0;
        for (int i = 0; i<answerArray.count; i++) {
            answer+=[answerArray[i] integerValue];
        }
        _questionOb.chooseAnswer = answer;
        [self.tableview reloadData];
        return;
    }
    if (!_questionOb.currentError) {
        _questionOb.chooseAnswer = [menuArray[indexPath.row] integerValue];
        //判断正确与否
        [self hasBeenAnswerQuetion];
    }
    [tableView reloadData];
}
-(void)hasBeenAnswerQuetion
{
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
    if (self.answerIsClickBlock) {
        self.answerIsClickBlock(_questionOb);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MyLog(@"%s",__func__);
}
@end
