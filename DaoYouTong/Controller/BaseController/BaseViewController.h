//
//  BaseViewController.h
//  PrivateGuide
//
//  Created by 魏帅 on 2017/8/22.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
//---------------------------------------------------------------------------
//-------------------------------- 变量 ---------------------------------------
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
//-------------------------------- 方 法 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief  隐藏导航栏
 @discussion   null
 @author        魏帅
 */
-(void)hideNavigation;
/**
 @brief 显示导航栏
 @discussion   null
 @author        魏帅
 */
-(void)showNavigation;
/**
 @brief  隐藏tabber栏
 @discussion   null
 @author        魏帅
 */
-(void)hideTabbar;
/**
 @brief 显示tabber 栏
 @discussion   null
 @author        魏帅
 */
-(void)showTabber;
/**
 @brief  撤销键盘
 @discussion   null
 @author        魏帅
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
@end
