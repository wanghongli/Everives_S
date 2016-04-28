//
//  YRYJLearnToDriveController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/18.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJLearnToDriveController.h"
#import "YRYJFirstClassController.h"
#import "YRYJSecondClassController.h"
#import "YRYJThirdClassController.h"
#import "YRYJFourthClassController.h"
#import "YRQuestionObj.h"
#import "FMDB.h"
#import "YRFMDBObj.h"
#import "YRTeacherMakeCommentController.h"
#import "UIBarButtonItem+Item.h"
#define CZVersionKey @"version"
@interface YRYJLearnToDriveController ()
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;
@end

@implementation YRYJLearnToDriveController
FMDatabase *db;
//重载init方法
- (instancetype)init
{
    if (self = [super initWithTagViewHeight:48])
    {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tagItemSize = CGSizeMake((self.view.frame.size.width-100)/4, 48);
    self.title = @"蚁人学车";
    self.frostedViewController.panGestureEnabled = YES;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu_icon"] highImage:[UIImage imageNamed:@"menu_icon"] target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArray = @[
                            @"科一",
                            @"科二",
                            @"科三",
                            @"科四",
                            ];
    NSArray *classNames = @[
                            [YRYJFirstClassController class],
                            [YRYJSecondClassController class],
                            [YRYJThirdClassController class],
                            [YRYJFourthClassController class]
                            ];
    
    NSArray *params = @[
                        @"XBParamImage",
                        @"TableView",
                        @"CollectionView",
                        @"XBParamImage"
                        ];
    
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:params];
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:CZVersionKey];
    // v1.0
    // 判断当前是否有新的版本
//    WS(ws)
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
    }else{ // 有最新的版本号
        //1.获得数据库文件的路径
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
        
        NSString *fileName = [doc stringByAppendingPathComponent:@"question.sqlite"];
        self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
        db = [YRFMDBObj initFmdb];
        //获取数据并写入
        [self getData];
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:CZVersionKey];
    }
    //查询
//    [self checkMsg];
    //修改数据
//    [self updateMsg];
//    //获取数据并写入
//    [self getData];
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"教练评价" style:UIBarButtonItemStylePlain target:self action:@selector(teacherCommentClick)];
}
-(void)teacherCommentClick
{
    YRTeacherMakeCommentController *commentVC = [[YRTeacherMakeCommentController alloc]init];
    [self.navigationController pushViewController:commentVC animated:YES];
}
-(void)updateMsg
{
    [db executeUpdate:@"UPDATE t_question SET collect = 0 WHERE collect = 1;"];
}
-(void)checkMsg
{
    // 查询数据
    //@"SELECT * FROM t_question where id=1"
    //@"SELECT * FROM t_question where content='驾驶机动车在道路上违反道路交通安全法的行为，属于什么行为？'"
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_question where collect=1"];
    
    // 遍历结果集
    NSInteger numQues = 0;
    while ([rs next]) {
        
//        NSString *name = [rs stringForColumn:@"content"];
        numQues++;
        MyLog(@"%ld",numQues);
    }
}
-(void)getData
{
    //获取题库数据
    [RequestData GETQuestionBank:@"data/index.json" complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        //读取plist
        NSArray *array1 = (NSArray *)responseDic;
        for (int i = 0; i<array1.count; i++) {
            NSString *string = [NSString stringWithFormat:@"data/%@",array1[i]];
            [RequestData GETQuestionBank:string complete:^(NSDictionary *responseDic) {
                NSArray *array = [YRQuestionObj mj_objectArrayWithKeyValuesArray:responseDic];
                MyLog(@"%ld",array.count);
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self.databaseQueue inDatabase:^(FMDatabase *db) {
                        for (int i = 0; i<array.count; i++) {
                            YRQuestionObj *quesObj = array[i];
                            //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
                            [db executeUpdateWithFormat:@"INSERT INTO t_question (analy, content, option, pics, answer, kind, type,id,collect,error,already,chooseAnswer,professionalAlready,randomAlready,totalAlready) VALUES (%@,%@,%@,%@,%ld,%ld,%ld,%ld,%d,%d,%d,%d,%d,%d,%d);",quesObj.analy,quesObj.content,[quesObj.option mj_JSONString],quesObj.pics,quesObj.answer,quesObj.kind,quesObj.type,quesObj.id,0,0,0,0,0,0,0];
                        }
                    }];
                });
            } failed:^(NSError *error) {
                
            }];
        }
    } failed:^(NSError *error) {
        
    }];
    [RequestData GETQuestionBank:@"data/ques_kind.json" complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
        [userDefaults setObject:responseDic forKey:@"ques_kind"];
        [NSUserDefaults resetStandardUserDefaults];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - 滑动手势处理

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x<=0) {
        if ([scrollView.panGestureRecognizer velocityInView:self.view].x>0) {
            [self.frostedViewController panGestureRecognized:scrollView.panGestureRecognizer];
            NSLog(@"did scroll %@",scrollView.panGestureRecognizer);
            scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            return;
        }
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if([scrollView.panGestureRecognizer translationInView:self.view].x<150){
        [self.frostedViewController hideMenuViewController];
    }
    if ([scrollView.panGestureRecognizer translationInView:self.view].x>150) {
        [self.frostedViewController resizeMenuViewControllerToSize:CGSizeMake(kScreenWidth*0.85, kScreenHeight+20)];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
    if (scrollView.contentOffset.x<=0) {
        if ([scrollView.panGestureRecognizer velocityInView:self.view].x>0) {
            [self.frostedViewController panGestureRecognized:scrollView.panGestureRecognizer];
            NSLog(@"will scroll %@",scrollView.panGestureRecognizer);
        }else{
            return;
        }
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.frostedViewController.panGestureEnabled = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.frostedViewController.panGestureEnabled = NO;
}
@end
