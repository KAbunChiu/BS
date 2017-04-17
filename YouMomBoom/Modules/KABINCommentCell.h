//
//  KABINCommentCell.h
//  YouMomBoom
//
//  Created by KAbun on 17/4/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KABINCommentModel.h"
@interface KABINCommentCell : UITableViewCell

@property(nonatomic,strong)userModel *uModel;

@property(nonatomic,strong)CommentListModel *lModel;

@end
