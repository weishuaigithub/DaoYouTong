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
    [self addCameraAndScanButton];
}
//添加搜索栏
-(void)addSearchTextFiled
{
    _searchTextField = [[UITextField alloc]init];
    _searchTextField.frame = CGRectMake(kWidth*.05, kHeight*.1,kWidth*.7, kHeight*.8);
    //边框样式 ：为none 时 才可以添加背景图片
    _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
//    _searchTextField.borderStyle = UITextBorderStyleNone;
//    _searchTextField.background = [UIImage imageNamed:@""];
    _searchTextField.delegate = self;
    //提示字体
    _searchTextField.placeholder = @"搜索:城市、景点、导游...";
    [self addSubview:_searchTextField];
    
}
-(void)addCameraAndScanButton
{
    _cameraAndScanBtn  = [[UIButton alloc]init];
    _cameraAndScanBtn.frame = CGRectMake(kWidth*.8, kHeight*.2,kWidth*.15,kHeight*.6);
    _cameraAndScanBtn.backgroundColor =[UIColor greenColor];
    [_cameraAndScanBtn setImage:[UIImage imageNamed:@"camera01.png"] forState:UIControlStateNormal];
    [self addSubview: _cameraAndScanBtn];
    
    
}
//按钮 点击 撤销键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //回收键盘
    [textField resignFirstResponder];
    return YES;
}
@end
