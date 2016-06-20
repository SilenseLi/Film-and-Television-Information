//
//  RankingHttpTool.m
//  DoubanWorlds
//
//  Created by 李增辉 on 16/5/3.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "RankingHttpTool.h"
#import "MovieModel.h"
#import "DetailMovieModel.h"

@implementation RankingHttpTool

+ (void)getRankingWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock{
    NSString *urlSting = [NSString stringWithFormat:@"%@?count=10&start=%ld",Ranking_URL,start];
    NSLog(@"Ranking_URL = %@",urlSting);
    [HttpTools getWithURL:urlSting params:nil success:^(id json) {
        NSMutableArray *resArray = [[NSMutableArray alloc] init];
        if ([json[@"subjects"] isKindOfClass:[NSArray class]]) {
            NSArray *subjectsArr = json[@"subjects"];
            for (NSDictionary *dict in subjectsArr) {
                MovieModel *movieM = [[MovieModel alloc] initWithDictionary:dict];
                [resArray addObject:movieM];
            }
        }
        if (arrayBlock) {
            arrayBlock(resArray);
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}

+ (void)getRankingWithID:(NSString *)movieID rankingBlock:(RankingBlock)rankingBlock{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",Ranking_URL,movieID];
    NSLog(@"Ranking_URL = %@",urlString);
    [HttpTools getWithURL:urlString params:nil success:^(id json) {
        
        DetailMovieModel *model = [[DetailMovieModel alloc] init];
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = json;
            DetailMovieModel *m = [[DetailMovieModel alloc] initWithDictionary:dict];
            model = m;
        }
        rankingBlock(model);
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}

@end
