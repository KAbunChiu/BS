//
//  listModel.h
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class tags;
@class u;
@class video;
@class top_comments;
@class gif;
@class image;

@interface listModel : NSObject

@property (nonatomic, copy) NSString * bookmark;
@property (nonatomic, copy) NSString * comment;
@property (nonatomic, strong) NSNumber * down;
@property (nonatomic, strong) NSNumber * forward;
@property (nonatomic, copy) NSString * ord_ID;
@property (nonatomic, copy) NSString * passtime;
@property (nonatomic, copy) NSString * share_url;
@property (nonatomic, strong) NSNumber * status;
@property (nonatomic, strong) NSArray<tags *> * tags;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, strong) NSArray<top_comments *> * top_comments;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, strong) u * u;
@property (nonatomic, copy) NSString * up;
@property (nonatomic, strong) video * video;
@property(nonatomic,strong) gif *gif;
@property(nonatomic,strong) image *image;


@property(nonatomic,assign) CGFloat cellHeight;
@property(nonatomic,assign) CGRect contentFrame;
@end
