//
//  BaseView.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/4.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (void)drawRect:(CGRect)rect {
    
    [self setUI];
    
}
-(void)setUI
{
    
}
//显示信息 Label 这里显示天气数据
-(UILabel *)AddShowInfoLabelOfContent:(NSString *)infoContentString  WithX:(CGFloat)X WithY:(CGFloat)Y WithWeight:(CGFloat)labelWeight  WithHeight:(CGFloat)labelHeight
{
    _infoLabel  = [[UILabel alloc]init];//初始化
    _infoLabel.text  =  infoContentString;//显示信息
    _infoLabel.frame  = CGRectMake(X, Y, labelWeight, labelHeight);//确定位置大小
    _infoLabel.textAlignment = NSTextAlignmentCenter;//字体居中
    
    
    
    return _infoLabel;
}

@end
