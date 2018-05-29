//
//  HomeViewController.h
//  PrivateGuide
//
//  Created by 魏帅 on 2017/11/28.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseViewController.h"
#import "WeatherView.h"//天气视图
#import "SearchView.h"//搜索视图
#import "FunctionalKeysView.h"//功能按钮视图
#import "GuidesTableViewController.h"//导游员列表视图
#import "HmacSha1Tool.h"//心知天气
@interface HomeViewController : BaseViewController
//---------------------------------------------------------------------------
//-------------------------------- 变量 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief   滚动背景视图
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UIScrollView * backScrollV;
/**
 @brief   背景视图
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UIView * backGroundV;
/**
 @brief   天气
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) WeatherView * weatherV;
/**
 @brief  搜索
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) SearchView * searchV;
/**
 @brief  功能按钮区 视图
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) FunctionalKeysView * functionalKeysV;
/**
 @brief  横向滚动功能键区
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UICollectionView * collectionV ;
/**
 @brief   导游员列表视图
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) GuidesTableViewController * guidesTableVC;


//---------------------------------------------------------------------------
//-------------------------------- 方 法 ---------------------------------------
//---------------------------------------------------------------------------
@end
