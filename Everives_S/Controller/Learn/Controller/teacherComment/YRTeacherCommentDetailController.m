//
//  YRTeacherCommentDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherCommentDetailController.h"
#import "YRTeacherCommentDetailHeadView.h"
@interface YRTeacherCommentDetailController ()
@property (nonatomic, strong) YRTeacherCommentDetailHeadView *commentDetailHeadView;
@end

@implementation YRTeacherCommentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    self.tableView.tableHeaderView = self.commentDetailHeadView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(YRTeacherCommentDetailHeadView *)commentDetailHeadView
{
    if (_commentDetailHeadView == nil) {
        _commentDetailHeadView = [[YRTeacherCommentDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.43)];
        _commentDetailHeadView.backgroundColor = kCOLOR(241, 241, 241);
        [self.view addSubview:_commentDetailHeadView];
    }
    return _commentDetailHeadView;
}
@end
