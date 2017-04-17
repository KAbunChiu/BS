//
//  KABINGifHeader.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/11.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINGifHeader.h"

@implementation KABINGifHeader

-(void)prepare{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bdj_mj_refresh_%ld", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    //设置即将刷新的动画图片
    NSMutableArray *refreshImage = [NSMutableArray array];
    for (NSUInteger i = 1; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bdj_mj_refresh_%ld",i]];
        [refreshImage addObject:image];
    }
    
    [self setImages:refreshImage forState:MJRefreshStateRefreshing];
}

@end
