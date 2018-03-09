//
//  BaseTableViewController.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/23.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;

}

#pragma mark - Table view data source
////单元格 组数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
// 单元格 组头 高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return _tableViewSectionsHeaderHeight;
//}
////单元格组头标题
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//        return nil;
//
//}
//单元格 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return _tableViewCellHeight;
}
//单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _tableViewCellNumberOfRows;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell * cell  = [[ BaseTableViewCell   alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@" BaseTableViewCell "];
    if (!cell) {
        cell  = [[ BaseTableViewCell   alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"  BaseTableViewCell"];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
