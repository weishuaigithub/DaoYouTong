//
//  MapViewController.m
//  DaoYouTong
//
//  Created by 魏帅 on 2018/5/19.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import "MapViewController.h"



#import "RouteAnnotation.h"//路段节点
#import "PromptInfo.h"//提示窗口


@interface MapViewController ()
{
    BMKRouteSearch* _routesearch;
    double _avHeight;//音视频区的高度
    
    BMKPolyline* _polyLine;//绘制路线_polyLine
    NSMutableArray * _addressArray;//标记点数组
    NSMutableArray * _addressNameArray;//标记点名称数组
    NSMutableArray * _overLaysArray;//自定义步行的 绘制路段数组
    BMKWalkingRoutePlanOption *walkingRouteSearchOption2;
    int _number;//判断路段绘制次数
}

@end

@implementation MapViewController
-(void)viewWillAppear:(BOOL)animated
{
    // 主页 显示导航栏
    [self showNavigation];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _routesearch.delegate = nil; // 不用时，置nil

}
- (void)dealloc {
    if (_routesearch != nil) {
        _routesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //导航栏半透明效果
        self.navigationController.navigationBar.translucent = NO;
    }
    //1 添加音视频区
    [self addAudiondVideoView];
    //2 添加地图区
    [self addBaiDuMapView];
    
}
//1添加音视频区
-(void)addAudiondVideoView
{
    _avHeight  = kViewWidth*9/16+20;
    UIView * AVideoV  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, _avHeight)];
    AVideoV.backgroundColor = [UIColor blackColor];
    [self.view addSubview:AVideoV];
    
    
    
}
//---------------------------2添加地图区---------------------------
-(void)addBaiDuMapView
{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0,_avHeight, kViewWidth, kViewHeight- _avHeight)];
    [self.view addSubview:_mapView];
    
    [self onClickWalkSearch];
    
}

//步行
-(void)onClickWalkSearch
{
    //初始化检索对象
    _routesearch = [[BMKRouteSearch alloc]init];
    _routesearch.delegate = self;
    
    
    //起点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
//    start.name = @"邹城孟庙养气门";//详细地址
//    start.cityName = @"济宁市";//城市地址
        start.pt=(CLLocationCoordinate2D){35.3951982766, 116.9805235313};//纬度，经度
    
    //终点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    ///检索的起点，可通过关键字、坐标两种方式指定。cityName和cityID同时指定时，优先使用cityID
//        end.name = @"邹城孟庙亚圣殿";
//        end.cityName = @"济宁市";//不添加城市地址会有歧义？？？
    end.pt=(CLLocationCoordinate2D){35.3950982766, 116.9804235313};//纬度，经度
    BMKWalkingRoutePlanOption *walkingRouteSearchOption1 = [[BMKWalkingRoutePlanOption alloc]init];
    walkingRouteSearchOption1.from = start;
    walkingRouteSearchOption1.to = end;
//    BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption1];
   
    //步行路线 规划
     BMKPlanNode* point1 = [[BMKPlanNode alloc]init];
    BMKPlanNode* point2 = [[BMKPlanNode alloc]init];
    point1.pt = (CLLocationCoordinate2D){35.3951982766, 116.9803235313};//纬度，经度
    point2.pt = (CLLocationCoordinate2D){35.3951982766, 116.9802235313};//纬度，经度
    //路线数组
    _overLaysArray  = [[NSMutableArray alloc]init];
    //地址数组
    _addressArray  = [[NSMutableArray alloc]init];
    //判断路段绘制次数
    _number =0;//由0 开始是因为初始有2个点已经发起了规划请求
    [_addressArray addObject:start];
    [_addressArray addObject:end];
    [_addressArray addObject:point1];
    [_addressArray addObject:point2];

    //地址名称数组
    _addressNameArray = [[NSMutableArray alloc]init];
    [_addressNameArray addObject:@"景点1"];
    [_addressNameArray addObject:@"景点2"];
    [_addressNameArray addObject:@"景点3"];
    [_addressNameArray addObject:@"景点4"];
    //检索方法
    [self delayMethod:walkingRouteSearchOption1];
}
//发起路线搜索方法
-(BOOL)delayMethod:(BMKWalkingRoutePlanOption *)walkingRouteSearchOption
{
    BOOL flag = [_routesearch walkingSearch:walkingRouteSearchOption];
    if(flag)
    {
        NSLog(@"walk检索发送成功");
        NSLog(@"number  is %d",_number);
        _number++;
    }
    else
    {
        NSLog(@"walk检索发送失败");
    }
    return flag;
    
    
}
//返回步行路线 搜索结果
- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    NSLog(@"onGetWalkingRouteResult error:%d", (int)error);
    //清除 注释节点
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//清除 注释节点
//        [_mapView removeAnnotations:array];
    //清除 覆盖路径
    array = [NSArray arrayWithArray:_mapView.overlays];
//        [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
//                NSLog(@" 路段总数size：%ld",size);
        int planPointCounts = 0;
        //
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
//                if (_number == 1) {
                    RouteAnnotation* item = [[RouteAnnotation alloc]init];
                    item.coordinate = plan.starting.location;
                    item.title = @"起点";
                    item.type = 0;
                    [_mapView addAnnotation:item]; // 添加起点标注
