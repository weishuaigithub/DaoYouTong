//
//  BaseTabBarController.m
//  PrivateGuide
//
//  Created by 魏帅 on 2017/11/28.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"//主页
#import "NewsViewController.h"//消息
#import "DetailsViewController.h"//详情
#import "MyViewController.h"//我的
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setClassController];


}
-(void)setClassController
{
    HomeViewController * HomeVC  = [[HomeViewController alloc]init];
    NewsViewController * NewsVC  = [[NewsViewController alloc]init];
    DetailsViewController * DetailsVC  = [[DetailsViewController alloc]init];
    MyViewController * MyVC = [[MyViewController alloc]init];
   //标题
    HomeVC.title  = @"主页";
    NewsVC.title  = @"消息";
    DetailsVC.title  = @"详情";
    MyVC.title  = @"我的";
    
    
    
    //设置tab栏字体颜色选择状态
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:27.0/255.0 green:94.0/255.0 blue:168.0/255.0 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:11.0f]}            forState:UIControlStateSelected];//选中时
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:11.0f]}            forState:UIControlStateNormal];//未选中时
    
    //默认选择第一个 选项
    self.tabBarController.selectedIndex = 0;

    NSArray * tabArrays = [[NSArray alloc]initWithObjects:
                           [self classNavigationInit:HomeVC withImage:[UIImage imageNamed:@"Home_uncheck.png"]],
                           [self classNavigationInit:NewsVC  withImage:[UIImage imageNamed:@"news_uncheck.png"]],
                           [self classNavigationInit:DetailsVC  withImage:[UIImage imageNamed:@"Detail_uncheck.png"]],
                           [self classNavigationInit:MyVC  withImage:[UIImage imageNamed:@"My_uncheck.png"]],nil];
    self.viewControllers = tabArrays;
}
//tabBar控制器 图片设置
-(UINavigationController *)classNavigationInit:(UIViewController *)controller  withImage:(UIImage *)image {
    
    UINavigationController * navigationController  = [[UINavigationController alloc]initWithRootViewController:controller];
    navigationController.tabBarItem.image = image;
    return navigationController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
