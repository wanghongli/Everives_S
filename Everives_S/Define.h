
/**
 *  创建颜色的方法
 */
#define kHexColor(HexString) [UIColor colorForHexString:HexString]
#define kCOLOR(a,b,c) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:1]
#define kFONT_COLOR [UIColor colorWithRed:83.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1]
#define GRAYFONT_COLOR [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1]
#define kBACKGROUND_COLOR [UIColor colorWithRed:21.0/255.0 green:25.0/255.0 blue:34.0/255.0 alpha:1]
//主题色 - 蓝色
//#define kMainColor [UIColor colorWithRed:60/255.0 green:152/255.0 blue:247/255.0 alpha:1]
//红色插色：#fe6270  （254、98、112）
#define kInsertRedColor [UIColor colorWithRed:254/255.0 green:98/255.0 blue:112/255.0 alpha:1]
//橙色插色：#fdaa4c  （253、170、76）
#define kInsertOrangeColor [UIColor colorWithRed:253/255.0 green:170/255.0 blue:76/255.0 alpha:1]
//绿色插色：#62ce49  （98、206、73）
#define kInsertGreenColor [UIColor colorWithRed:98/255.0 green:206/255.0 blue:73/255.0 alpha:1]
////背景：#62ce49  （245、245、245）
#define KGroundColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]
//主色调  55 180 201
#define kMainColor [UIColor colorWithRed:55/255.0 green:180/255.0 blue:201/255.0 alpha:1]

/**
 *  Dock的高度
 */
#define kDockHeight 44
/**
 *  卡片头部高度
 */
#define kCardHead_H 30
/**
 *  卡片底部高度
 */
#define kCardFoot_H 34
/**
 *  状态栏高度
 */
#define kSTATUS_BAR 20

/**
 *  屏幕的尺寸
 */
#define kSizeOfScreen   [[UIScreen mainScreen]bounds].size
#define kScreenWidth kSizeOfScreen.width
#define kScreenHeight kSizeOfScreen.height
/**
 *  字体字号(大中小)
 */
#define kFontOfSize(a)     [UIFont fontWithName:@"Helvetica Neue" size:(a)]
#define kImageFontOfSize(a)     [UIFont fontWithName:@"icomoon" size:(a)]

/**
 *  定义输出宏
 */
#ifdef DEBUG
//#define MyLog(...)
#define MyLog(...) NSLog(__VA_ARGS__)
#else
#define MyLog(...)
#endif

/**
 *  字体字号(大中小)
 */
#define kFontOfLetterSmall      [UIFont fontWithName:@"Helvetica Neue" size:12]
#define kFontOfLetterMedium [UIFont fontWithName:@"Helvetica Neue" size:14]
#define kFontOfLetterBig         [UIFont fontWithName:@"Helvetica Neue" size:16]
/**
 *  调试用背景色
 */
#define kBackgroundColor   [UIColor lightGrayColor]
/**
 *  黑色字体
 */
#define kTextBlackColor    [UIColor blackColor]
/**
 *  浅灰色字体
 */
#define kTextlightGrayColor    [UIColor lightGrayColor]
/**
 *  无色背景
 */
#define kTextClearColor    [UIColor clearColor]
/**
 *  已图片色为背景颜色
 */
#define kColorGreenImg  [UIColor colorWithPatternImage:[UIImage imageNamed:@"repair_green"]]
/**
 *  已图片色为背景颜色
 */
#define kBackgroundImageColor(s, ... )  [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:(s)]]]


/**
 *  用户设置
 */
#define KUserManager [YRManager shareManagerInfo].user
#define KUserLocation [YRManager shareManagerInfo].userLocation
/**
 *  视图圆角半径
 */
#define KRadius 6
#define KLightColor [UIColor colorWithRed:50.0/255.0 green:60.0/255.0 blue:77.0/255.0 alpha:1]
#define KDarkColor [UIColor colorWithRed:50.0/255.0 green:60.0/255.0 blue:77.0/255.0 alpha:1]
/**
 *  沙盒路径
 */
#define kShaHePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]


#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

/**
 *  获取window
 */
#define GET_WINDOW [[UIApplication sharedApplication].delegate window]

/**
 *  距离顶部高度
 */
#define kTO_TOP_DISTANCE 0
//弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kMAMap_key @"18a658a62b6bb09745f2874e6a559bc6"

#define kUMNEG_KEY @"55f2be4667e58e610800112f"

#define kPICTURE_HW (kSizeOfScreen.width-80)/3

/**
 *  占位图
 */
#define kPLACEHHOLD_IMG @"timeline_image_placeholder"

#define KUSER_HEAD_IMG @"Login_addAvatar"
