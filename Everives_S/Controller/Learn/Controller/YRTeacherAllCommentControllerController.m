//
//  YRTeacherAllCommentControllerController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/14.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherAllCommentControllerController.h"
#import "YRTeacherCommentObj.h"
#import "YRTeacherCommentCell.h"
@interface YRTeacherAllCommentControllerController ()
@property (nonatomic, strong) NSMutableArray *commentArray;
@end

@implementation YRTeacherAllCommentControllerController
-(NSMutableArray *)commentArray
{
    if (_commentArray==nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评价";
    [self getData];
    self.tableView.tableFooterView = [[UIView alloc]init];
}
-(void)getData
{
    [RequestData GET:[NSString stringWithFormat:@"/account/teaComment/%ld",self.teacherID] parameters:@{@"page":@"0"} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        NSArray *array = [YRTeacherCommentObj mj_objectArrayWithKeyValuesArray:responseDic];
        self.commentArray = [NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    YRTeacherCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRTeacherCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    // Configure the cell...
    YRTeacherCommentObj *commentObj = self.commentArray[indexPath.row];
    cell.teacherCommentObj = commentObj;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRTeacherCommentObj *commentObj = self.commentArray[indexPath.row];

    return [YRTeacherCommentCell getTeacherCommentCellHeightWith:commentObj];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
