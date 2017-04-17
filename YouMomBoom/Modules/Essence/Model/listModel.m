//
//  listModel.m
//  __projectName__
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KAbun. All rights reserved.
//

#import "listModel.h"
#import "tags.h"
#import "u.h"
#import "video.h"
#import "top_comments.h"
#import <MJExtension.h>
#import "image.h"
#import "gif.h"

@implementation listModel

+ (NSDictionary *)mj_objectClassInArray{
	return @{@"tags":@"tags",@"u":@"u",@"video":@"video",@"top_comments":@"top_comments",@"gif":@"gif",@"image":@"image"};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ord_ID":@"id"};
}

-(CGFloat)cellHeight{
    if (!_cellHeight) {
//        KABINLog(@"************%@",self.image.big);
//        KABINLog(@"/////-/-/-/-/-/%@",self.image.medium);
//        KABINLog(@"++++++++++%@",self.image.small);
        CGFloat textX = 10;
        CGFloat textY = 50;
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * textX - 2 * 10;

        CGFloat textH=[self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height+20;
        
        CGFloat maxY=textY+textH;
        
        if (![self.type isEqualToString:@"text"]) {
            CGFloat contentX = textX;
            CGFloat contentY = maxY;
            CGFloat contentW = textW;
            CGFloat widthScale;
            CGFloat contentH;
            if ([self.type isEqualToString:@"image"]) {
                widthScale = [self.image.width floatValue] / contentW;
                contentH  = [self.image.height floatValue] / widthScale;
            }else if ([self.type isEqualToString:@"gif"]){
                widthScale = [self.gif.width floatValue] / contentW;
                contentH  = [self.gif.height floatValue] / widthScale+20;
            }else if ([self.type isEqualToString:@"video"]){
                contentH = 250;
            }
           
            if (contentH > 2000) {
                contentH = 350;
                self.image.isBig = YES;
            }
            
            self.contentFrame = CGRectMake(contentX, contentY+10, contentW, contentH);
            maxY = contentY + contentH + 10;
        }
        
        // cell的高度
        self.cellHeight = maxY + 60;
    }
    return _cellHeight;
}


@end
