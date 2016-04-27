//
//  YRFriendViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFriendViewController.h"
#import "YRChatViewController.h"
#import "REFrostedViewController.h"
#import "YRSearchFriendVC.h"
#import "YRAddFriendVC.h"
#import "YRContactVC.h"
#import "YRChatViewController.h"
static BOOL addViewIsHidden = YES;

@interface YRFriendViewController ()
@property(nonatomic,strong) UIView *addView;
@property(nonatomic,strong) UIView *emptyView;
@end

@implementation YRFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"驾友";
    self.emptyConversationView = self.emptyView;
    self.frostedViewController.panGestureEnabled = YES;
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_GROUP),]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
//    [self setCollectionConversationType:@[@(ConversationType_GROUP)]];
    
    self.conversationListTableView.tableFooterView = [[UIView alloc] init];
    [self addNavItem];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.addView removeFromSuperview];
    self.frostedViewController.panGestureEnabled = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.frostedViewController.panGestureEnabled = YES;
}
-(void)addFriendBtnClick:(UIButton*)sender{
    [self.navigationController pushViewController:[[YRAddFriendVC alloc] init] animated:YES];
    addViewIsHidden = YES;
}
-(void)addGroupBtnClick:(UIButton*)sender{
    YRContactVC *contact = [[YRContactVC alloc] init];
    contact.isAllowSelected = YES;
    [self.navigationController pushViewController:contact animated:YES];
    addViewIsHidden = YES;
}
//重载函数，onSelectedTableRow 是选择会话列表之后的事件
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    YRChatViewController *conversationVC = [[YRChatViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    conversationVC.unReadMessage = model.unreadMessageCount;
    conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
    conversationVC.enableUnreadMessageIcon=YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}

-(void)addNavItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu_icon"] highImage:[UIImage imageNamed:@"menu_icon"] target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *findItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Friend_Search"] highImage:[UIImage imageNamed:@"Friend_Search"] target:self action:@selector(findBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Friend_AddFri-1"] highImage:[UIImage imageNamed:@"Friend_AddFri-1"] target:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *contactItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Friend_PhoneBook"] highImage:[UIImage imageNamed:@"Friend_PhoneBook"] target:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[contactItem,addItem,findItem];
    

}
- (void)backBtnClick:(UIBarButtonItem*)sender{
    [self.frostedViewController presentMenuViewController];
}
-(void)addBtnClick:(UIBarButtonItem*)sender{
    
    if (addViewIsHidden) {
        [self.view addSubview:self.addView];
        addViewIsHidden = NO;
    }else{
        [self.addView removeFromSuperview];
        addViewIsHidden = YES;
    }
    
}
-(void)findBtnClick:(UIBarButtonItem*)sender{
    [self.navigationController pushViewController:[[YRSearchFriendVC alloc] init] animated:YES];
}
-(void)contactBtnClick:(UIBarButtonItem*)sender{
    [self.navigationController pushViewController:[[YRContactVC alloc] init] animated:YES];
}

-(UIView *)addView{
    if (!_addView) {
        _addView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 68, 150, 100)];
        _addView.layer.borderWidth = 0.5;
        _addView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _addView.backgroundColor = [UIColor whiteColor];
        _addView.layer.cornerRadius = 10;
        _addView.layer.masksToBounds = YES;
        
        UIButton *addFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        [addFriendBtn setTitle:@"添加朋友" forState:UIControlStateNormal];
        [addFriendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addFriendBtn addTarget:self action:@selector(addFriendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        addFriendBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        addFriendBtn.layer.borderWidth = 0.5;
        
        UIButton *addGroupBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 150, 50)];
        [addGroupBtn setTitle:@"发起群聊" forState:UIControlStateNormal];
        [addGroupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addGroupBtn addTarget:self action:@selector(addGroupBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        addGroupBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        addGroupBtn.layer.borderWidth = 0.5;
        
        [_addView addSubview:addFriendBtn];
        [_addView addSubview:addGroupBtn];
    }
    return _addView;
}
-(UIView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:self.view.frame];
        _emptyView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight/2, kScreenWidth, 20)];
        label.text = @"当前还没有消息哦~";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kFontOfLetterMedium;
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

@end
