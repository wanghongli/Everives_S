//
//  YRFMDBObj.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFMDBObj.h"

@implementation YRFMDBObj
+(FMDatabase *)initFmdb
{
    FMDatabase *db;
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"question.sqlite"];
    
    //2.获得数据库
    db = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        //4.创表
        BOOL result = [db executeUpdate:@"CREATE TABLE if not exists t_question (analy text, content text,option text,pics text,answer integer,kind integer,type integer,id integer primary key,collect integer,error integer,already integer,chooseAnswer integer);"];

        if (result)
        {
            MyLog(@"创建表成功");
        }else{
            MyLog(@"创建表失败");
        }
    }
    return db;
}

+ (NSMutableArray *) getShunXuPracticeWithType:(NSInteger)type withFMDB:(FMDatabase *)db
{
    NSMutableArray *array = [NSMutableArray array];
        // 查询数据
        //@"SELECT * FROM t_question where id=1"
        //@"SELECT * FROM t_question where content='驾驶机动车在道路上违反道路交通安全法的行为，属于什么行为？'"
    NSString *stirng = [NSString stringWithFormat:@"SELECT * FROM t_question where type=%ld",type];
        FMResultSet *rs = [db executeQuery:stirng];
    
        while ([rs next]) {
            YRQuestionObj *questionObj = [[YRQuestionObj alloc]init];
            questionObj.content = [rs stringForColumn:@"content"];
            questionObj.option = [self arrayWithJsonString:[rs stringForColumn:@"option"]];
            questionObj.analy = [rs stringForColumn:@"analy"];
            questionObj.pics = [rs stringForColumn:@"pics"];
            questionObj.answer = [rs intForColumn:@"answer"];
            questionObj.kind = [rs intForColumn:@"kind"];
            questionObj.type = [rs intForColumn:@"type"];
            questionObj.id = [rs intForColumn:@"id"];
            questionObj.collect = [rs intForColumn:@"collect"];
            questionObj.already = [rs intForColumn:@"already"];
            questionObj.error = [rs intForColumn:@"error"];
            [array addObject:questionObj];
        }
    return array;
}
+ (NSMutableArray *) getPracticeWithType:(NSInteger)type withSearchMsg:(NSString*)search withFMDB:(FMDatabase *)db
{
    NSMutableArray *array = [NSMutableArray array];
    // 查询数据
    //@"SELECT * FROM t_question where id=1"
    //@"SELECT * FROM t_question where content='驾驶机动车在道路上违反道路交通安全法的行为，属于什么行为？'"
    NSString *stirng = [NSString stringWithFormat:@"SELECT * FROM t_question where type=%ld and %@",type,search];
    FMResultSet *rs = [db executeQuery:stirng];
    
    while ([rs next]) {
        YRQuestionObj *questionObj = [[YRQuestionObj alloc]init];
        questionObj.content = [rs stringForColumn:@"content"];
        questionObj.option = [self arrayWithJsonString:[rs stringForColumn:@"option"]];
        questionObj.analy = [rs stringForColumn:@"analy"];
        questionObj.pics = [rs stringForColumn:@"pics"];
        questionObj.answer = [rs intForColumn:@"answer"];
        questionObj.kind = [rs intForColumn:@"kind"];
        questionObj.type = [rs intForColumn:@"type"];
        questionObj.id = [rs intForColumn:@"id"];
        questionObj.collect = [rs intForColumn:@"collect"];
        questionObj.already = [rs intForColumn:@"already"];
        questionObj.error = [rs intForColumn:@"error"];
        [array addObject:questionObj];
    }
    return array;
}

