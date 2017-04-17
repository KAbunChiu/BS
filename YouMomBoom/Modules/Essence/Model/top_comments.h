//
//  top_comments.h
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class u;

@interface top_comments : NSObject

@property (nonatomic, copy) NSString * cmt_type;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, strong) NSNumber * hate_count;
@property (nonatomic, strong) NSNumber * ord_ID;
@property (nonatomic, strong) NSNumber * like_count;
@property (nonatomic, copy) NSString * passtime;
@property (nonatomic, strong) NSNumber * precid;
@property (nonatomic, strong) NSNumber * preuid;
@property (nonatomic, strong) NSNumber * status;
@property (nonatomic, strong) u * u;
@property (nonatomic, strong) NSNumber * voicetime;
@property (nonatomic, copy) NSString * voiceuri;

@end
