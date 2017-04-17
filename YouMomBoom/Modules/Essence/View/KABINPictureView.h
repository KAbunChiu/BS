//
//  KABINPictureView.h
//  YouMomBoom
//
//  Created by KAbun on 17/1/9.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINContentView.h"
#import "listModel.h"
@interface KABINPictureView : KABINContentView
+ (instancetype)pictureView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImage;
@property(nonatomic,strong) listModel *model;
-(void)setupImageURL:(id)URL andGIF:(BOOL)isGIF andBigImage:(BOOL)big;
@end
