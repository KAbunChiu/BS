//
//  u.h
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface u : NSObject

@property (nonatomic, strong) NSArray * header;
@property (nonatomic, strong) NSNumber * is_v;
@property (nonatomic, strong) NSNumber * is_vip;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * room_icon;
@property (nonatomic, copy) NSString * room_name;
@property (nonatomic, copy) NSString * room_role;
@property (nonatomic, copy) NSString * room_url;
@property (nonatomic, copy) NSString * uid;

@property (nonatomic,assign)CGFloat textW;

@end
