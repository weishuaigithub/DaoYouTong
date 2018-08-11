//
//  AVAudioPlayerViewController.h
//  DaoYouTong
//
//  Created by 魏帅 on 2018/6/5.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AVAudioPlayerViewController : UIViewController

@property(nonatomic,strong) AVAudioPlayer * player;
@property(nonatomic,assign) BOOL isPlaying;
@property(nonatomic,strong) UIButton * playerBtn;
@end
