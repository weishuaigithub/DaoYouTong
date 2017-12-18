//
//  HomeViewController.m
//  PrivateGuide
//
//  Created by 魏帅 on 2017/11/28.
//  Copyright © 2017年 魏帅. All rights reserved.
//
//首页视图
#import "HomeViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置视图
    [self setUI];
}
//设置视图
-(void)setUI
{
    _homeV  = [[HomeView alloc]initWithFrame:self.view.bounds];
    _homeV.backgroundColor = BACKGROUNDCOLOR;//背景白色
    [self.view addSubview: _homeV];
    //1.顶部天气视图
    //2.搜索栏
    //3.功能菜单区
    //4.导游选择区
    

}
//1.顶部天气视图
//2.搜索栏
//3.功能菜单区
//4.导游选择区
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
