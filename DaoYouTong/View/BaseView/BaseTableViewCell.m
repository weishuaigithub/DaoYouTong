//
//  BaseTableViewCell.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/23.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置视图内容
        [self setUI];
        
    }
    return self;
}
//设置视图内容
- (void)setUI
{
    
}
////子视图布局
//-(void)layoutSubviews
//{
//}
//设置自定义 单元格底部线 样式一 ：空出左部图片
-(UIImageView *)addLineImageViewContent
{
    //底部线
    _lineImageView  = [[UIImageView alloc]init];
    _lineImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineImageView];
    return _lineImageView;
}
//设置自定义 单元格底部线 样式二 ：占满
-(UIImageView *)addLineOfFullStyleImageViewContent
{
    //底部线
    _lineOfFullStyleImageView  = [[UIImageView alloc]init];
    _lineOfFullStyleImageView.backgroundColor = [UIColor grayColor];
    [self addSubview:_lineOfFullStyleImageView];
    return _lineOfFullStyleImageView;
}
//添加左部照片
-(UIImageView *)addPhotosImageViewContent
{
    _leftPhotoImageV  = [[UIImageView alloc]init];
    
    [self addSubview:_leftPhotoImageV];
    return _leftPhotoImageV;
}
//导游姓名
-(UILabel *)addNameLableContent
{
    _nameLabel = [[UILabel alloc]init];
    [self addSubview: _nameLabel];
    return  _nameLabel;
    
}
//关注导游
//添加导游简介
//点击进入详情
//添加导游星级评分
//添加导游词播放次数

@end
