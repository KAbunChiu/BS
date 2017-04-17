//
//  image.h
//  __projectName__
//
//  Created by KAbun on 17/01/06.
//  Copyright © 2017年 KAbun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface image : NSObject

@property (nonatomic, strong) NSArray * big;
@property (nonatomic, strong) NSArray * download_url;
@property (nonatomic, strong) NSNumber * height;
@property (nonatomic, strong) NSArray * medium;
@property (nonatomic, strong) NSArray * small;
@property (nonatomic, strong) NSArray * thumbnail_small;
@property (nonatomic, strong) NSNumber * width;


@property(nonatomic,assign) BOOL isImage;
@property(nonatomic,assign) BOOL isBig;
@end