+ (NSMutableArray *) getErrorPracticeWithType:(NSInteger)type withFMDB:(FMDatabase *)db
{
    NSMutableArray *array = [NSMutableArray array];
    // 查询数据
    //@"SELECT * FROM t_question where id=1"
    //@"SELECT * FROM t_question where content='驾驶机动车在道路上违反道路交通安全法的行为，属于什么行为？'"
    NSString *stirng = [NSString stringWithFormat:@"SELECT * FROM t_question where type=%ld and error = %d",type,1];
    FMResultSet *rs = [db executeQuery:stirng];
    
    while ([rs next]) {
        YRQuestionObj *questionObj = [[YRQuestionObj alloc]init];
        questionObj.content = [rs stringForColumn:@"content"];
        questionObj.option = [self arrayWithJsonString:[rs stringForColumn:@"option"]];
        questionObj.analy = [rs stringForColumn:@"analy"];
        questionObj.pics = [rs stringForColumn:@"pics"];
        questionObj.answer = [rs intForColumn:@"answer"];
        questionObj.kind = [rs intForColumn:@"kind"];
        questionObj.type = [rs intForColumn:@"type"];
        questionObj.id = [rs intForColumn:@"id"];
        questionObj.error = [rs intForColumn:@"collect"];
        questionObj.already = [rs intForColumn:@"already"];
        questionObj.error = [rs intForColumn:@"error"];
        [array addObject:questionObj];
    }
    return array;
}
+ (NSMutableArray *) getAlreadyPracticeWithType:(NSInteger)type withFMDB:(FMDatabase *)db
{ NSMutableArray *array = [NSMutableArray array];
    // 查询数据
    //@"SELECT * FROM t_question where id=1"
    //@"SELECT * FROM t_question where content='驾驶机动车在道路上违反道路交通安全法的行为，属于什么行为？'"
    NSString *stirng = [NSString stringWithFormat:@"SELECT * FROM t_question where type=%ld and already = %d",type,1];
    FMResultSet *rs = [db executeQuery:stirng];
    
    while ([rs next]) {
        YRQuestionObj *questionObj = [[YRQuestionObj alloc]init];
        questionObj.content = [rs stringForColumn:@"content"];
        questionObj.option = [self arrayWithJsonString:[rs stringForColumn:@"option"]];
        questionObj.analy = [rs stringForColumn:@"analy"];
        questionObj.pics = [rs stringForColumn:@"pics"];
        questionObj.answer = [rs intForColumn:@"answer"];
        questionObj.kind = [rs intForColumn:@"kind"];
        questionObj.type = [rs intForColumn:@"type"];
        questionObj.id = [rs intForColumn:@"id"];
        questionObj.error = [rs intForColumn:@"collect"];
        questionObj.already = [rs intForColumn:@"already"];
        questionObj.error = [rs intForColumn:@"error"];
        [array addObject:questionObj];
    }
    return array;
}
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (![dic[2] length]) {//判断题
        dic = [NSArray arrayWithObjects:dic[0],dic[1], nil];
    }
    if(err) {
        MyLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (void) changeMsgWithId:(NSInteger) msgID withNewMsg:(NSString *)newMsg withFMDB:(FMDatabase *)db
{
    NSString *msgString = [NSString stringWithFormat:@"UPDATE t_question SET %@ WHERE id = %ld;",newMsg,msgID];
    [db executeUpdate:msgString];
}
+(NSArray *)getErrorAlreadyAndTotalQuestionWithType:(NSInteger)type
{
    NSArray *msgArray;
    NSMutableArray *totalarray = [NSMutableArray array];
    totalarray = [self getShunXuPracticeWithType:type withFMDB:[self initFmdb]];
    NSMutableArray *errorArray = [NSMutableArray array];
    errorArray = [self getErrorPracticeWithType:type withFMDB:[self initFmdb]];
    NSMutableArray *alreadyarray = [NSMutableArray array];
    alreadyarray = [self getAlreadyPracticeWithType:type withFMDB:[self initFmdb]];
    msgArray = @[[NSString stringWithFormat:@"%ld",totalarray.count],[NSString stringWithFormat:@"%ld",errorArray.count],[NSString stringWithFormat:@"%ld",alreadyarray.count]];
    return msgArray;
}
+(void)setCollectId:(NSInteger)collectId withType:(NSInteger)type
{
    
}
/**
 *  顺序练习获取最新做题的id
 *
 */
+(NSInteger) getCurrentQuestionIDWithType:(BOOL)type
{
    NSInteger questionID;
    //    获取document目录
    NSArray*larray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*lstring=[larray lastObject];
    
    //    如果把数据存储
    NSString *pStr = [lstring stringByAppendingString:[NSString stringWithFormat:@"/questionID_%d.plist",type]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:pStr];
    if (result) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:pStr];
        questionID = [dic[@"questionID"] integerValue];
    }else{
        questionID = 0;
    }
    return questionID;
}
//创建沙盒存入数据或沙盒路径已有存入数据
+(void)saveMsgWithMsg:(NSInteger)msgString withType:(BOOL)type
{
    NSDictionary *msg = @{@"questionID":[NSString stringWithFormat:@"%ld",msgString]};
    //    获取document目录
    NSArray*larray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString*lstring=[larray lastObject];
    
    //    如果把数据存
    NSString *pStr = [lstring stringByAppendingString:[NSString stringWithFormat:@"/questionID_%d.plist",type]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:pStr];
    if (result) {
        [msg writeToFile:pStr atomically:YES];
    }else{
        //如果不存在就创建
        [[NSFileManager defaultManager]createFileAtPath:pStr contents:nil attributes:nil];
        [msg writeToFile:pStr atomically:YES];
    }
}
@end
