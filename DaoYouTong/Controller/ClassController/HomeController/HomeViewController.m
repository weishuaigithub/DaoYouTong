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
    //0.滑动背景
//    [self addBackgroundScrollView];
    //4.导游选择区
    [self addGuidesView];
    
    //1.顶部天气视图
    [self addWeatherView];
    //2.搜索视图
    [self addSearchView];
    //3.功能按钮区视图
    [self addFunctionalKeysView];
    

}
//0.滑动背景
-(void)addBackgroundScrollView
{
    //添加背景滑动视图
    _backScrollV = [[UIScrollView alloc]init];
    _backScrollV.frame  = CGRectMake(0, 0, kViewWidth, kViewHeight-44);//展示窗口大小
    _backScrollV.contentSize = CGSizeMake(kViewWidth, kViewHeight-20-44+kViewHeight/3);//ios11以下，内容视图大小,等于*1 时，不会下降20px,因此只能调整其他控件 上升20px
//    NSLog(@"backScrollV.contentSize   is %@",_backScrollV );
    _backScrollV.showsVerticalScrollIndicator = FALSE;//取消 竖向滚动条
    //    _backScrollV.showsHorizontalScrollIndicator = FALSE;
    _backScrollV.backgroundColor = BACKGROUNDCOLOR;
//    _backScrollV.backgroundColor = [UIColor redColor];
    if(@available(iOS 11.0, *)){
        _backScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view  addSubview:_backScrollV];
    
}


//4.导游选择区
-(void)addGuidesView
{
    if (!_guidesTableVC) {
        _guidesTableVC  = [[GuidesTableViewController alloc]init];
    }
    //设置头视图高度，把其他视图加入单元格头视图
    _guidesTableVC.tableViewSectionsHeaderHeight = kViewHeight/3+kViewHeight/10+(kViewWidth/2+30);
    _guidesTableVC.tableViewCellNumberOfRows = 10;//单元格行数
    _guidesTableVC.tableViewCellHeight = 80.0;//单元格 高度
    _guidesTableVC.view.frame = CGRectMake(0, kViewHeight/3+kViewHeight/10+(kViewWidth/2+30), kViewWidth, _backScrollV.contentSize.height-(kViewHeight/3+kViewHeight/10+(kViewWidth/2+30)));
    [_backScrollV addSubview:_guidesTableVC.view];
}

//1.顶部天气视图
-(void)addWeatherView
{
    _weatherV  = [[WeatherView alloc]init];
    _weatherV.frame =  CGRectMake(0, 0, kViewWidth, kViewHeight/3);
    _weatherV.backgroundColor = [UIColor blueColor];
    [_guidesTableVC.view addSubview: _weatherV];
    
    
}
//2.搜索栏视图
-(void)addSearchView
{
    //添加视图
    _searchV = [[SearchView alloc]init];
    _searchV.frame = CGRectMake(0, kViewHeight/3, kViewWidth, kViewHeight/10);
    _searchV.backgroundColor = [UIColor greenColor];
    [_guidesTableVC.view addSubview:_searchV];
}
//3.功能菜单区视图
-(void)addFunctionalKeysView
{
    _functionalKeysV  = [[FunctionalKeysView alloc]init];
    _functionalKeysV.frame = CGRectMake(0, kViewHeight/3+kViewHeight/10, kViewWidth, kViewWidth/2+30);
    _functionalKeysV.backgroundColor = [UIColor orangeColor];
    [_guidesTableVC.view addSubview:_functionalKeysV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
