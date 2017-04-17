//
//  KABINTextView.m
//  YouMomBoom
//
//  Created by KAbun on 17/4/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINTextView.h"

@implementation KABINTextView

+(instancetype)commentText{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

@end
