//
//  KeysCollectionViewController.m
//  DaoYouTong
//
//  Created by 魏帅 on 2018/5/11.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import "KeysCollectionViewController.h"
#import "FunctionKeysCollectionViewCell.h"
@interface KeysCollectionViewController ()

@end

@implementation KeysCollectionViewController

static NSString * const reuseIdentifier = @"cellForCollectionView";
-(instancetype)init//在初始化时可进行修改
{
     UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    if (self=[super initWithCollectionViewLayout:layout]) {
        [self addUIView];
    }
//    if (self = [super init]) {
//        [self addUIView];
//    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    [self addUIView];
    
   
}
-(void)addUIView
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
//
//    //    flowLayout.minimumLineSpacing = 1;// 根据需要编写
//    //    flowLayout.minimumInteritemSpacing = 1;// 根据需要编写
//    //    flowLayout.itemSize = CGSizeMake(70, 70);// 该行代码就算不写,item也会有默认尺寸
//
//   self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kViewWidth/4) collectionViewLayout:flowLayout];
//    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[FunctionKeysCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
}
#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    if(!nibri)
//    {
//        NSLog(@"321");
//        UINib *nib = [UINib nibWithNibName:@"CollectionViewCell"bundle:nil];
//        [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
//        nibri =YES;
//    }
    
    
    FunctionKeysCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    if (!cell ) {
//        NSLog(@"cell为空,创建cell");
//        cell = [[UICollectionViewCell alloc] init];
//    }
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
