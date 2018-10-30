//
//  INetworking.h
//  iTestAFNetworking
//
//  Created by administrator on 15/11/23.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INetwrokingManager [INetworking shareNet]

//save str 确定. 不会引起崩溃.

#define SaveStr(value)\
({id tmp;\
if ([value isKindOfClass:[NSNull class]])\
tmp = nil;\
else\
 tmp = value;\
tmp;\
})\

//登录账号信息
extern NSString * const loginUrlStr;

@interface INetworking : NSObject

@property (nonatomic,copy) NSString *ipstr;

/**
 *  是否存在数据网络;
 */

@property (nonatomic,readonly,assign) BOOL isNetworking;

//下载失败的block

@property (nonatomic,copy) void(^errorDolowdToDo)();

+(INetworking*)shareNet;

-(void)GET:(NSString*)URLString withParmers:(NSDictionary *)parmers do:(void(^)(id returnObject,BOOL isSuccess))myblok;

-(void)POST:(NSString*)object parameters:(id)parameters do:(void(^)(id returnObject,BOOL isSuccess))myblok;

@end

