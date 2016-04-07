//
//  YRMyErrorController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyErrorController.h"
#import "YRLearnPracticeController.h"
#import "YRFMDBObj.h"
#import "YRQuestionKindObj.h"
@interface YRMyErrorController ()
@property (nonatomic, strong) NSMutableArray *titleArray;


@end

@implementation YRMyErrorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的错题";
    self.titleArray = [NSMutableArray array];
    NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
    NSArray *array = [YRQuestionKindObj mj_objectArrayWithKeyValuesArray:[userDefaults objectForKey:@"ques_kind"]];
    for (int i = 0; i<array.count; i++) {
        YRQuestionKindObj *quesKind = array[i];
        if (quesKind.type == self.objFour) {
            [self.titleArray addObject:quesKind];
        }
    }
//    self.titleArray = @[@"交通法规",@"交通信号灯",@"路况环境",@"机动车驾驶操作"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = kCOLOR(241, 241, 241);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"所有错题";
    }else{
        YRQuestionKindObj *quesKind = self.titleArray[indexPath.row];
        cell.textLabel.text = quesKind.name;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRLearnPracticeController *practiceVC = [[YRLearnPracticeController alloc]init];
    if (indexPath.section == 0) {
        NSArray *array = [NSArray arrayWithArray:[YRFMDBObj getPracticeWithType:self.objFour withSearchMsg:@"error = 1" withFMDB:[YRFMDBObj initFmdb]]];
        if (!array.count) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无错题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }else{
            practiceVC.perfisonalKind = 1;
        }
    }else{
        YRQuestionKindObj *quesKind = self.titleArray[indexPath.row];
        NSArray *array = [NSArray arrayWithArray:[YRFMDBObj getPracticeWithType:self.objFour withSearchMsg:[NSString stringWithFormat:@"kind = %ld and error = 1",quesKind.id] withFMDB:[YRFMDBObj initFmdb]]];
        if (!array.count) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无此项错题" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }else{
            practiceVC.perfisonalKind = quesKind.id;
        }
    }
    practiceVC.menuTag = 4;
    [self.navigationController pushViewController:practiceVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = kCOLOR(241, 241, 241);
    return view;
}
@end
