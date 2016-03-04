//
//  Http.h
//  CQSQ
//
//  Created by linan on 15-2-4.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#ifndef CQSQ_Http_h
#define CQSQ_Http_h

#define PUBLIC_CONFIGS @"public/configs"//app初始化
#define QINIU_SERVER_URL @"http://7xn7nj.com2.z0.glb.qiniucdn.com/"  //七牛服务器地址
//#define SERVER_URL @"http://120.27.55.225/"// 测试服务器120.27.55.225
#define SERVER_URL @"http://114.215.86.90/" // 正式服务器 114.215.86.90
#define USER_QINIUTOKEN @"/common/qiniuToken"//获取七牛token
#define USER_LOGIN @"/user/login/"//用户登录
#define USER_REGISTER @"/user/register" //注册
#define USER_CHECKTEL @"/user/checkTel" //验证手机是否可用
#define USER_RESETPASS @"/user/resetPass"//忘记密码
#define USER_UPDATEADDR @"/user/updateAddr" //位置更新
#define USER_GETNOTIFY @"/user/getNotify" //获取通知
#define USER_MODINFO @"/user/modInfo"  //修改用户资料
#define USER_GETUSERINFO @"/user/getUserinfo"//获取用户信息
#define USER_GETMYINFO @"/user/getmyinfo" //获取本人信息
#define USER_MODPASS @"/user/modPass"//修改密码
#define USER_BINDTEL @"/user/bindTel" //更改绑定手机
#define USER_FEEDBACK @"/common/feedback" //用户反馈
#define USER_REPORTPLACE @"/common/reportPlace" //举报
#define USER_MYATTEND @"/user/myAttend" //我的关注
#define USER_UNATTEND @"/user/unAttend" //取消关注
#define USER_MYFANS @"/user/myFans" //我的粉丝
#define USER_MYPLACE @"/place/myPlace" //我的钓点列表
#define USER_MYCOLLECT @"/place/myCollect" //我的收藏列表
#define USER_MODBG @"/user/modBg" //修改背景
#define USER_GETNEARBY	@"/user/getNearby" //附近的人
#define USER_FINDUSER @"/user/findUser"//  搜索用户
#define UER_CONTACT  	@"/user/contact"  //手机联系人
//钓点
#define PLACE_GETPLACE @"/place/getPlace"//获取钓点列表
#define PLACE_GETITEM @"/place/getItem"//获取钓点详情
#define PLACE_SCORLIST @"/place/scoreList" // 取评分列表
#define PLACE_COLLECT @"/place/collect" //收藏钓点
#define PLACE_UNCOLLECT @"/place/unCollect"  //取消收藏钓点
#define PLACE_SCORDETAIL @"/place/scoreDetail" //取评分详情
#define PLACE_SCORE @"/place/score" //评价钓点
#define PLACE_COMMENT @"/place/comment" //评论对钓点的评价
#define PLACE_ADD @"/place/add" //添加钓点

//消息
#define USER_ATTENT @"/user/attend"//关注
#define WEIBO_ADD @"/weibo/add/"//写微博
#define WEIBO_GETLIST @"/weibo/getList"  //取微博列表_某用户的
#define WEIBO_GETLISTGROUND @"/weibo/getListGround/"//取微博列表_广场
#define WEIBO_GETLISTNEAR @"/weibo/getListNear/"//取微博列表_附近
#define WEIBO_GETLISTFRIEND @"/weibo/getListFriend/"//取微博列表_朋友
#define WEIBO_GETITEM @"weibo/getItem/"//取微博_详情
#define WEIBO_COMMENTLIST @"weibo/getItem" //去微博评论列表
#define WEIBO_COMMENT @"/weibo/comment" //评论
#define WEIBO_PRAISE @"/weibo/praise" //点赞
#define WEIBO_UNPRAISE @"/weibo/unPraise" //取消点赞


#define INDEX_HOTS @"index/hots"//今⽇日热帖
#define INDEX_USERS @"index/users"//社区达⼈

#define INDEX_FORUM @"forum"//版块信息

#define INDEX_READ @"read"//帖子信息
#define READ_ATTS @"read/atts"//大图浏览
#define READ_MARKS @"read/marks"//显示评分
#define READ_DOMARK @"read/domark"//添加评分
#define READ_DOREPORT @"read/doreport"//举报提交
#define READ_DOLIKE @"read/dolike"//点赞操作

#define POST_DOTOPIC @"post/dotopic"//发布帖子
#define POST_FORUM @"post/forum"//发帖选择版块信息
#define POST_DOREPLY @"post/doreply"//回复帖子
#define POST_DOUPLOAD @"post/doupload"//上传图片
#define POST_DOVOICE @"post/dovoice"//上传语音

#define PASSPORT_DOLOGIN @"passport/dologin"//用户登录
#define PASSPORT_DOREG @"passport/doreg"//用户注册
#define PASSPORT_DOPASSWD @"passport/dopasswd"//重置密码
#define PASSPORT_GETSMS @"passport/getsms"//发送验证码
#define PASSPORT_CHECK @"passport/check"//信息检测
#define USER_CLOCKIN @"/user/clockIn" //签到
#define USER_ADDFRIEND @"user/addfriend"//添加好友
#define USER_DELFRIEND @"user/delfriend"//删除好友
#define USER @"user"//用户资料
#define USER_TOPICS @"user/topics"//用户帖子
#define USER_REPLYS @"user/replys"//用户回帖
#define USER_MYSCORELIST @"/place/myScoreList" //取我的评分列表

#define USER_MARKS @"user/marks"//评过分
#define USER_LIKES @"user/likes"//点过赞
#define USER_VISITS @"user/visits"//浏览过

#define USER_DOAVATAR @"user/doavatar"//头像上传
#define USER_SETPROFILE @"user/setProfile"//修改用户资料

#define ORDER_ADDRESS @"order/address"//列出收货信息
#define ORDER_ADDADDRESS @"order/addAddress"//添加收货信息
#define ORDER_DELADDRESS @"order/delAddress"//删除收货信息
#define ORDER_EDITADDRESS @"order/editAddress"//编辑收货信息
#define ORDER_SETDEFAULTADDRESS @"order/setDefault"//设置默认收货信息

#define USER_PUNCH @"user/punch"//每日签到

#define SEARCH_HISTORY @"search/history"//搜索界面
#define SEARCH @"search"//执行搜索

#define USER_FRIENDS @"user/friends"//好友列表
#define MESSAGE @"message"//消息首页加载
#define MESSAGE_DIALOG @"message/dialog"//进入会话界面
#define MESSAGE_RECEIVE @"message/receive"//消息接收回执
#define MESSAGE_DOSEND @"message/dosend"//执行发送消息

#define LBS @"lbs" //位置更新
#define LBS_TOPICS @"lbs/topics" //周边帖子
#define LBS_USERS @"lbs/users" //周边社员
#define LBS_BUSINESS @"lbs/business" //周边商户

#define PUBLIC_DOSCAN @"public/doscan" //扫一扫回调

#define USER_CREDIT @"user/credit"

#endif
