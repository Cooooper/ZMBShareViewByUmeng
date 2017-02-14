//
//  ZMBShareMenuItem.m
//  ZhongMeBan
//
//  Created by Han Yahui on 2016/10/13.
//  Copyright © 2016年 ideabinder. All rights reserved.
//

#import "ZMBShareMenuItem.h"

@interface ZMBShareMenuItem ()


@end

@implementation ZMBShareMenuItem

- (instancetype)init
{
  self = [super init];
  if (self) {
    
    
    
  }
  return self;
}




+ (instancetype)initWithSharePlatformType:(ZMBSharePlatformType)type
{
  ZMBShareMenuItem *item = [[ZMBShareMenuItem alloc] init];
  item.type = type;
  
  switch (type) {
    case ZMBSharePlatformTypeZMBFavorite:
    {
      item.title = @"收藏";
      item.image = [UIImage imageNamed:@"hw_favorite_selected"];
    }
      break;
    case ZMBSharePlatformTypeSina:
    {
      item.title = @"新浪微博";
      item.image = [UIImage imageNamed:@"weibo"];
    }
      break;
    case ZMBSharePlatformTypeWechatSession:
    {
      item.title = @"微信好友";
      item.image = [UIImage imageNamed:@"wx_friend"];
    }
      break;
    case ZMBSharePlatformTypeWechatTimeLine:
    {
      item.title = @"朋友圈";
      item.image = [UIImage imageNamed:@"wx_timeline"];
    }
      break;
    case ZMBSharePlatformTypeWechatFavorite:
    {
      item.title = @"微信收藏";
      item.image = [UIImage imageNamed:@"wx_favorite"];
    }
      break;
    case ZMBSharePlatformTypeQQ:
    {
      item.title = @"QQ好友";
      item.image = [UIImage imageNamed:@"qq_friend"];
    }
      break;
    case ZMBSharePlatformTypeQzone:
    {
      item.title = @"QQ空间";
      item.image = [UIImage imageNamed:@"qq_zone"];
    }
      break;
    case ZMBSharePlatformTypeCopyUrl:
    {
      item.title = @"复制链接";
      item.image = [UIImage imageNamed:@"copy_link"];
    }
      break;
      
    default:
      break;
  }
  return item;
  
}


@end

