//
//  KABINTagsButton.m
//  YouMomBoom
//
//  Created by KAbun on 17/1/3.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINTagsButton.h"

@implementation KABINTagsButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];

    }
    return self;
}

@end
