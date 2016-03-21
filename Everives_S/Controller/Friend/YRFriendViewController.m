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
@end

@implementation YRFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_GROUP),]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_GROUP)]];
    [self addNavItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重载函数，onSelectedTableRow 是选择会话列表之后的事件
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    YRChatViewController *conversationVC = [[YRChatViewController alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    UIBarButtonItem *findItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Friend_Search"] style:UIBarButtonItemStylePlain target:self action:@selector(findBtnClick:)];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Friend_AddFri"] style:UIBarButtonItemStylePlain target:self action:@selector(addBtnClick:)];
    UIBarButtonItem *contactItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Friend_PhoneBook"] style:UIBarButtonItemStylePlain target:self action:@selector(contactBtnClick:)];
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
-(void)addFriendBtnClick:(UIButton*)sender{
    [self.navigationController pushViewController:[[YRAddFriendVC alloc] init] animated:YES];
    [self.addView removeFromSuperview];
    addViewIsHidden = YES;
}
-(void)addGroupBtnClick:(UIButton*)sender{
    YRContactVC *contact = [[YRContactVC alloc] init];
    contact.isAllowSelected = YES;
    [self.navigationController pushViewController:contact animated:YES];
    [self.addView removeFromSuperview];
    addViewIsHidden = YES;
}
@end
