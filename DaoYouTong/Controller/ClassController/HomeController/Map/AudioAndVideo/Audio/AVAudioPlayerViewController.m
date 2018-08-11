//
//  AVAudioPlayerViewController.m
//  DaoYouTong
//
//  Created by 魏帅 on 2018/6/5.
//  Copyright © 2018年 魏帅. All rights reserved.
//

#import "AVAudioPlayerViewController.h"

@interface AVAudioPlayerViewController ()
{

//    UIButton * _button;
}

@end

@implementation AVAudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addAVAudioPlayerView];



}
-(void)addAVAudioPlayerView
{
    self.view.backgroundColor = [UIColor yellowColor];

    //加载本地音乐
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];

    if (self.player) {
        [self.player prepareToPlay];
    }

    _playerBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    _playerBtn.backgroundColor = [UIColor blackColor];
//    button.center = self.view.center;
    [_playerBtn setTitle:@"播放本地音乐" forState:UIControlStateNormal];
    [_playerBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [_playerBtn setTitleColor:[UIColor grayColor] forState:0];
    
    [self.view addSubview:_playerBtn];
    self.view.userInteractionEnabled = YES;//点击响应打开

    self.player.volume = 0.5;
    self.player.pan = -1;
    self.player.numberOfLoops = -1;
    self.player.rate = 0.5;

}
-(void)viewDidAppear:(BOOL)animated
{
    
    
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
