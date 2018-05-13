//
//  FunctionalKeysView.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/19.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "FunctionalKeysView.h"

@implementation FunctionalKeysView

- (void)drawRect:(CGRect)rect {
    
    [self setUI];
    
}
-(void)setUI
{
//    [self addFunctionalButton];
    //添加横向滑动 CollectionView
    
    
}
-(void)addCollectionView
{
     
    
    
}
-(void)addFunctionalButton
{
    _foldBtn  = [[UIButton alloc]init];
    _foldBtn.frame = CGRectMake(2*kWidth/5, 0, kWidth/5 , 25);
    _foldBtn.backgroundColor = [UIColor yellowColor];
    [self addSubview:_foldBtn];
    
    NSArray * btnArray = @[@"蓝牙",@"免费WiFi",@"附近美食",@"设置",@"电话",@"地图定位",@"跟团反馈",@"更多"];
    NSArray * btnImageArray  = @[@"日报.png",@"周报.png",@"月报.png",@"拜访记录.png",@"业绩日报.png",@"取消.png",@"取消.png",@"取消.png"];
    //添加 按钮
    int n = 4;
    for (int i= 0; i<btnArray.count; i++) {
        
        UIButton * btn  = [[UIButton alloc]init];
        btn.frame  = CGRectMake(kWidth/n*(i%n), kWidth/n*(i/n)+28, kWidth/n, kWidth/n);
        btn.layer.borderWidth = 1;
        btn.tag = 130+i;
        [btn setTitle: [btnArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        btn.imageView.size = CGSizeMake(40, 40);
        btn.imageView.backgroundColor = [UIColor greenColor];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height+20 ,-kWidth/6-12, 0.0,0.0)];//文字距离上边框的距离  增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变 (距离设置并不准确)
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(20, (kWidth/n-40)/2,btn.titleLabel.bounds.size.height, (kWidth/n-40)/2)];//图片距离右边框距离减少图片的宽度，其它不边
        [btn setImage:[UIImage imageNamed:[btnImageArray objectAtIndex:i]] forState:0];
        
        if(i == btnArray.count-1)
        {
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self  action:@selector(intoDifferentWorkReportView:)forControlEvents:UIControlEventTouchUpInside];
        [self  addSubview:btn];
    }
    
}
//按钮点击事件
-(void)intoDifferentWorkReportView:(UIButton *)btn
{
    //进入 日报/周报/月报  界面
//    NewWorkReportViewController * newWorkReportVC  = [[NewWorkReportViewController alloc]init];
    //进入 日报界面
    if (130 == btn.tag) {
//        [self.navigationController pushViewController:newWorkReportVC animated:YES];
        
    } else if(131 == btn.tag) {//进入 界面
        
    }else if(132 == btn.tag) {//进入 界面
        
    }else if(133 == btn.tag) {//进入 记录
    }else if(134 == btn.tag) {//进入 日报
    }else if(135 == btn.tag)
    {
  
    }else if(136 == btn.tag)
    {
        
    }else if(137 == btn.tag)
    {
        
    }else if(138 == btn.tag)
    {
        
    }
    
}
@end
