//
//  HomeViewController.m
//  PrivateGuide
//
//  Created by 魏帅 on 2017/11/28.
//  Copyright © 2017年 魏帅. All rights reserved.
//
//首页视图
#import "HomeViewController.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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
    // 0.定位城市 并且获取天气信息（400/每小时，可以注册多账号）
    //滑动区：由单元格选择区（第一步）  和 单元格头视图 （第二步）组成。
    //一 景点导游选择区
    [self addGuidesView];
    //滑动背景
    //    [self addBackgroundScrollView];
    //二.在背景视图上添加其他功能区：天气，搜索，功能键。。。
    [self addBackgroundView];
   
    
    

}
////0.滑动背景视图
//-(void)addBackgroundScrollView
//{
//    //添加背景滑动视图
//    _backScrollV = [[UIScrollView alloc]init];
//    _backScrollV.frame  = CGRectMake(0, 0, kViewWidth, kViewHeight-44);//展示窗口大小
//    _backScrollV.contentSize = CGSizeMake(kViewWidth, kViewHeight-20-44+kViewHeight/3);//ios11以下，内容视图大小,等于*1 时，不会下降20px,因此只能调整其他控件 上升20px
////    NSLog(@"backScrollV.contentSize   is %@",_backScrollV );
//    _backScrollV.showsVerticalScrollIndicator = FALSE;//取消 竖向滚动条
//    //    _backScrollV.showsHorizontalScrollIndicator = FALSE;
//    _backScrollV.backgroundColor = BACKGROUNDCOLOR;
////    _backScrollV.backgroundColor = [UIColor redColor];
//    if(@available(iOS 11.0, *)){
//        _backScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
//    [self.view  addSubview:_backScrollV];
//
//}
// 0.定位城市 并且获取天气信息（400/每小时，可以注册多账号）
-(void)addLocationAddWeather
{
    
    
    
}
//一.景点选择区
-(void)addGuidesView
{
    if (!_guidesTableVC) {
        _guidesTableVC  = [[GuidesTableViewController alloc]init];
    }
    //设置头视图高度，把其他视图加入单元格头视图
    _guidesTableVC.view.frame = CGRectMake(0, 0,kViewWidth,kViewHeight-44);
    
    
    //    _guidesTableVC.tableViewSectionsHeaderHeight = kViewHeight/3+kViewHeight/10+(kViewWidth/2+30);
    
    _guidesTableVC.tableViewCellNumberOfRows = 10;//单元格行数
    _guidesTableVC.tableViewCellHeight = 80.0;//单元格 高度
    [self.view addSubview:_guidesTableVC.view];
}
//二.背景视图
-(void)addBackgroundView
{
    //用来自定义单元格头视图
    _backGroundV = [[UIView alloc]init];
    _backGroundV.frame = CGRectMake(0, 0,kViewWidth,kViewHeight/3+kViewHeight/10+(kViewWidth/3));
    //    //1.顶部天气视图
    [self addWeatherView];
    //    //2.搜索视图
    [self addSearchView];
    //    //3.功能按钮区视图
//    [self addFunctionalKeysView];
    //4 添加横向滚动功能键区
    [self addFunctionKeysCollectionView];
    //在这里要单独定制头视图，不然会遮盖下面的单元格
    _guidesTableVC.tableView.tableHeaderView  =_backGroundV;
  

}

//1.顶部天气视图
-(void)addWeatherView
{
    _weatherV  = [[WeatherView alloc]init];
    _weatherV.frame =  CGRectMake(0, 0, kViewWidth, kViewHeight/3);
    _weatherV.backgroundColor = [UIColor blueColor];
    [_backGroundV  addSubview: _weatherV];
    
    
}
//2.搜索栏视图
-(void)addSearchView
{
    //添加视图
    _searchV = [[SearchView alloc]init];
    _searchV.frame = CGRectMake(0, kViewHeight/3, kViewWidth, kViewHeight/10);
    _searchV.backgroundColor = [UIColor greenColor];
    [_backGroundV addSubview:_searchV];
}
//3.功能菜单区视图
-(void)addFunctionalKeysView
{
    _functionalKeysV  = [[FunctionalKeysView alloc]init];
    _functionalKeysV.frame = CGRectMake(0, kViewHeight/3+kViewHeight/10, kViewWidth, kViewWidth/4+30);
    _functionalKeysV.backgroundColor = [UIColor orangeColor];
    [_backGroundV addSubview:_functionalKeysV];
}
//4.添加Collectionview
-(void)addFunctionKeysCollectionView
{
    if (!_functionalKeysCollectionVC) {
        _functionalKeysCollectionVC  = [[FunctionKeysViewController alloc]init];

    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置UICollectionView为横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每一行cell之间的间距
    flowLayout.minimumLineSpacing = 50;
    // 设置第一个cell和最后一个cell,与父控件之间的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _functionalKeysCollectionVC.view = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHeight/3+kViewHeight/10, kViewWidth, kViewWidth/3)];
   _functionalKeysCollectionVC.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, kViewWidth/3-10) collectionViewLayout:flowLayout];
    _functionalKeysCollectionVC.collectionV.backgroundColor = [UIColor grayColor];
//    [self addChildViewController:_functionalKeysCollectionVC];
    [_functionalKeysCollectionVC.view addSubview:_functionalKeysCollectionVC.collectionV];
    [_backGroundV addSubview:_functionalKeysCollectionVC.view];
    
    
    
//    if (!_keysCollectionVC) {
//        _keysCollectionVC  = [[KeysCollectionViewController alloc]init];
//
//    }
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    // 设置UICollectionView为横向滚动
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    // 每一行cell之间的间距
//    flowLayout.minimumLineSpacing = 50;
//    // 设置第一个cell和最后一个cell,与父控件之间的间距
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
//
//    _keysCollectionVC.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kViewHeight/3+kViewHeight/10, kViewWidth, kViewWidth/3) collectionViewLayout:flowLayout];
//    _keysCollectionVC.view.backgroundColor = [UIColor grayColor];
////    [self addChildViewController:_keysCollectionVC];
//    [_backGroundV addSubview:_keysCollectionVC.collectionView ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
