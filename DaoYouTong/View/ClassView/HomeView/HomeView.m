//
//  HomeView.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/4.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "HomeView.h"
#import "WeatherView.h"//天气视图
#import "SearchView.h"//搜索视图
@implementation HomeView
- (void)drawRect:(CGRect)rect {
    
    [self setUI];
    
}
-(void)setUI
{
    //1.顶部天气视图
    [self addWeatherView];
    //2.搜索视图
    [self addSearchView];
}
//1.顶部天气视图
-(void)addWeatherView
{
    WeatherView * weatherV  = [[WeatherView alloc]init];
    weatherV.frame =  CGRectMake(0, 0, kWidth, kHeight/3);
    weatherV.backgroundColor = [UIColor blueColor];
    [self addSubview: weatherV];
    
    
}
//2.搜索栏视图
-(void)addSearchView
{
   //添加视图
    SearchView * searchV  = [[SearchView alloc]init];
    searchV.frame = CGRectMake(0, kHeight/3, kWidth, kHeight/10);
    searchV.backgroundColor = [UIColor greenColor];
    [self addSubview:searchV];
}
//3.功能菜单区视图
//4.导游选择区视图
@end
