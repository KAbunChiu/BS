//
//  u.m
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import "u.h"
#import <MJExtension.h>
@implementation u
-(CGFloat)textW{
    if (!_textW) {
        CGFloat topH=20;
        CGFloat nameW=[self.name boundingRectWithSize:CGSizeMake(MAXFLOAT, topH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
        _textW=nameW;
    }
    return _textW;
}
@end
