//
//  BaseTableViewController.h
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/23.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface BaseTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
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
