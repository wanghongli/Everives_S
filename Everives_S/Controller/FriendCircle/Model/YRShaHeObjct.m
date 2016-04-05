//
//  YRShaHeObjct.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRShaHeObjct.h"

@implementation YRShaHeObjct
+(NSString *)documentsPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
    
}

//获得document文件路径，名字方便记忆

+(NSString *) DocumentPath:(NSString *)filename {
    
    NSString *documentsPath = [self documentsPath];
    
    // NSLog(@"documentsPath=%@",documentsPath);
    
    return [documentsPath stringByAppendingPathComponent:filename];
    
}
//写入文件沙盒位置NSDictionary

+(void)saveNSDictionaryForDocument:(NSData *)list  FileUrl:(NSString*) FileUrl  {
    
    
    
    NSString *f = [self fullpathOfFilename:FileUrl];
    
    
    [list writeToFile:f atomically:YES];
//    [list writeToFile:f atomically:YES];
    
}
//获得document文件路径

+(NSString *)fullpathOfFilename:(NSString *)filename {
    
    NSString *documentsPath = [self documentsPath];
    
    // NSLog(@"documentsPath=%@",documentsPath);
    
    return [documentsPath stringByAppendingPathComponent:filename];
    
}
//加载文件沙盒NSDictionary
+(UIImage *)loadNSDictionaryForDocument: (NSString*) FileUrl {
    
    NSString *f = [self fullpathOfFilename:FileUrl];
    
    UIImage *list = [UIImage imageWithData:[NSData dataWithContentsOfFile:f]];
    
    return list;
}
@end
