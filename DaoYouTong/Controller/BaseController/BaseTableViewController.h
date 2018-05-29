//
//  BaseTableViewController.h
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/23.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
/**
 @brief       定义协议,跳转控制器
 @discussion   null
 @author        魏帅
 */
//自定义 跳转协议
@protocol BaseTableViewControllerDelegate
@required//必须实现
@optional//选择实现
-(void)protocolMethodOfDidSelectCellWithIndexPath:(NSIndexPath *)indexPath;
-(void)protocolMethodOfDidSelectCellWithIndexPath:(NSIndexPath *)indexPath withButton:(UIButton *)button;

@end

@interface BaseTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)id <BaseTableViewControllerDelegate> baseTableVCDelegate;//跳转协议

//---------------------------------------------------------------------------
//-------------------------------- 变量 ---------------------------------------
//---------------------------------------------------------------------------
/**
 @brief     单元格视图 组头高度
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,assign)CGFloat tableViewSectionsHeaderHeight;
/**
 @brief   单元格高度
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,assign) CGFloat tableViewCellHeight;
/**
 @brief     单元格行数（默认为一组）
 @discussion   null
 @author        魏帅
 */
@property(nonatomic,assign) NSInteger tableViewCellNumberOfRows;

@end
