//
//  gif.m
//  __projectName__
//
//  Created by KAbun on 17/01/06.
//  Copyright © 2017年 KAbun. All rights reserved.
//

#import "gif.h"
@implementation gif
-(BOOL)isGif{
    if (self.images!=nil) {
        _isGif=YES;
    }else{
        _isGif=NO;
    }
    return _isGif;
}
@end
