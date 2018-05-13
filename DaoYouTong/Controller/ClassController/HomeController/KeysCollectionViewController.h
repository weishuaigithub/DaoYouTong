//
//  KeysCollectionViewController.h
//  DaoYouTong
//
//  Created by 魏帅 on 2018/5/11.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeysCollectionViewController : UICollectionViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView* keysCollectionView;
@end
