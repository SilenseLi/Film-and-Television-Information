//
//  AvatarsModel.m
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import "AvatarsModel.h"

@implementation AvatarsModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(id)valueForKeyPath:(NSString *)keyPath
{
    return nil;
}

@end
