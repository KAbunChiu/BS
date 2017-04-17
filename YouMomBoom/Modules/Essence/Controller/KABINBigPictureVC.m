//
//  KABINBigPictureVC.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/10.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINBigPictureVC.h"
#import <UIImageView+WebCache.h>
#import "UIView+Extension.h"
@interface KABINBigPictureVC ()

@end

@implementation KABINBigPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
     self.automaticallyAdjustsScrollViewInsets = YES;
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KABINScrennWidth, KABINScrennHeight)];
    [self.view addSubview:scrollView];
    
    UIImageView *image=[UIImageView new];
    [image sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:nil];
    [scrollView addSubview:image];
    image.width=scrollView.width;
    image.height=image.width*self.height/self.width;
    image.x=0;
    if (image.height>KABINScrennHeight) {
        image.y=0;
        scrollView.contentSize=CGSizeMake(0, image.height);
    }else{
        image.centerY=scrollView.height*0.5;
    }

    CGFloat maxScale=self.width/image.width;
    if (maxScale>1) {
        scrollView.maximumZoomScale=maxScale;
    }
}


@end
