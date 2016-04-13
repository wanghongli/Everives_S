//
//  YRMapFMDB.m
//  Everives_S
//
//  Created by darkclouds on 16/4/12.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMapFMDB.h"
#import "YRSchoolModel.h"
@implementation YRMapFMDB
static FMDatabase *fmdb;
+(void)initFmdb
{
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"schools.sqlite"];
    
    //2.获得数据库
    fmdb = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([fmdb open])
    {
        //4.创表
        BOOL result = [fmdb executeUpdate:@"CREATE TABLE if not exists t_school (id integer primary key,school text,name text,address text,grade text,lat text,lng text,imaageurl text);"];
        
        if (result)
        {
            MyLog(@"创建表成功");
        }else{
            MyLog(@"创建表失败");
        }
    }
}
+(void)saveObjects:(NSArray *)objArry{
    if (!fmdb) {
        [YRMapFMDB initFmdb];
    }
    [objArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YRSchoolModel *model = obj;
        NSString *insertSQL = @"INSERT INTO t_school (id,school,name,address,grade,lat,lng,imaageurl) VALUES (?, ?,?, ?,?, ?,?, ?)";
        [fmdb executeUpdate:insertSQL,model.id,model.school,model.name,model.address,model.grade,model.lat,model.lng,model.imaageurl];
    }];
}

+(NSArray*)GetSchools{
    if (!fmdb) {
        [YRMapFMDB initFmdb];
    }
    NSMutableArray *schools = @[].mutableCopy;
    NSString *querySQL = @"SELECT * FROM t_school";
    //执行查询
    FMResultSet *resultSet = [fmdb executeQuery:querySQL];
    //遍历结果集
    while ([resultSet next]) {
        YRSchoolModel *model = [[YRSchoolModel alloc] init];
        model.id = [resultSet stringForColumn:@"id"];
        model.school = [resultSet stringForColumn:@"school"];
        model.name = [resultSet stringForColumn:@"name"];
        model.address = [resultSet stringForColumn:@"address"];
        model.grade = [resultSet stringForColumn:@"grade"];
        model.lat = [resultSet stringForColumn:@"lat"];
        model.lng = [resultSet stringForColumn:@"lng"];
        model.imaageurl = [resultSet stringForColumn:@"imaageurl"];
        [model setCoordinate:CLLocationCoordinate2DMake([model.lat doubleValue], [model.lng doubleValue])];
        [schools addObject:model];
    }
    return schools.copy;
}
@end
