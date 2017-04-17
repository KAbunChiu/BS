//
//  KABINMediaView.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/9.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINMediaView.h"
#import <UIImageView+WebCache.h>

@interface KABINMediaView()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
@implementation KABINMediaView

+ (instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


-(void)setupPlayCount:(NSInteger )playCount andTime:(NSInteger )time andImageURL:(NSString *)URL{
    self.playCountLabel.text=[NSString stringWithFormat:@"%ld播放",playCount];
    NSInteger minutes=time%60;
    if (time>60) {
        self.timeLabel.text=[NSString stringWithFormat:@"%ld:%ld",time/60,minutes];
    }else{
        self.timeLabel.text=[NSString stringWithFormat:@"00:%ld",minutes];
    }
    
    [self.backgroundImage sd_setImageWithURL:[NSURL URLWithString:URL]];
    self.backgroundImage.contentMode=UIViewContentModeScaleAspectFill;
}





@end
