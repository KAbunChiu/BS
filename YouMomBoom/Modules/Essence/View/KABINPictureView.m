//
//  KABINPictureView.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/9.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINPictureView.h"
#import <M13ProgressViewRing.h>
#import <UIImageView+WebCache.h>
@interface KABINPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet M13ProgressViewRing *progressView;

@end
@implementation KABINPictureView

+(instancetype)pictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)setupImageURL:(id)URL andGIF:(BOOL)isGIF andBigImage:(BOOL)big{
    [self.PictureImage sd_setImageWithURL:[NSURL URLWithString:URL ] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden=NO;
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
    }];
//    [self.PictureImage sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:nil];
//    self.progressView.hidden=YES;
   
    self.gifView.hidden=!isGIF;
    if (big) {
        self.PictureImage.layer.contentsRect=CGRectMake(0, 0, 1, 0.1);
        self.seeBigImage.hidden=NO;
    }else{
        self.PictureImage.layer.contentsRect=CGRectMake(0, 0, 1, 1);
        self.seeBigImage.hidden=YES;
    }
}
@end
