//
//  SearchView.h
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/13.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseView.h"

@interface SearchView : BaseView<UITextFieldDelegate>
//---------------------------------------------------------------------------
//-------------------------------- 变量 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief   搜索栏
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UITextField * searchTextField;
/**
 @brief
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UIButton * cameraAndScanBtn;
//---------------------------------------------------------------------------
//-------------------------------- 方 法 ---------------------------------------
//---------------------------------------------------------------------------
@end
