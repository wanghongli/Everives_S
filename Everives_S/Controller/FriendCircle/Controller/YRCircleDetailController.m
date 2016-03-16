//
//  YRCircleDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleDetailController.h"
#import "YRCircleCellViewModel.h"
#import "YRWeibo.h"
#import "YRFriendCircleCell.h"
#import "YRCircleComment.h"
#import "YRCircleCommentCell.h"
#import "KGFreshCatchDetailCommentView.h"
#import "KGFreshCatchDetailZanView.h"
@interface YRCircleDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,KGFreshCatchDetailZanViewDelegate>
{
    BOOL _wasKeyboardManagerEnabled;
    
    NSMutableArray *_commentArray;
    NSMutableArray *_branceArray;
    CGFloat _keyboardheight;
    NSMutableDictionary *_commentBody;
    YRCircleCellViewModel *_cellFrameMsg;
}
@property (nonatomic, strong) NSMutableDictionary *bodyDic;
@property (weak, nonatomic) IBOutlet UITextField *commentText;

@property (weak, nonatomic) IBOutlet UIView *commentView;
- (IBAction)sendClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YRCircleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈详情";
    
    CGFloat tableHeight;
    tableHeight = kScreenHeight-24;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, tableHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.commentView];
    _branceArray = [NSMutableArray array];
    _commentArray = [NSMutableArray array];
    _commentBody = [NSMutableDictionary dictionary];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self getData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [_commentBody setObject:@"0" forKey:@"fid"];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"举报" style:UIBarButtonItemStyleBordered target:self action:@selector(jubaoClick)];
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    _keyboardheight=deltaY;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.commentView.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.commentView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - 发表评论
-(void)takeCommentWith
{
    [RequestData POST:WEIBO_ADD_COMMENT parameters:_commentBody complete:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        [self getData];
        self.commentText.text = @"";
        self.commentText.placeholder = @"说点什么吧~~~";
    } failed:^(NSError *error) {
        
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length) {
        [_commentBody setObject:textField.text forKey:@"content"];
    }
    return YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
//    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.commentText resignFirstResponder];
}
-(void)getData
{
    [_commentArray removeAllObjects];
    [_branceArray removeAllObjects];
    [MBProgressHUD showMessag:@"数据请求中..." toView:self.view];
    [RequestData GET:[NSString stringWithFormat:@"/seeds/seeds/%@",self.statusF.status.id] parameters:nil complete:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        YRWeibo *result = [YRWeibo mj_objectWithKeyValues:responseDic];
        _cellFrameMsg = [[YRCircleCellViewModel alloc]init];
        _cellFrameMsg.status = result;
        [_commentBody setObject:result.id forKey:@"sid"];
        
        if (result.comment.count) {
            [self getCommentMsgWith:result.comment];
        }
        
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark - 评论数据整理
-(void)getCommentMsgWith:(NSArray *)array
{
    for (int i = 0; i<array.count; i++) {
        YRCircleComment *child = array[i];
        [_commentArray addObject:child];
        
        NSMutableArray *branceArray = [NSMutableArray array];
        if (child.child.count) {
            [self getSecondCommentMsg:child.child withFormatChild:child withBranchArray:branceArray withOneOrSecond:NO];
        }
        [_branceArray addObject:branceArray];
    }
}
-(void)getSecondCommentMsg:(NSArray*)array withFormatChild:(YRCircleComment*)child withBranchArray:(NSMutableArray *)branchArray withOneOrSecond:(BOOL)oneOrTwo
{
    for (int j = 0; j<array.count; j++) {
        NSMutableArray *array2 = [NSMutableArray array];
        YRCircleComment *child1 = array[j];
        if (oneOrTwo) {
            [array2 addObject:child];
        }
        [array2 addObject:child1];
        [branchArray addObject:array2];
        if (child1.child.count) {
            [self getSecondCommentMsg:child1.child withFormatChild:child1 withBranchArray:branchArray withOneOrSecond:YES];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1+_commentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return [_branceArray[section - 1] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 创建cell
        YRFriendCircleCell *cell = [YRFriendCircleCell cellWithTableView:tableView];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        // 获取status模型
        YRCircleCellViewModel *statusF = _cellFrameMsg;
        // 给cell传递模型
        cell.statusF = statusF;
        cell.lineBool = YES;
        return cell;
    }else{
        
        YRCircleCommentCell *cell = [YRCircleCommentCell cellWithTableView:tableView];
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setUserNameTapClickBlock:^(YRCircleComment *user) {
//            [RequestData requestInfomationWithURI:USER_GETUSERINFO andParameters:@{@"id":[NSString stringWithFormat:@"%ld",(long)user.uid]} complete:^(NSDictionary *responseDic) {
//                
//                KGUserMsgController *msgVC = [[KGUserMsgController alloc]init];
//                msgVC.userMsg = [KGUserStatus mj_objectWithKeyValues:responseDic];
//                msgVC.notUserGetIn = YES;
//                [self.navigationController pushViewController:msgVC animated:YES];
//                
//            } failed:^(NSError *error) {
//                
//            }];
        }];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.array = _branceArray[indexPath.section-1][indexPath.row];
        return cell;
    }
}
// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _cellFrameMsg.cellHeight;
    }
    return [YRCircleCommentCell detailCommentCellWith:_branceArray[indexPath.section-1][indexPath.row]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 44;
    }else
        return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }else{
        CGFloat height = [KGFreshCatchDetailCommentView detailCommentViewWith:_commentArray[section - 1]];
        return height;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [[UIView alloc]init];
    }else{
        CGFloat height = [KGFreshCatchDetailCommentView detailCommentViewWith:_commentArray[section - 1]];
        KGFreshCatchDetailCommentView *zanView = [[KGFreshCatchDetailCommentView alloc]init];
        zanView.backgroundColor = [UIColor whiteColor];
        [zanView setReplyTapClickBlock:^(YRCircleComment *commentObject) {
            [_commentBody setObject:[NSString stringWithFormat:@"%ld",(long)commentObject.id] forKey:@"fid"];
            self.commentText.placeholder = [NSString stringWithFormat:@"%@回复:",commentObject.name];
            [self.commentText becomeFirstResponder];
            
        }];
        zanView.frame = CGRectMake(0, 0, kSizeOfScreen.width, height);
        zanView.comment = _commentArray[section - 1];
        if (section == 1) {
            zanView.topLineHidden = YES;
        }else{
            zanView.topLineHidden = NO;
        }
        return zanView;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        KGFreshCatchDetailZanView *zanView = [[KGFreshCatchDetailZanView alloc]init];
        
        zanView.frame = CGRectMake(0, 0, kSizeOfScreen.width, 44);
        zanView.statusArray = _cellFrameMsg.status.praiseMem;
        zanView.delegate = self;
        return zanView;
        
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSizeOfScreen.width, 1)];
        view.backgroundColor = kCOLOR(230, 230, 230);
        return view;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section !=0) {
        NSArray *array = _branceArray[indexPath.section-1][indexPath.row];
        if (array.count == 1) {
            YRCircleComment*commentObject = array[0];
            [_commentBody setObject:[NSString stringWithFormat:@"%ld",(long)commentObject.id] forKey:@"fid"];
            
            self.commentText.placeholder = [NSString stringWithFormat:@"%@回复:",commentObject.name];
            [self.commentText becomeFirstResponder];
        }else{
            YRCircleComment*commentObject = array[1];
            [_commentBody setObject:[NSString stringWithFormat:@"%ld",(long)commentObject.id] forKey:@"fid"];
            self.commentText.placeholder = [NSString stringWithFormat:@"%@回复:",commentObject.name];
            [self.commentText becomeFirstResponder];
        }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)sendClick:(UIButton *)sender {
    [self.commentText resignFirstResponder];
    [_commentBody setObject:self.commentText.text forKey:@"content"];
    [self takeCommentWith];
}

@end
