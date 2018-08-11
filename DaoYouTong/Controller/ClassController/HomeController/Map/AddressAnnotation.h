//
//  AddressAnnotation.h
//  DaoYouTong
//
//  Created by 魏帅 on 2018/6/1.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressAnnotation : NSObject
@property(nonatomic,strong) NSString * addressName;//地址标注名
@property(nonatomic,assign) NSInteger  directionInt;//位置类型 1.表示在路的东侧或者右侧；2表示在路的西侧或者左侧
@end

