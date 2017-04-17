//
//  GuideDetailModel.h
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class info;
@class listModel;

@interface GuideDetailModel : NSObject

@property (nonatomic, strong) info * info;
@property (nonatomic, strong) NSArray<listModel*> * list;

@end
