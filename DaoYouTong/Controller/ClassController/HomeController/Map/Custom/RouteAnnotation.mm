//
//  RouteAnnotation.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 16/8/31.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "RouteAnnotation.h"
#import "UIImage+Rotate.h"
#import "AddressAnnotation.h"//地址详情
@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;


- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview withArray:(NSMutableArray *)nameArray withNumber:(NSInteger)number
{
    BMKAnnotationView* view = nil;
    AddressAnnotation * addressAnnotaton;
    switch (_type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"start_node"];
                //路径方法添加图片
//                NSBundle *bundle = [NSBundle mainBundle];
//                NSString *resourcePath = [bundle resourcePath];
//                NSString *filePath = [resourcePath stringByAppendingPathComponent:@"icon_start.png"];
//                view.image = [UIImage imageWithContentsOfFile:filePath];
//                view.image = [UIImage imageNamed:@"icon_start.png"];
                NSLog(@"nameArray is  %@",nameArray);
                addressAnnotaton =  [nameArray objectAtIndex:number-1];
                NSString * nameStr  = addressAnnotaton.addressName;
                NSLog(@"namestr is %@",nameStr);
                view.image = [self createTextImage:nameStr];//根据景点名称设计图片
//                NSLog(@"  view1·  is  %@",view);//view 大小为零是因为 图片没有加载上
                if (addressAnnotaton.directionInt == 1) {
                    
                    view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                    
                }else{
                    view.centerOffset = CGPointMake(-(view.frame.size.width), -(view.frame.size.height * 0.5));
                }
            }
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"end_node"];
        
//                view.image = [UIImage imageNamed:@"icon_end.png"];
//                view.image = [self createTextImage:[nameArray objectAtIndex:number]];//根据景点名称设计图片
//                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                
                addressAnnotaton =  [nameArray objectAtIndex:number];
                NSString * nameStr  = addressAnnotaton.addressName;
                 NSLog(@"namestr is %@",nameStr);
                view.image = [self createTextImage:nameStr];//根据景点名称设计图片
                //                NSLog(@"  view1·  is  %@",view);//view 大小为零是因为 图片没有加载上
                if (addressAnnotaton.directionInt == 1) {
                    view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                }else{
                    view.centerOffset = CGPointMake(-(view.frame.size.width), -(view.frame.size.height * 0.5));
                }
            }
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"bus_node"];
                view.image = [UIImage imageNamed:@"icon_bus.png"];
            }
        }
            break;
        case 3:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"rail_node"];
                view.image = [UIImage imageNamed:@"icon_rail.png"];
            }
        }
            break;
        case 4:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"route_node"];
            } else {
                [view setNeedsDisplay];
            }
            UIImage* image = [UIImage imageNamed:@""];//icon_direction.png 方向箭头 图片
            view.image = [image imageRotatedByDegrees:_degree];
        }
            break;
        case 5:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"waypoint_node"];
            } else {
                [view setNeedsDisplay];
            }
            
            UIImage* image = [UIImage imageNamed:@"icon_waypoint.png"];
            view.image = [image imageRotatedByDegrees:_degree];
        }
            break;
            
        case 6:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"stairs_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"stairs_node"];
            }
            view.image = [UIImage imageNamed:@"icon_stairs.png"];
        }
            break;
        default:
            break;
    }
    if (view) {
        view.annotation = self;
        view.canShowCallout = YES;
    }
    return view;
}
//生成图片
-(UIImage *)createTextImage:(NSString*)text
{
    UILabel *temptext  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 25)];
    temptext.text = text;
    temptext.font = [UIFont systemFontOfSize:12];
    temptext.textColor = [UIColor blackColor];
    temptext.textAlignment = NSTextAlignmentCenter;
    temptext.backgroundColor = [UIColor greenColor];
    UIImage *image  = [self imageForView:temptext];//根据文字画图
    return  image;
    
}
- (UIImage *)imageForView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    else
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
