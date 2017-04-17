//
//  KABINMoreVC.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/9.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINMoreVC.h"


@interface KABINMoreVC ()

@property(nonatomic,strong) UIView *maskView;

@property(nonatomic,strong) AVPlayer *player;

@property(nonatomic,strong) AVPlayerLayer *playLayer;

@property(nonatomic,strong) UIButton *playButton;

@property(nonatomic,strong) UIProgressView *progress;

@property(nonatomic,strong) UISlider *slider;

@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,assign) CGFloat  totaMovieDuration;

@property(nonatomic,strong) UIView *operationView;

@property(nonatomic,strong) AVPlayerItem *item;

@property(nonatomic,strong) AVURLAsset *asset;

@property(nonatomic,strong) NSTimer *timer;
@end

@implementation KABINMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tabBarController.tabBar.hidden=YES;
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor=[UIColor clearColor];
    
    self.timer= [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(Stack) userInfo:nil repeats:YES];
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 5, 38, 38);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=back;
    [self.player play];
    
}

-(AVPlayer *)player{
    if (!_player) {
        
        self.maskView=[UIView new];
        self.maskView.frame=CGRectMake(0, 100, KABINScrennWidth, 230);
        [self.view addSubview:self.maskView];
        
        self.asset=[[AVURLAsset alloc]initWithURL:[NSURL URLWithString:self.type] options:nil];
        self.item=[AVPlayerItem playerItemWithAsset:self.asset];
        self.player=[[AVPlayer alloc]initWithPlayerItem:self.item];
        self.playLayer=[AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playLayer.videoGravity=AVLayerVideoGravityResizeAspect;
        self.playLayer.frame=CGRectMake(0, 0, KABINScrennWidth, 200);
        [self.maskView.layer addSublayer:self.playLayer];
        
        AVAudioSession *session=[AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
        
        self.operationView=[UIView new];
        self.operationView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.8];
        self.operationView.frame=CGRectMake(0, 200, KABINScrennWidth, 30);
        [self.maskView addSubview:self.operationView];
        
        self.playButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.playButton setImage:[UIImage imageNamed:@"ad_pause_f_p"] forState:UIControlStateNormal];
        [self.playButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        self.playButton.frame=CGRectMake(10, 0, 30, 30);
        [self.operationView addSubview:self.playButton];
        
        self.progress=[[UIProgressView alloc]initWithFrame:CGRectMake(50, 14, KABINScrennWidth-200, 2)];
        self.progress.progress=0;
        self.progress.progressTintColor=[UIColor colorWithRed:1.000 green:0.599 blue:0.345 alpha:1.0];
        
        [self.operationView addSubview:self.progress];
        
        self.slider=[[UISlider alloc]initWithFrame:CGRectMake(48, 14, KABINScrennWidth-200, 1)];
        self.slider.maximumTrackTintColor=[UIColor clearColor];
        UIImage *thumImage=[self OriginImage:[UIImage imageNamed:@"playButton"] scaleToSize:CGSizeMake(15, 15)];
        [self.slider setThumbImage:thumImage forState:UIControlStateNormal];
        [self.operationView addSubview:self.slider];
        [self.slider addTarget:self action:@selector(handleSlider:) forControlEvents:UIControlEventValueChanged];
        
        
        self.timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(KABINScrennWidth-110, 0, 90, 30)];
        self.timeLabel.textColor=[UIColor blackColor];
        self.timeLabel.textAlignment=NSTextAlignmentLeft;
        self.timeLabel.font=[UIFont systemFontOfSize:13];
        self.timeLabel.text=@"00:00";
        [self.operationView addSubview:self.timeLabel];
    }
    return _player;
}

-(void)click:(UIButton*)b{
    if (b.selected) {
        [self.player play];
        [b setImage:[UIImage imageNamed:@"ad_pause_f_p"] forState:UIControlStateNormal];
    }else{
        [self.player pause];
        [b setImage:[UIImage imageNamed:@"ad_play_f_p"] forState:UIControlStateNormal];
    }
    b.selected=!b.selected;
}

-(void)Stack{
    //(self.item.duration.value / self.item.duration.timescale)
    
    self.slider.maximumValue=1;

    self.slider.value=CMTimeGetSeconds([self.item currentTime])/self.timeV  ;
    NSInteger proMin = (NSInteger)CMTimeGetSeconds([self.player currentTime]) / 60;//当前秒
    NSInteger proSec = (NSInteger)CMTimeGetSeconds([self.player currentTime]) % 60;//当前分钟
    //self.item.duration.value /
    NSInteger durMin = (NSInteger)self.timeV/ 60;//总秒
    //(NSInteger)self.item.duration.value /
    NSInteger durSec = (NSInteger)self.timeV % 60;//总分钟
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:%02ld / %ld:%ld", proMin, proSec, durMin, durSec];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
     if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration = self.item.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.progress setProgress:timeInterval / totalDuration animated:NO];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}


-(void)handleSlider:(UISlider *)s{
    if (self.player.status==AVPlayerStatusReadyToPlay) {
        CGFloat total=(CGFloat)self.item.duration.value/self.item.duration.timescale;
        NSInteger dragedSeconds=floor(total*s.value);
        CMTime dragedCMTime=CMTimeMake(dragedSeconds, 1);
        [self.player pause];
        [self.player seekToTime:dragedCMTime completionHandler:^(BOOL finished) {
            [self.player play];
        }];
    }
}

-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

-(void)pop{
    [self.player pause];
    [self.navigationController popViewControllerAnimated:YES];
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    
}

-(void)dealloc{
    
    [self.timer invalidate];
    self.timer=nil;
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    KABINLog(@"********************************************************************");
    
}

@end
