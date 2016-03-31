//
//  YRPullListView.m
//  Everives_S
//
//  Created by darkclouds on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPullListView.h"
@interface YRPullListView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *tables;
//这个数组的每个元素是数组
@property(nonatomic,strong) NSArray *itemArrays;
@property(nonatomic,assign) NSInteger tableNum;
@property(nonatomic,assign) CGFloat tableWidth;
@property(nonatomic,assign) CGFloat tableHeight;
@property(nonatomic,strong,readwrite) NSMutableArray *selectedArray;
@end
@implementation YRPullListView

-(instancetype)initWithFrame:(CGRect)frame itemArray:(NSArray *)array{
    if (self = [super initWithFrame:frame]) {
        _cellHeight = 40;
        _itemArrays = array;
        _tableNum = array.count;
        _tableWidth = frame.size.width/_tableNum;
        _tableHeight = frame.size.height;
        _tables = @[].mutableCopy;
        _selectedArray = [NSMutableArray arrayWithCapacity:_tableNum];
        for (NSInteger i = 0; i<_tableNum; i++) {
            [self addSubview:self.tables[i]];
            _selectedArray[i] = @-1;
        }
    }
    return self;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_itemArrays[tableView.tag] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [_itemArrays[tableView.tag] objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedArray[tableView.tag] = [NSNumber numberWithInteger:indexPath.row];
    if(![_selectedArray containsObject:@-1]){
        [[NSNotificationCenter defaultCenter] postNotificationName:kFillterBtnRemovePullView object:nil];
    }
}
#pragma mark - Getters
-(NSArray *)tables{
    if (!_tables.count) {
        for (NSInteger i = 0; i < _tableNum; i++) {
            UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(i*_tableWidth, 0, _tableWidth, _tableHeight)];
            table.rowHeight = _cellHeight;
            table.tag = i;
            table.dataSource = self;
            table.delegate = self;
            table.tableFooterView = [[UIView alloc] init];
            [_tables addObject:table];
        }
    }
    return _tables;
}
@end
