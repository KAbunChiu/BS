//
//  top_comments.m
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import "top_comments.h"
#import "u.h"
#import <MJExtension.h>
@implementation top_comments

+ (NSDictionary *)mj_objectClassInArray{
	return @{@"u":@"u"};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ord_ID":@"id"};
}

@end
