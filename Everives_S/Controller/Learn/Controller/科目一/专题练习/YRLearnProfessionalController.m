//
//  YRLearnProfessionalController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnProfessionalController.h"
#import "YRLearnPracticeController.h"
#import "YRQuestionKindObj.h"

@interface YRLearnProfessionalController ()
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation YRLearnProfessionalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题练习";
    self.titleArray = [NSMutableArray array];
    NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
    NSArray *array = [YRQuestionKindObj mj_objectArrayWithKeyValuesArray:[userDefaults objectForKey:@"ques_kind"]];
    for (int i = 0; i<array.count; i++) {
        YRQuestionKindObj *quesKind = array[i];
        if (quesKind.type == self.objFour) {
            [self.titleArray addObject:quesKind];
        }
    }
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    YRQuestionKindObj *quesKind = self.titleArray[indexPath.row];
    cell.textLabel.text = quesKind.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",quesKind.num];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRLearnPracticeController *practiceVC = [[YRLearnPracticeController alloc]init];
    practiceVC.menuTag = 3;
    YRQuestionKindObj *quesKind = self.titleArray[indexPath.row];
    practiceVC.perfisonalKind = quesKind.id;
    practiceVC.objectFour = self.objFour;
    [self.navigationController pushViewController:practiceVC animated:YES];
}
@end
