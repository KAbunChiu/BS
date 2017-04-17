//
//  KABINAddVC.m
//  YouMomBoom
//
//  Created by KAbun on 17/4/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINAddVC.h"
#import <AVFoundation/AVFoundation.h>
#import "MainTabBarViewController.h"


@interface KABINAddVC ()

@property(nonatomic,weak)UIView *maskView;

@property(nonatomic,weak)AVPlayer *player;

@property(nonatomic,weak)AVPlayerLayer *playerLayer;

@property(nonatomic,weak) AVPlayerItem *item;

@property(nonatomic,weak) AVURLAsset *asset;
@end

@implementation KABINAddVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


-(void)setupUI{
    
    UIView *maskView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KABINScrennWidth, KABINScrennHeight)];
    [self.view addSubview:maskView];
    self.maskView=maskView;
    
    
    NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    AVURLAsset *asset=[[AVURLAsset alloc]initWithURL:url options:nil];
    AVPlayerItem *item=[[AVPlayerItem alloc]initWithAsset:asset];
    AVPlayer *player=[[AVPlayer alloc]initWithPlayerItem:item];
    AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity=AVLayerVideoGravityResize;
    playerLayer.contentsScale=UIViewContentModeScaleAspectFit;
    
    playerLayer.frame=CGRectMake(0, 0, KABINScrennWidth, KABINScrennHeight);
    [maskView.layer addSublayer:playerLayer];
    self.playerLayer=playerLayer;
    self.player=player;
    self.item=item;
    self.asset=asset;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    [player play];
    
    //Georgia-BoldItalic
    UILabel *welcomeLabel=[UILabel new];
    welcomeLabel.frame=CGRectMake(0, KABINScrennHeight, KABINScrennWidth, 80);
    welcomeLabel.font=[UIFont fontWithName:@"Zapfino" size:20];
    welcomeLabel.text=@"KABIN App";
    welcomeLabel.textAlignment=NSTextAlignmentCenter;
    welcomeLabel.textColor=[UIColor whiteColor];
    [self.view insertSubview:welcomeLabel atIndex:1];
    
    UIButton *goBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    goBtn.frame=CGRectMake(KABINScrennWidth, KABINScrennHeight-130, 80, 30);
    goBtn.backgroundColor=[UIColor colorWithWhite:1 alpha:0];
    [goBtn setTitle:@"Enter" forState:UIControlStateNormal];
    [goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goBtn.titleLabel.font=[UIFont fontWithName:@"Georgia-BoldItalic" size:15];
    goBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    goBtn.layer.cornerRadius=15;
    goBtn.layer.borderColor=[UIColor grayColor].CGColor;
    goBtn.layer.borderWidth=0.4;
    goBtn.layer.masksToBounds=YES;
    [goBtn addTarget:self action:@selector(enterHomeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:goBtn
                     atIndex:1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0 animations:^{
            welcomeLabel.frame=CGRectMake(0, KABINScrennHeight-80, KABINScrennWidth, 80);
            goBtn.frame=CGRectMake(KABINScrennWidth/2-40, KABINScrennHeight-130, 80, 30);
        }];
        
    });
    
}

-(void)enterHomeVC{
    [self.player pause];
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.maskView removeFromSuperview];
    MainTabBarViewController *home=[MainTabBarViewController new];
    [self.navigationController pushViewController:home animated:YES];
   
}

-(void)playbackFinished:(NSNotification *)notification{
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
}

@end
