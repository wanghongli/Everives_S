//
//  Http.h
//  CQSQ
//
//  Created by linan on 15-2-4.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#ifndef CQSQ_Http_h
#define CQSQ_Http_h

#define QINIU_SERVER_URL @"http://7xn7nj.com2.z0.glb.qiniucdn.com/"  //七牛服务器地址

#define SERVER_URL @"http://120.27.55.225/drive.php" // 正式服务器 114.215.86.90

//用户通用模块
#define USER_LOGIN @"/account/token" //登陆
#define USER_REGIST @"/account/account" //注册
#define USER_FIND_PSW @"/account/Password" //找回密码
#define USER_CHECK_TELL @"/account/checkTel" //检查手机号码
#define USER_INFO_BYID @"/student/info/" // 通过id获取用户信息

//学员模块
#define STUDENT_INFO @"/student/info"  //修改个人信息
#define STUDENT_IDENTIFY @"/student/identify" //完善个人认证信息
#define STUDENT_ADDRESS @"/student/Address" //同步地理位置
#define STUDENT_AVATAR @"/student/Avatar" //修改头像
#define STUDENT_BG @"/student/bg" //修改空间背景图片
#define STUDENT_PASSWORD @"/student/Password" //修改密码
#define STUDENT_GET_INFO @"/student/info" //获取本人信息
#define STUDENT_GET_OTHERSINFO @"/student/info/" //获取他人信息
#define STUDENT_BRIEF @"/student/brief/id" //获取简略信息
#define STUDENT_SEARCH_USER @"/student/user/" //搜索学员
#define STUDENT_FRIENDS @"/student/friends" //我的好友
#define STUDENT_DELETE_FRIENDS @"/student/friends/id" //删除好友
#define STUDENT_NEARBY @"/student/nearby" //搜索附近学员
#define STUDENT_PLACES @"/student/place" //场地列表
#define STUDENT_CONTACT @"/student/contact"  //手机通讯录
#define STUDENT_TEACHERS @"/student/teachers"  //关注的教练
#define SYUDENT_NEARBYPOINT @"/student/nearbyPoint" //获取地图描点

//七牛token
#define USER_QINIUTOKEN @"/common/qiniu" //获取七牛token

//微博模块
#define WEIBO_ADD @"/seeds/seeds" //添加微博
#define WEIBO_DELE @"/seeds/seeds/id" //删除微博    method: DELETE
#define WEIBO_GET_LIST @"/seeds/seeds" //获取微博列表
#define WEIBO_DETAIL @"/seeds/seeds/id" //获取微博详情
#define WEIBO_ADD_COMMENT @"/seeds/comment" //添加评论
#define WEIBO_COMMENT_DELE @"/seeds/comment/id" //删除评论
#define WEIBO_PRAISE @"/seeds/praise" //点赞
#define WEIBO_CANCEL_PRAISE @"/seeds/praise" //取消点赞

//驾考问题
#define JK_SX_PRACTICE @"/question/question/id" //顺序练习
#define JK_SJ_PRACTICE @"/question/question/" //随机练习
#define JK_ZJ_PRACTICE @"/question/zhuanti/kid" //专题练习
#define JK_MN_PRACTICE @"/question/test" //模拟考试


#endif
