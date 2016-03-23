//
//  YRCoachCellDetailVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCoachCellDetailVC.h"
#import "UIImage+Tool.h"
#import "YRReservationDateVC.h"
@interface YRCoachCellDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation YRCoachCellDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _table.delegate = self;
    _table.dataSource = self;
    [self addToolBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.imageView.image = [UIImage imageNamed:@"Neig_Coach_Field"];
    return cell;
}
-(void)addToolBarItem{
    _toolBar.tintColor = [UIColor whiteColor];
    UIButton *addFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image1 = [UIImage imageNamed:@"Neig_Coach_AddContac"];
    image1 = [image1 transformtoSize:CGSizeMake(30, 30)];
    [addFriendButton setImage:image1 forState:UIControlStateNormal];
    [addFriendButton setTitle:@"关注" forState:UIControlStateNormal];
    addFriendButton.frame = (CGRect) {
        .size.width = kScreenWidth/2,
        .size.height = 30,
    };

    UIButton *reservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image2 = [UIImage imageNamed:@"Neig_Coach_Bespeak"];
    image2 = [image2 transformtoSize:CGSizeMake(30, 30)];
    [reservationButton setImage:image2 forState:UIControlStateNormal];
    [reservationButton setTitle:@"预约" forState:UIControlStateNormal];
    reservationButton.titleLabel.textColor = [UIColor blackColor];
    reservationButton.frame = (CGRect) {
        .size.width = kScreenWidth/2,
        .size.height = 30,
    };
    [reservationButton addTarget:self action:@selector(reservationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton1= [[UIBarButtonItem alloc] initWithCustomView:addFriendButton];
    UIBarButtonItem *barButton2= [[UIBarButtonItem alloc] initWithCustomView:reservationButton];
    self.toolBar.items = @[barButton1,barButton2];
}
-(void)reservationBtnClick{
    YRReservationDateVC *datePicker = [[YRReservationDateVC alloc]init];
    datePicker.coachID = _coachID;
    [self.navigationController pushViewController:datePicker animated:YES];
}
@end
