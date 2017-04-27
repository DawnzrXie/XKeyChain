//
//  XKeyChain.h
//  KeyChain
//
//  Created by 三维度 on 2017/4/5.
//  Copyright © 2017年 三维度. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/security.h>

@interface XKeyChain : NSObject

/**
 保持数据到钥匙串的方法

 @param data 对应字典的值（保存的文本信息）
 @param key  对应字典的键（一条信息一个键）
 这对键值保存在单例的字典里
 */
+ (void)saveData:(id)data key:(NSString *)key;

/**
 加载存在钥匙串中键对应的信息

 @param key 对应的键
 @return 键对应的值
 */
+ (id)loadDataKey:(NSString *)key;

/**
 删除该APP存在钥匙串中的所有信息（一般用不上）
 */
+ (void)deleteData;

@end
