//
//  YRShaHeObjct.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRShaHeObjct : NSObject
//获得document
+(NSString *)documentsPath;

//获得document文件路径，名字方便记忆
+(NSString *) DocumentPath:(NSString *)filename;

//获得document文件路径
+(NSString *)fullpathOfFilename:(NSString *)filename;
//写入文件沙盒位置NSDictionary

+(void)saveNSDictionaryForDocument:(NSData *)list  FileUrl:(NSString*) FileUrl;
//加载文件沙盒NSDictionary
+(UIImage *)loadNSDictionaryForDocument  : (NSString*) FileUrl;
@end
