//
//  CommenDefines.h
//  AnecdotesDemo
//
//  Created by LYoung on 15/10/13.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#ifndef AnecdotesDemo_CommenDefines_h
#define AnecdotesDemo_CommenDefines_h



// 打印
#ifdef DEBUG

#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#define KColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0                            alpha:1.0]

#define     SCREEN_HEIGHT                   ([[UIScreen mainScreen] bounds].size.height)
#define     SCREEN_WIDTH                    ([[UIScreen mainScreen] bounds].size.width)
#define     NAV_BAR_HEIGHT                   64
#define     TAB_BAR_HEIGHT                   49


#endif


#define HMStatusCellMargin 15

#define TheThemeColor KColor(63, 184, 56)//主题颜色
#define KBackgroundColor KColor(244, 244, 244)//背景颜色

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define iOS8 ([[[UIDevice currentDevice]systemVersion]doubleValue]>= 8.0)
#define iPHone6 ([UIScreen mainScreen].bounds.size.height > 568) ? YES : NO

#define HotCityButtonWith ([UIScreen mainScreen].bounds.size.height > 568) ? 100.f : 80.f
#define HotCityButtonHeight 36.f
#define HotCityButtonMargin 10.f

#define SearchBarHeight 44.f

#define KActivityDetailHeadH 280.f

#define KMovieDetailHeadH 250.f

#define MovieMenuHeight 45.f


#pragma mark - 用户信息 -

#define     USER_status          @"useraltstatus"
#define     USER_alt             @"useralt"
#define     USER_avatar          @"useravatar"
#define     USER_created         @"usercreated"
#define     USER_desc            @"userdesc"
#define     USER_is_banned       @"useris_banned"
#define     USER_is_suicide      @"useris_suicide"
#define     USER_large_avatar    @"userlarge_avatar"
#define     USER_loc_id          @"userloc_id"
#define     USER_loc_name        @"userloc_name"
#define     USER_name            @"username"
#define     USER_signature       @"usersignature"
#define     USER_type            @"usertype"
#define     USER_uid             @"useruid"

#define APPKey @"572af06767e58ea0ec0024de"

#define ZERO (0)

///设定随机色
#define RGB_ARC_COLOR ([UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1.0f])
#define RGB_WHITE_COLOR ([UIColor whiteColor])

///设定自定义颜色
#define RGB_COLOR(r,g,b) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f])

///创建视图
#define CREAT_UI(UI,a,b,c,d) ([[UI alloc] initWithFrame:CGRectMake(a, b, c, d)])

/**
 消除performSelector警告的宏
 */
///消除警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)




