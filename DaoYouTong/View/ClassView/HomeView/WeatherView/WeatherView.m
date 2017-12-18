//
//  WeatherView.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/8.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "WeatherView.h"
@implementation WeatherView

- (void)drawRect:(CGRect)rect {
    
    [self setUI];
    
}
-(void)setUI
{
    [self addCityPositionLabel];//添加城市地区
    [self addWeekLabel];//添加星期
    [self addTemperatureLabel];//添加温度
    [self addDateLabel];//添加日期
    [self addTheLunarCalendarLabel];//添加农历
    [self addTomorrowWeatherLabel ];//添加明天天气
    [self  addTheDayAfterTomorrowWeatherLabel ];//添加 后天天气
    [self  addRainFallLabel];//添加 降雨
    [self  addAirIndexLabel];//添加  空气指数
    [self  addDetailsOfTheWeatherButton];//添加 进入天气详情按钮
}
//显示地区
-(void)addCityPositionLabel
{
    //注意 这个方法不自动提示？？？
    _cityPositionLabel  = [self AddShowInfoLabelOfContent:@"济宁·邹城"  WithX:0 WithY:15 WithWeight:kWidth/3 WithHeight:kHeight/5];
//    _cityPositionLabel.backgroundColor = [UIColor redColor];
    _cityPositionLabel.textColor = [UIColor whiteColor];
    [self addSubview: _cityPositionLabel];
    
    
}
//星期
-(void)addWeekLabel
{
    _weekLabel  = [self AddShowInfoLabelOfContent:@"周一"  WithX:kWidth*1.5/4 WithY:15 WithWeight:kWidth/4 WithHeight:kHeight/5];
//    _weekLabel.backgroundColor = [UIColor greenColor];
    _weekLabel.textColor = [UIColor whiteColor];
    [self addSubview: _weekLabel];
    
}
//显示温度
-(void)addTemperatureLabel
{
    _temperatureLabel  = [self AddShowInfoLabelOfContent:@"6"  WithX:kWidth/40 WithY:_cityPositionLabel.bottom WithWeight:kWidth/5 WithHeight:kHeight*2/5];
//    _temperatureLabel.backgroundColor = [UIColor greenColor];
    _temperatureLabel.textColor = [UIColor greenColor];
    _temperatureLabel.font = [UIFont systemFontOfSize: 54];
    [self addSubview: _temperatureLabel];
    
    
}
//显示日期    （星期 农历）
-(void)addDateLabel
{
    _dateLabel  = [self AddShowInfoLabelOfContent:@"2017年12月11日"  WithX:_temperatureLabel.right WithY:_cityPositionLabel.bottom WithWeight:kWidth/2 WithHeight:kHeight/5];
    _dateLabel.font = [UIFont systemFontOfSize: 12];
    _dateLabel.textColor = [UIColor whiteColor];
    
//    _dateLabel.backgroundColor = [UIColor redColor];
    [self addSubview: _dateLabel];
     
    
}

//农历
-(void)addTheLunarCalendarLabel
{
    _theLunarCalendarLabel  = [self AddShowInfoLabelOfContent:@"农历 十月二十四"  WithX:_temperatureLabel.right WithY:_dateLabel.bottom WithWeight:kWidth/2 WithHeight:kHeight/5];
    _theLunarCalendarLabel.font = [UIFont systemFontOfSize: 12];
    _theLunarCalendarLabel.textColor = [UIColor whiteColor];
//    _theLunarCalendarLabel.backgroundColor = [UIColor redColor];
    [self addSubview: _theLunarCalendarLabel];
    
    
}
//显示明天、 后天天气
-(void)addTomorrowWeatherLabel
{
    _tomorrowWeatherLabel  = [self AddShowInfoLabelOfContent:@"周二  晴"  WithX:kWidth*3/4 WithY:_cityPositionLabel.bottom  WithWeight:kWidth/4 WithHeight:kHeight/5];
//    _tomorrowWeatherLabel.backgroundColor = [UIColor redColor];
    _tomorrowWeatherLabel.textColor = [UIColor whiteColor];
    [self addSubview: _tomorrowWeatherLabel];
}
//后天天气
-(void)addTheDayAfterTomorrowWeatherLabel
{

    _theDayAfterTomorrowWeatherLabel  = [self AddShowInfoLabelOfContent:@"周三 多云"  WithX:kWidth*3/4 WithY:_tomorrowWeatherLabel.bottom  WithWeight:kWidth/4 WithHeight:kHeight/5];
//    _theDayAfterTomorrowWeatherLabel.backgroundColor = [UIColor redColor];
    _theDayAfterTomorrowWeatherLabel.textColor = [UIColor whiteColor];
    [self addSubview: _theDayAfterTomorrowWeatherLabel];

}
//显示 天气 状况
-(void)addRainFallLabel
{
    _rainfallLabel  = [self AddShowInfoLabelOfContent:@"多云"  WithX:kWidth/40 WithY:_temperatureLabel.bottom WithWeight:kWidth/4 WithHeight:kHeight/5];
//    _rainfallLabel.backgroundColor = [UIColor redColor];
    _rainfallLabel.textColor = [UIColor whiteColor];
    [self addSubview: _rainfallLabel];

}
//显示空气指数
-(void)addAirIndexLabel
{
    NSString * airIndexString = [NSString stringWithFormat:@"空气指数:%d",50];
    _airIndexLabel  = [self AddShowInfoLabelOfContent:airIndexString  WithX:_rainfallLabel.right  WithY:_temperatureLabel.bottom WithWeight:kWidth/3 WithHeight:kHeight/5];
//    _airIndexLabel.backgroundColor = [UIColor redColor];
    _airIndexLabel.font = [UIFont systemFontOfSize: 12];
    _airIndexLabel.textColor = [UIColor whiteColor];
    [self addSubview: _airIndexLabel];

}
//进入天气详情页面 按钮
-(void)addDetailsOfTheWeatherButton
{
    _detailsOfTheWeatherButton = [[UIButton alloc]init];
    _detailsOfTheWeatherButton.frame = CGRectMake(kWidth*3/4, 15, kWidth/4, kHeight/5);
    [_detailsOfTheWeatherButton setTitle:@"详情" forState:UIControlStateNormal];
    [self addSubview:_detailsOfTheWeatherButton];
    

}



@end
