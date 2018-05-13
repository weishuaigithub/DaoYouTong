//
//  FunctionKeysViewController.h
//  DaoYouTong
//
//  Created by 魏帅 on 2018/5/12.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionKeysViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 @brief       横向滚动 collection
 @discussion   null
 @author        魏帅
 */

@property(nonatomic,strong) UICollectionView * collectionV ;
@end
