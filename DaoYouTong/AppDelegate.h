//
//  AppDelegate.h
//  DaoYouTong
//
//  Created by 魏帅 on 2017/12/1.
//  Copyright © 2017年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>{
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

