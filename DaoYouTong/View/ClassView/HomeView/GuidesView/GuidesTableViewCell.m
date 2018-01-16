//
//  HomeTableViewCell.m
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/24.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import "GuidesTableViewCell.h"

@implementation GuidesTableViewCell

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
    [self addLineOfFullStyleImageViewContent];//底部线
    [self addPhotosImageViewContent];//添加图片
    [self addNameLableContent];//添加姓名
    
}
//子视图布局
-(void)layoutSubviews
{
    self.leftPhotoImageV.frame =CGRectMake(5, 5, self.width*.25, self.height-10);
    self.leftPhotoImageV.backgroundColor = [UIColor grayColor];
    self.nameLabel.frame  = CGRectMake(self.width*.3, 5, self.width/3, (self.height-10)/4);
    self.nameLabel.backgroundColor = [UIColor grayColor];

}


@end
