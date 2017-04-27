//
//  InfoManager.m
//  KeyChain
//
//  Created by 三维度 on 2017/4/27.
//  Copyright © 2017年 三维度. All rights reserved.
//

#import "InfoManager.h"

@implementation InfoManager

+ (id)share {
    static InfoManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}


#pragma mark - getter Methods
- (NSMutableDictionary *)singleDic {
    
    if (!_singleDic) {
        _singleDic = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return _singleDic;
}


@end
