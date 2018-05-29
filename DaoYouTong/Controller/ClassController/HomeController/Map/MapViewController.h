//
//  MapViewController.h
//  DaoYouTong
//
//  Created by 魏帅 on 2018/5/19.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import "BaseViewController.h"

@interface MapViewController : BaseViewController<BMKMapViewDelegate,BMKRouteSearchDelegate>
//---------------------------------------------------------------------------
//-------------------------------- 变量 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief   百度地图
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) BMKMapView* mapView;

//---------------------------------------------------------------------------
//-------------------------------- 方 法 ---------------------------------------
//---------------------------------------------------------------------------

@end
