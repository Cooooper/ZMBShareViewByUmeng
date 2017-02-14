//
//  ZMBShareMenuItem.h
//  ZhongMeBan
//
//  Created by Han Yahui on 2016/10/13.
//  Copyright © 2016年 ideabinder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZMBSharePlatformType)
{
  ZMBSharePlatformTypeUnKnown            = -1,
  ZMBSharePlatformTypeZMBFavorite,  // 应用内收藏
  ZMBSharePlatformTypeSina,          //新浪
  ZMBSharePlatformTypeWechatSession, //微信好友
  ZMBSharePlatformTypeWechatTimeLine,//微信朋友圈
  ZMBSharePlatformTypeWechatFavorite,//微信收藏
  ZMBSharePlatformTypeQQ,            //QQ聊天页面
  ZMBSharePlatformTypeQzone,         //QQ空间
  ZMBSharePlatformTypeCopyUrl,       //复制链接

};


@interface ZMBShareMenuItem : NSObject

@property (nonatomic,copy)   NSString *title;
@property (nonatomic,strong) UIColor  *titleColor;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,assign) ZMBSharePlatformType type;

+ (instancetype)initWithSharePlatformType:(ZMBSharePlatformType)type;

@end
