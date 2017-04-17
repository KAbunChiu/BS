//
//  image.m
//  __projectName__
//
//  Created by KAbun on 17/01/06.
//  Copyright © 2017年 KAbun. All rights reserved.
//

#import "image.h"
@implementation image

-(BOOL)isImage{
    if (self.big==nil) {
        _isImage=NO;
    }else{
        _isImage=YES;
    }
    return _isImage;
}

@end
