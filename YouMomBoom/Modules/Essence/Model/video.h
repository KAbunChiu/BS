//
//  video.h
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface video : NSObject

@property (nonatomic, strong) NSArray * download;
@property (nonatomic, strong) NSNumber * duration;
@property (nonatomic, strong) NSNumber * height;
@property (nonatomic, strong) NSNumber * playcount;
@property (nonatomic, strong) NSNumber * playfcount;
@property (nonatomic, strong) NSArray * thumbnail;
@property (nonatomic, strong) NSArray * thumbnail_small;
@property (nonatomic, strong) NSArray * video;
@property (nonatomic, strong) NSNumber * width;

@end
