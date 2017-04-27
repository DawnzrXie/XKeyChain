//
//  XKeyChain.m
//  KeyChain
//
//  Created by 三维度 on 2017/4/5.
//  Copyright © 2017年 三维度. All rights reserved.
//

#import "XKeyChain.h"
#import "InfoManager.h"

static NSString *const KEY_BUILD_ID = @"demo.xzr.KeyChain"; //区分app的键（每个app不一样）
static NSString *const KEY_BUILD_ID_SUB = @"demo.xzr.passWord"; //与keyBuildId唯一对应生成的键，该键对应的值就是具体存在钥匙串中的信息（包括多条信息）
@implementation XKeyChain


/**
 把信息存放到钥匙串当中
 
 @param data 存放的信息（可以是字典、数组、字符串）
 @param key 键值（传入不同键值实现多次信息存储）
 */
+ (void)saveData:(id)data key:(NSString *)key{
    
    NSMutableDictionary *informationDic = [NSMutableDictionary dictionary];
    InfoManager *manager = [InfoManager share];
    [manager.singleDic setObject:data forKey:key];
    [informationDic setObject:manager.singleDic forKey:KEY_BUILD_ID_SUB];
    [self saveInformationDic:informationDic];
}

+ (void)saveInformationDic:(NSMutableDictionary *)informationDic {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:KEY_BUILD_ID];
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:informationDic] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

/**
 获取存在钥匙串中的信息

 @param key 对应的键值
 @return 钥匙串中对应键的值
 */
+ (id)loadDataKey:(NSString *)key {
    
    NSMutableDictionary *keyBuildIdSubDic = [self load:KEY_BUILD_ID];
    NSMutableDictionary *informationDic = keyBuildIdSubDic[KEY_BUILD_ID_SUB];
   return informationDic[key];
}

+ (NSMutableDictionary *)load:(NSString *)keyBuildId {
    NSMutableDictionary *ret = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:keyBuildId];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", keyBuildId, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

/**
 删除存在钥匙串中该APP的所有信息
 */
+ (void)deleteData {
    
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:KEY_BUILD_ID];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)keyBuildId {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            keyBuildId, (id)kSecAttrService,
            keyBuildId, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}



@end
