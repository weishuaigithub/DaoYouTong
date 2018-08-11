//
//  MapViewController.m
//  DaoYouTong
//
//  Created by 魏帅 on 2018/5/19.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import "MapViewController.h"
#import "AVAudioPlayerViewController.h"//音频：本地音乐


#import "RouteAnnotation.h"//路段节点
#import "PromptInfo.h"//提示窗口
#import "AddressAnnotation.h"//地址信息
#import "FMDatabase.h"//建立数据库
//-------------添加视频区-------------
#ifndef __OPTIMIZE__
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#endif

#import "CLPlayerView.h"
#import "CLModel.h"
#import "UIView+CLSetRect.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

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
    FMDatabase * fmdb;//fmdb 数据库
    
}
@property(nonatomic,strong) AVAudioPlayer * player;
@property(nonatomic,assign) BOOL isPlaying;

/**CLplayer*/
@property (nonatomic, strong) CLPlayerView * playerView;
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
//    //3 下载文件
//    NSString *fileDownLoadURL =@"http://192.168.0.101:8080/FileUploadAndDownload01/upload/test.mp4";
//    NSString * fileDownLoadFileName = [self DownloadTextFile:fileDownLoadURL];
//    NSLog(@"快照下载文件名is %@  ",fileDownLoadFileName);
    
}
// 下载 文件
-(NSString*)DownloadTextFile:(NSString*)fileUrl
{
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * lastString  = [fileUrl lastPathComponent];
    NSString *filePath = [[caches objectAtIndex:0] stringByAppendingPathComponent:lastString];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@" filePath is %@",filePath);

    //如果已经存在该路径
    if ([fileManager fileExistsAtPath:filePath])
    {
        
        NSLog(@"下载成功，提示弹框！已经存在");
        //使用异步线程
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"下载成功！" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ alertController dismissViewControllerAnimated:YES completion:nil];
            });
        });
        return filePath;
    }else
    {

//        fileUrl = [fileUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        fileUrl = [fileUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //  例：      fileUrl = @"http://120.55.160.212:80/CloudPrint/isecstar/scandir20160429/006FEAA9-CA95-4BD6-A15F-B3366BB8129F.jpg.gz";
        NSURL *fileURL = [NSURL URLWithString:fileUrl];
        NSLog(@" snapshotURL is %@",fileURL);
        NSData *data = [NSData dataWithContentsOfURL:fileURL];
        NSLog(@"  数据是%@",data);
        [data writeToFile:filePath atomically:YES];//将NSData类型对象data写入文件，文件名为FilePath
        NSLog(@"下载成功，提示弹框！");
        //使用异步线程
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"下载成功！" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:YES completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ alertController dismissViewControllerAnimated:YES completion:nil];
            });
        });
        [self creatSQL:filePath];
        //使用异步线程 传入文件路径
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //           [self creatSQL:filePath];
        //        });
        
        return filePath;
    }
    
}
//创建数据库
-(void)creatSQL:(NSString *)snapshotURL
{
    //    NSUserDomainMask = 1,       // user's home directory --- place to install user's personal items (~)
    
    //1.创建存储路径          /域中目录的搜索路径/                 /NS文件目录/          /用户域掩码/
    NSArray * paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documents  = [paths objectAtIndex:0];
    //通过添加路径组件串/
    NSString * database_path  = [documents stringByAppendingPathComponent:@"FileInfo.sqlite"];
    //2.创建sql3管理的数据库
    fmdb = [FMDatabase databaseWithPath:database_path];
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([fmdb open]) {
        //4.创建表
        BOOL result = [fmdb executeUpdate:@"CREATE TABLE IF NOT EXISTS SNAPSHOTINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT);"];
        
        if (result) {
            NSLog(@"创建表成功！");
            //5.插入数据
            NSString * str1 = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@') VALUES ('%@')",@"SNAPSHOTINFO", @"url", snapshotURL];
            BOOL instertResult  = [fmdb executeUpdate:str1];
            if (!instertResult) {
                NSLog(@"error when insert db table");
            }else{
                NSLog(@"success to insert db table");
            }
        }else{
            NSLog(@"建表失败！");
        }
        
        [fmdb close];
    }else{
        
        NSLog(@"数据库打开失败！");
    }
    
}
//1添加音视频区
-(void)addAudiondVideoView
{
    _avHeight  = kViewWidth*9/16+20;
    
//    AVAudioPlayerViewController * avAudioVC  = [[AVAudioPlayerViewController alloc]init];
//    avAudioVC.view.frame = CGRectMake(0, 0, kViewWidth, _avHeight);
    
    UIView * AVideoV  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewWidth, _avHeight)];
    AVideoV.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    [self.view addSubview:AVideoV];
    
    //一 ：加载音乐区
    //加载本地音乐
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    
    if (self.player) {
        [self.player prepareToPlay];
    }
    
    UIButton * playerBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    playerBtn.backgroundColor = [UIColor blackColor];
    //    button.center = self.view.center;
    [playerBtn setTitle:@"播放本地音乐" forState:UIControlStateNormal];
    [playerBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [playerBtn setTitleColor:[UIColor grayColor] forState:0];
    [playerBtn  addTarget:self action:@selector(clickPlay:) forControlEvents:UIControlEventTouchUpInside];
    self.view.userInteractionEnabled = YES;//点击响应打开
    
    self.player.volume = 0.5;
    self.player.pan = -1;
    self.player.numberOfLoops = -1;
    self.player.rate = 0.5;
    
//    [AVideoV addSubview:playerBtn];
    //二：加载视频区
     [_playerView destroyPlayer];
    if (_playerView == nil) {
        _playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 60, kViewWidth,_avHeight)];
    }
    [AVideoV addSubview: _playerView];
    //    //重复播放，默认不播放
    //    _playerView.repeatPlay = YES;
    //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
    //    _playerView.isLandscape = YES;
    //    //设置等比例全屏拉伸，多余部分会被剪切
    //    _playerView.fillMode = ResizeAspectFill;
    //设置进度条背景颜色
    _playerView.progressBackgroundColor = [UIColor colorWithRed:53 / 255.0 green:53 / 255.0 blue:65 / 255.0 alpha:1];
    //设置进度条缓冲颜色
    _playerView.progressBufferColor = [UIColor grayColor];
    //设置进度条播放完成颜色
    _playerView.progressPlayFinishColor = [UIColor whiteColor];
    //    //全屏是否隐藏状态栏
    //    _playerView.fullStatusBarHidden = NO;
    //    //转子颜色
    //    _playerView.strokeColor = [UIColor redColor];
    //视频地址
    _playerView.url = [NSURL URLWithString:@"http://192.168.0.100:8080/FileUploadAndDownload01/upload/02.mov"];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调
    [_playerView destroyPlay:^{
        NSLog(@"播放器被销毁了");
    }];
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        //销毁播放器
        [_playerView destroyPlayer];
        _playerView = nil;
        NSLog(@"播放完成");
    }];
    
}
- (void)clickPlay:(UIButton*)button{
    
    if(!self.isPlaying){
        [self.player play];
        button.selected = YES;
        self.isPlaying = YES;
    }else{
        [self.player stop];
        button.selected = NO;
        self.isPlaying = NO;
    }
    
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
    AddressAnnotation * addressAnnotation1  = [[AddressAnnotation alloc]init];
    addressAnnotation1.addressName = @"景点1";
    addressAnnotation1.directionInt = 1;
    AddressAnnotation * addressAnnotation2  = [[AddressAnnotation alloc]init];
    addressAnnotation2.addressName = @"景点2";
    addressAnnotation2.directionInt = 1;
    AddressAnnotation * addressAnnotation3  = [[AddressAnnotation alloc]init];
    addressAnnotation3.addressName = @"景点3";
    addressAnnotation3.directionInt = 1;
    AddressAnnotation * addressAnnotation4  = [[AddressAnnotation alloc]init];
    addressAnnotation4.addressName = @"景点4";
    addressAnnotation4.directionInt = 2;
    _addressNameArray = [[NSMutableArray alloc]init];
    [_addressNameArray addObject:addressAnnotation1];
    [_addressNameArray addObject:addressAnnotation2];
    [_addressNameArray addObject:addressAnnotation3];
    [_addressNameArray addObject:addressAnnotation4];
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
//(景点点击事件)
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    NSLog(@"选中景点标注！");
}
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"取消选中景点标注！");
    
}
// 当点击annotation view弹出的泡泡时，调用此接口(泡泡点击事件)
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
