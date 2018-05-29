//
//  BaseViewController.m
//  PrivateGuide
//
//  Created by 魏帅 on 2017/8/22.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
-(void)viewWillAppear:(BOOL)animated
{
    //隐藏导航栏
//    [self hideNavigation];
}
- (void)viewDidLoad {
    
    self.automaticallyAdjustsScrollViewInsets = NO;//取消自动调整滑动视图位置
    
    [super viewDidLoad];
    //隐藏导航栏
    //设置视图
//    [self setUI];
}
//设置视图
-(void)setUI
{
    
}
//隐藏导航栏
-(void)hideNavigation
{
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
//显示导航栏
-(void)showNavigation
{
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
}
//隐藏tabbar 栏
-(void)hideTabbar
{
    //隐藏tarbar 栏
    self.tabBarController.tabBar.hidden = YES;
}

//显示 tabbar 栏
-(void)showTabber
{
    
    //显示tarbar 栏
    self.tabBarController.tabBar.hidden = NO;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