//                }
               
            }
            if(i==size-1){
//                if (_number == _addressArray.count-1) {
                    RouteAnnotation* item = [[RouteAnnotation alloc]init];
                    item.coordinate = plan.terminal.location;
                    item.title = @"终点";
                    item.type = 1;
                    [_mapView addAnnotation:item]; // 添加终点标注
//                }
                
            }
            //添加annotation注释节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;//获取该路段入口指示信息
            item.degree = transitStep.direction * 30;
            item.type = 4;// <0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点  6:楼梯、电梯
            [_mapView addAnnotation:item];
            
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
            NSLog(@"planPointCounts  is %d",planPointCounts);
        }

        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            //途步 transitStep
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
//                       NSLog(@"plan.steps is %@ ",plan.steps);
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
//        NSLog(@"temppoints  is %@",temppoints);//报错了！
        NSLog(@"planPointCounts is %d",planPointCounts);
//         通过points  绘制BMKPolyline 折线
        _polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        
        [_overLaysArray addObject:_polyLine];
        NSLog(@"overLaysArray is  %@",_overLaysArray);

        
        //-------多位置 规划 路线---------
        if(_number <_addressArray.count-1){
            NSLog(@"number  is %d",_number);
                BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
                walkingRouteSearchOption.from = [_addressArray objectAtIndex:_number];
                walkingRouteSearchOption.to = [_addressArray objectAtIndex:_number+1];
                [self delayMethod:walkingRouteSearchOption];

        }else{
            NSLog(@"执行完毕！");
            //        [_mapView addOverlay:_polyLine]; // 添加单条路线overlay
            [_mapView addOverlays:_overLaysArray]; // 添加路线overlay数组
            delete []temppoints;
            //清除 注释节点
            [_mapView removeAnnotations:array];
            [self mapViewFitPolyLine:_polyLine];
        }

       
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR) {
        //检索失败
        [self resetSearch:result.suggestAddrResult];
        [self onClickWalkSearch];//重复检索？？？？
    }
}
//绘制的路径 样式/线宽/颜色/等
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = [[UIColor alloc] initWithRed:0 green:0 blue:1 alpha:0.7];
        polylineView.lineWidth = 5.0;
        
//        polylineView.isFocus = YES;// 是否分段纹理绘制（突出显示），默认YES
        //加载分段纹理图片，必须否则不能进行分段纹理绘制
        [polylineView loadStrokeTextureImage:[UIImage imageNamed:@"texture_arrow2.png"]];
        return polylineView;
    }
    return nil;
}
#pragma mark - BMKMapViewDelegate
//标注点样式
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //返回不同的标注点样式
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {

        return [(RouteAnnotation*)annotation getRouteAnnotationView:mapView withArray:_addressNameArray withNumber:_number];
    }
    
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
//    {
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        BMKAnnotationView *annotationView = (BMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation
//                                                           reuseIdentifier:reuseIndetifier];
//        }
//        annotationView.image = [self createTextImage:@"亚圣殿"];//根据景点名称设计图片
//        return annotationView;
//    }
    return nil;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    NSLog(@"选中标注！");
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
// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}

#pragma mark - 私有
//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat leftTopX, leftTopY, rightBottomX, rightBottomY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    // 左上角顶点
    leftTopX = pt.x;
    leftTopY = pt.y;
    // 右下角顶点
    rightBottomX = pt.x;
    rightBottomY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        leftTopX = pt.x < leftTopX ? pt.x : leftTopX;
        leftTopY = pt.y < leftTopY ? pt.y : leftTopY;
        rightBottomX = pt.x > rightBottomX ? pt.x : rightBottomX;
        rightBottomY = pt.y > rightBottomY ? pt.y : rightBottomY;
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTopX, leftTopY);
    rect.size = BMKMapSizeMake(rightBottomX - leftTopX, rightBottomY - leftTopY);
    UIEdgeInsets padding = UIEdgeInsetsMake(30, 0, 100, 0);
    BMKMapRect fitRect = [_mapView mapRectThatFits:rect edgePadding:padding];
    [_mapView setVisibleMapRect:fitRect];
}
//输入的起终点有歧义，取返回poilist其他点重新发起检索
- (void)resetSearch:(BMKSuggestAddrInfo*)suggestInfo {
    if (suggestInfo.startPoiList.count > 0) {
        BMKPoiInfo *starPoi = [[BMKPoiInfo alloc] init];
        starPoi = suggestInfo.startPoiList[1];
        //        _startAddrText.text = starPoi.name;//获取输入的起点位置
    }
    if (suggestInfo.endPoiList.count > 0) {
        BMKPoiInfo *endPoi = [[BMKPoiInfo alloc] init];
        endPoi = suggestInfo.endPoiList[1];
        //        _endAddrText.text = endPoi.name;//获取输入的终点位置
    }
    //提示窗
    [PromptInfo showText:@"输入的起终点有歧义，取返回poilist其他点重新发起检索"];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
