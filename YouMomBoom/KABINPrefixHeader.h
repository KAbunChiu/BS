//
//  KABINPrefixHeader.h
//  YouMomBoom
//
//  Created by KAbun on 16/12/30.
//  Copyright © 2016年 KABIN. All rights reserved.
//

#ifndef KABINPrefixHeader_h
#define KABINPrefixHeader_h

#ifdef DEBUG
#define KABINLog(...) NSLog(__VA_ARGS__)
#else
#define KABINLog(...)
#endif


// 颜色
#define KABINColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//屏幕宽高
#define KABINScrennWidth [[UIScreen mainScreen] bounds].size.width
#define KABINScrennHeight [[UIScreen mainScreen] bounds].size.height

#define HomeNET @"http://s.budejie.com/"

#define CommentNet @"http://c.api.budejie.com/topic/comment_list/"

#endif /* KABINPrefixHeader_h */
