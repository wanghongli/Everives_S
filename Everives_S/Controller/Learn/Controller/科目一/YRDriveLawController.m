//
//  YRDriveLawController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRDriveLawController.h"
#import "YRDriveLawCell.h"
@interface YRDriveLawController ()

@end

@implementation YRDriveLawController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"驾考法规";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YRDriveLawCell" bundle:nil] forCellReuseIdentifier:@"lawID"];
    self.tableView.tableFooterView = [[UIView alloc]init];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"lawID";
    
    YRDriveLawCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRDriveLawCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.headLabel.layer.masksToBounds = YES;
    cell.headLabel.layer.cornerRadius = cell.headLabel.height/2;
    cell.headLabel.layer.borderWidth = 2;
    cell.headLabel.layer.borderColor = [self randomColor].CGColor;
    cell.headLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    return cell;
}
- (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
