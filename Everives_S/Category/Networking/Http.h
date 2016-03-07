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

#endif
