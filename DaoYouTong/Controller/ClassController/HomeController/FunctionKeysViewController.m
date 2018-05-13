//
//  FunctionKeysViewController.m
//  DaoYouTong
//
//  Created by 魏帅 on 2018/5/12.
//  Copyright © 2018年 魏帅. All rights reserved.
//
//功能键选择区
#import "FunctionKeysViewController.h"

@interface FunctionKeysViewController ()

@end

@implementation FunctionKeysViewController
static NSString * const reuseIdentifier = @"Cell";
-(instancetype)init
{
    if (self = [super init]) {
         [self addCollectionView];
    }
    return self;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加collecView 横向滚动视图
//    [self addCollectionView];
}
-(void)addCollectionView
{
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    // 设置UICollectionView为横向滚动
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    // 每一行cell之间的间距
//    flowLayout.minimumLineSpacing = 50;
//    // 每一列cell之间的间距
//    // flowLayout.minimumInteritemSpacing = 10;
//    // 设置第一个cell和最后一个cell,与父控件之间的间距
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    
//   _collectionV  = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, 300,100) collectionViewLayout:flowLayout ];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    _collectionV.backgroundColor = [UIColor blueColor];
    [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.view addSubview:_collectionV];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (!cell ) {
        NSLog(@"cell为空,创建cell");
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor yellowColor];

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
