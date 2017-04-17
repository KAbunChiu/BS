//
//  gif.h
//  __projectName__
//
//  Created by KAbun on 17/01/06.
//  Copyright © 2017年 KAbun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gif : NSObject

@property (nonatomic, strong) NSArray * download_url;
@property (nonatomic, strong) NSArray * gif_thumbnail;
@property (nonatomic, strong) NSNumber * height;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSNumber * width;

@property(nonatomic,assign) BOOL isGif;
@end
