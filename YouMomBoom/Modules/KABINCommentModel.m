//
//  KABINCommentModel.m
//  YouMomBoom
//
//  Created by KAbun on 17/4/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import "KABINCommentModel.h"
#import <MJExtension.h>

@implementation userModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",};
}

@end

@implementation CommentListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",
                   @"userModel":@"user"};
}

-(CGFloat)height{
    if (!_height) {
        CGFloat contentH=86;
        CGFloat textH;
        CGFloat textW=KABINScrennWidth-86;
        textH=[self.content boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height+5;
        _height=textH+contentH;
    }
    return _height;
}

@end

@implementation infoModel

@end

@implementation normalModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"listModel":[CommentListModel class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"infoModel":@"info",
             @"listModel":@"list"};
}



@end

@implementation hotModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"listModel":[CommentListModel class]};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"infoModel":@"info",
                   @"listModel":  @"list"};
}



@end

@implementation KABINCommentModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"hotModel":@"hot",
                    @"normalModel":@"normal"};
}

@end
