//
//  SearchView.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/13.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

- (void)drawRect:(CGRect)rect {
    
    [self setUI];
    
}
-(void)setUI
{
    [self addSearchTextFiled];
}
//添加搜索栏
-(void)addSearchTextFiled
{
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.frame = CGRectMake(kWidth*.15, kHeight*.1,kWidth*.7, kHeight*.8);
    //边框样式 ：为none 时 才可以添加背景图片
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _searchTextField.borderStyle = UITextBorderStyleNone;
//    _searchTextField.background = [UIImage imageNamed:@""];
    //提示字体
    _searchTextField.placeholder = @"搜索:城市、景点...";
    [self addSubview:_searchTextField];
    
}
-(void)addCameraAndScanButton
{
    _cameraAndScanBtn  = [[UIButton alloc]init];
    _cameraAndScanBtn.frame = CGRectMake(kWidth*.85, kHeight*.1, kHeight*.1, kWidth*.15);
    _cameraAndScanBtn.backgroundColor =[UIColor greenColor];
    [_cameraAndScanBtn setImage:@"" forState:UIControlStateNormal];
    [self addSubview: _cameraAndScanBtn];
    
    
}

@end
