//
//  BaseTableViewCell.h
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/23.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
//---------------------------------------------------------------------------
//-------------------------------- 变量 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief   自定义 单元格底部线 样式一：空出左部图片
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong)UIImageView * lineImageView;
/**
 @brief   自定义 单元格底部线 样式二：占满单元格
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong)UIImageView * lineOfFullStyleImageView;

/**
 @brief    单元格 左侧图片
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UIImageView * leftPhotoImageV;
/**
 @brief    姓名
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,strong) UILabel * nameLabel;
//---------------------------------------------------------------------------
//-------------------------------- 方 法 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief 自定义 单元格底部线 样式一：空出左部图片
 @discussion   null
 @author        魏帅
 */
-(UIImageView *)addLineImageViewContent;
/**
 @brief 自定义 单元格底部线 样式二：占满单元格
 @discussion   null
 @author        魏帅
 */
-(UIImageView *)addLineOfFullStyleImageViewContent;



/**
 @brief   添加 单元格 左侧图片
 @discussion   null
 @author        魏帅
 */
-(UIImageView *)addPhotosImageViewContent;
/**
 @brief    添加图片
 @discussion   null
 @author        魏帅
 */
-(UILabel *)addNameLableContent;

@end
