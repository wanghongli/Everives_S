//
//  YRAddFriendVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAddFriendVC.h"
#import "RequestData.h"
#import "YRUserStatus.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import "YRUserDetailController.h"
#import "YRSearchFriendCell.h"
#import <AddressBook/AddressBook.h>
#import "RequestData.h"
#import "YRSearchBar.h"
static NSString *cellID = @"cellID";
@interface YRAddFriendVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSArray *_resArray;
}
@property(nonatomic,strong) YRSearchBar *searchBar;
@property(nonatomic,strong) UIButton *phoneContact;
@property(nonatomic,strong) UITableView *resTable;
@end

@implementation YRAddFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加驾友";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.phoneContact];
    [self.view addSubview:self.resTable];

}
-(void)phoneContactBtnClick:(UIButton*)sender{
    [self loadPerson];
}

- (void)loadPerson
{
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            CFErrorRef *error1 = NULL;
            ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error1);
            [self copyAddressBook:addressBook];
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        CFErrorRef *error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
        [self copyAddressBook:addressBook];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    }
}

- (void)copyAddressBook:(ABAddressBookRef)addressBook
{
    NSMutableArray *parameterVlaue = [NSMutableArray array];
    CFIndex numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for ( int i = 0; i < numberOfPeople; i++){
        
        ABRecordRef person = CFArrayGetValueAtIndex(people, i);
        
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        
        //读取电话多值
        NSString * personPhoneLabel;
        NSString * personPhone;
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
        }
        if ([personPhone containsString:@"+86"]) {
            personPhone = [personPhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        }
        if ([personPhone containsString:@"-"]) {
            personPhone = [personPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        if ([personPhone containsString:@" "]) {
            personPhone = [personPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        NSString *phoneName = [NSString stringWithFormat:@"%@%@",firstName?:@"",lastName?:@""];
        if ([phoneName isEqualToString:@""] || !personPhone) {
            continue;
        }
        [parameterVlaue addObject:personPhone];
    }
    NSDictionary *parameters = @{@"data":[parameterVlaue mj_JSONString]};
    [MBProgressHUD showMessag:@"数据请求中..." toView:self.view];
    [RequestData POST:STUDENT_CONTACT parameters:parameters complete:^(NSDictionary *responseDic) {
        _resArray = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        [_resTable reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSString *searchStr = [_searchBar.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (searchStr.length != 11) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"手机号不正确" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if ([searchStr isEqualToString:KUserManager.tel]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"不能添加自己为好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSString *s = [NSString stringWithFormat:@"%@%@",STUDENT_SEARCH_USER,[searchStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",s);
    [RequestData GET:[NSString stringWithFormat:@"%@%@",STUDENT_SEARCH_USER,[searchStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]  parameters:@{@"relation":@"0"} complete:^(NSDictionary *responseDic) {
        _resArray = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        if (_resArray.count == 0) {
            [MBProgressHUD showSuccess:@"没有找到符合条件的用户~" toView:self.view];
        }else{
            [_resTable reloadData];
        }
    } failed:^(NSError *error) {
        
    }];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSString *searchStr = [_searchBar.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (searchStr.length != 0) {
        return;
    }
    searchBar.text = @"    ";
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSString *searchStr = [_searchBar.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (searchStr.length == 0) {
        searchBar.text =@"";
    }
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *searchStr = [_searchBar.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (searchStr.length == 0) {
        searchBar.text = @"    ";
    }
}
#pragma mark - UItableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRSearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (!cell) {
        cell = [[YRSearchFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:[_resArray[indexPath.row] avatar]]placeholderImage:[UIImage imageNamed:@"Identification_NameGray"]];
    cell.name.text = [_resArray[indexPath.row] name];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YRUserDetailController *userDetailVC = [[YRUserDetailController alloc] init];
    userDetailVC.userID = [_resArray[indexPath.row] id];
    [self.navigationController pushViewController:userDetailVC animated:YES];
}
#pragma mark - Getters
-(YRSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[YRSearchBar alloc] initWithFrame:CGRectMake(16, 8, kScreenWidth-32, 44)];
        _searchBar.searchBar.delegate = self;
        _searchBar.searchBar.placeholder = @"请输入驾友用户名或手机号码";

    }
    return _searchBar;
}
-(UIButton *)phoneContact{
    if (!_phoneContact) {
        _phoneContact = [[UIButton alloc] initWithFrame:CGRectMake(16, 60, kScreenWidth-32, 44)];
        [_phoneContact setTitle:@"关注手机联系人" forState:UIControlStateNormal];
        [_phoneContact setImage:[UIImage imageNamed:@"Friend_AddFri_Contacts"] forState:UIControlStateNormal];
        [_phoneContact setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_phoneContact addTarget:self action:@selector(phoneContactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _phoneContact.layer.masksToBounds = YES;
        _phoneContact.layer.cornerRadius = 22;
        _phoneContact.layer.borderColor = [UIColor blackColor].CGColor;
        _phoneContact.layer.borderWidth = 0.5;
    }
    return _phoneContact;
}
-(UITableView *)resTable{
    if (!_resTable) {
        _resTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 111, kScreenWidth, kScreenHeight)];
        _resTable.tableFooterView = [[UIView alloc] init];
        _resTable.rowHeight = 60;
        _resTable.delegate = self;
        _resTable.dataSource = self;
        [_resTable registerNib:[UINib nibWithNibName:@"YRSearchFriendCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _resTable;
}
@end
