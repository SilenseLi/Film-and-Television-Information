//
//  RankingHttpTool.h
//  DoubanWorlds
//
//  Created by 李增辉 on 16/5/3.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailMovieModel;

typedef void (^RankingBlock)(DetailMovieModel *rankingModel);

@interface RankingHttpTool : NSObject

/**
 * 排行Top250
 *  @param start      开始页
 *  @param arrayBlock 返回数组
 */
+ (void)getRankingWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock;

/**
 *  电影详细信息
 *
 *  @param movieID 电影ID
 */
+(void)getRankingWithID:(NSString *)movieID rankingBlock:(RankingBlock)rankingBlock;


@end
