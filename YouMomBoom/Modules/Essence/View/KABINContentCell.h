//
//  KABINContentCell.h
//  YouMomBoom
//
//  Created by KAbun on 17/1/5.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "listModel.h"
#import "u.h"

typedef void (^videoBlock)(NSString *,CGFloat);
typedef void (^pictureBlock)(CGFloat,NSString*,CGFloat);

typedef void (^commentBlock)();

@interface KABINContentCell : UITableViewCell

@property(nonatomic,strong) listModel *model;

@property(nonatomic,copy)  videoBlock  vblock;
@property(nonatomic,copy) pictureBlock pblock;
@property(nonatomic,copy)  commentBlock  comblock;


@end
