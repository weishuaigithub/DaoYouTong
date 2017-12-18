//
//  WeatherView.h
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/8.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseView.h"

@interface WeatherView : BaseView
//---------------------------------------------------------------------------
//-------------------------------- 变量 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief    显示城市位置 label
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * cityPositionLabel;
/**
 @brief  显示温度 label
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * temperatureLabel;
/**
 @brief   日期
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * dateLabel;
/**
 @brief  星期
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * weekLabel;
/**
 @brief  农历
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * theLunarCalendarLabel;
/**
 @brief  明天天气
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * tomorrowWeatherLabel;
/**
 @brief   后天天气
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel *  theDayAfterTomorrowWeatherLabel;
/**
 @brief   降雨
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel *  rainfallLabel;
/**
 @brief  空气指数
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * airIndexLabel;
/**
 @brief   天气详情按钮
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UIButton *  detailsOfTheWeatherButton;
@end
