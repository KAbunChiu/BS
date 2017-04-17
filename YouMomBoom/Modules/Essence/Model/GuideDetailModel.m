//
//  GuideDetailModel.m
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import "GuideDetailModel.h"
#import "info.h"
#import "listModel.h"
#import <MJExtension.h>
@implementation GuideDetailModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{@"info":@"info",@"list":[listModel class]};
}

@end
