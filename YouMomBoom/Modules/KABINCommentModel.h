//
//  KABINCommentModel.h
//  YouMomBoom
//
//  Created by KAbun on 17/4/13.
//  Copyright © 2017年 KABIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface userModel : NSObject

@property (nonatomic, strong) NSNumber * ID;

@property (nonatomic, strong) NSNumber * is_vip;

@property (nonatomic, copy) NSString * personal_page;

@property (nonatomic, copy) NSString * profile_image;

@property (nonatomic, copy) NSString * qq_uid;

@property (nonatomic, copy) NSString * qzone_uid;

@property (nonatomic, copy) NSString * room_icon;

@property (nonatomic, copy) NSString * room_name;

@property (nonatomic, copy) NSString * room_role;

@property (nonatomic, copy) NSString * room_url;

@property (nonatomic, copy) NSString * sex;

@property (nonatomic, copy) NSString * total_cmt_like_count;

@property (nonatomic, copy) NSString * username;

@property (nonatomic, copy) NSString * weibo_uid;

@end

@interface CommentListModel : NSObject

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * ctime;

@property (nonatomic, strong) NSNumber * data_id;

@property (nonatomic, strong) NSNumber * hate_count;

@property (nonatomic, strong) NSNumber * ID;

@property (nonatomic, strong) NSNumber * like_count;

@property (nonatomic, strong) NSArray * precmts;

@property (nonatomic, strong) NSNumber * status;

@property (nonatomic, copy) NSString * type;

@property (nonatomic, strong) userModel * userModel;

@property (nonatomic, strong) NSArray * vote;

@property (nonatomic, assign)CGFloat height;
@end

@interface infoModel : NSObject

@property (nonatomic, strong) NSNumber * count;

@property (nonatomic, strong) NSNumber * np;

@end

@interface normalModel : NSObject

@property(nonatomic,strong)infoModel *infoModel;

@property(nonatomic,strong)NSArray<CommentListModel*> *listModel;

@end

@interface hotModel : NSObject

@property(nonatomic,strong)infoModel *infoModel;

@property(nonatomic,strong)NSArray<CommentListModel*> *listModel;

@end

@interface KABINCommentModel : NSObject

@property (nonatomic, strong) NSNumber * author_uid;

@property (nonatomic,strong)hotModel *hotModel;

@property (nonatomic,strong)normalModel  *normalModel;

@end
