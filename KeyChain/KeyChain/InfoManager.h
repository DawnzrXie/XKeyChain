//
//  InfoManager.h
//  KeyChain
//
//  Created by 三维度 on 2017/4/27.
//  Copyright © 2017年 三维度. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoManager : NSObject

/**
 值就是存在钥匙串中的信息
 */
@property (nonatomic, strong) NSMutableDictionary *singleDic;


/**
 单例

 @return self对象
 */
+ (id)share;

@end
