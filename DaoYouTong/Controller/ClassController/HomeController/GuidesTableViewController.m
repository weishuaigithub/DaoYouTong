//
//  HomeTableViewController.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/24.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "GuidesTableViewController.h"
#import "GuidesTableViewCell.h"//单元格
@interface GuidesTableViewController ()

@end

@implementation GuidesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置视图
//    [self setUI];
}
//设置视图
-(void)setUI
{
//    self.tableView.delegate = self;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuidesTableViewCell * cell  = [[ GuidesTableViewCell   alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@" GuidesTableViewCell "];
    if (!cell) {
        cell  = [[ GuidesTableViewCell   alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GuidesTableViewCell"];
    }
    
    return cell;
}
//单元格点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   //点击后 由主界面 跳转到 地图界面
    NSLog(@"跳转1！");
    [self.baseTableVCDelegate protocolMethodOfDidSelectCellWithIndexPath:indexPath];

   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
