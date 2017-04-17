//
//  KABINMediaView.h
//  YouMomBoom
//
//  Created by KAbun on 17/1/9.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINContentView.h"

@interface KABINMediaView : KABINContentView
+ (instancetype)videoView;
-(void)setupPlayCount:(NSInteger)playCount andTime:(NSInteger)time andImageURL:(NSString *)URL;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@end
