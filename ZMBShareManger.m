//
//  ZMBShareManger.m
//  ZhongMeBan
//
//  Created by Han Yahui on 2016/10/13.
//  Copyright © 2016年 ideabinder. All rights reserved.
//

#import "ZMBShareManger.h"

@interface ZMBShareManger ()

@end

@implementation ZMBShareManger


+ (ZMBShareManger *)defaultManager
{
  static ZMBShareManger *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    if (!instance) {
      instance = [[self alloc] init];
    }
  });
  return instance;
}


/**
 
 //平台的失败错误码
 //U-Share返回错误类型
 
 typedef NS_ENUM(NSInteger, UMSocialPlatformErrorType) {
 UMSocialPlatformErrorType_Unknow            = 2000,            // 未知错误
 UMSocialPlatformErrorType_NotSupport        = 2001,            // 不支持（url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持）
 UMSocialPlatformErrorType_AuthorizeFailed   = 2002,            // 授权失败
 UMSocialPlatformErrorType_ShareFailed       = 2003,            // 分享失败
 UMSocialPlatformErrorType_RequestForUserProfileFailed = 2004,  // 请求用户信息失败
 UMSocialPlatformErrorType_ShareDataNil      = 2005,             // 分享内容为空
 UMSocialPlatformErrorType_ShareDataTypeIllegal = 2006,          // 分享内容不支持
 UMSocialPlatformErrorType_CheckUrlSchemaFail = 2007,            // schemaurl fail
 UMSocialPlatformErrorType_NotInstall        = 2008,             // 应用未安装
 UMSocialPlatformErrorType_Cancel            = 2009,             // 取消操作
 UMSocialPlatformErrorType_NotNetWork        = 2010,             // 网络异常
 UMSocialPlatformErrorType_SourceError       = 2011,             // 第三方错误
 
 UMSocialPlatformErrorType_ProtocolNotOverride = 2013,   // 对应的    UMSocialPlatformProvider的方法没有实现
 };
 
 */


- (void)shareDataToPlatform:(UMSocialPlatformType)platformType
              messageObject:(UMSocialMessageObject *)messageObject
                 completion:(void(^)(BOOL success,NSString *message))completion
{
  [[UMSocialManager defaultManager] shareToPlatform:platformType
                                      messageObject:messageObject
                              currentViewController:self completion:^(id data, NSError *error) {
                                
                                NSString *message = nil;
                                if (!error) {
                                  message = [NSString stringWithFormat:@"分享成功"];
                                }
                                else{
                                  if (error) {
                                    
                                    if (error.code == UMSocialPlatformErrorType_NotInstall) {
                                      message = @"应用未安装";
                                    }
                                    else if (error.code == UMSocialPlatformErrorType_Cancel) {
                                      message = @"操作已取消";

                                    }
                                    else if (error.code == UMSocialPlatformErrorType_ShareFailed) {
                                      message = @"分享失败";
                                      
                                    }
                                    else if (error.code == UMSocialPlatformErrorType_NotNetWork) {
                                      message = @"网络异常";

                                    }
                                    else {
                                      message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                                    }
                                  }
                                  else{
                                    message = [NSString stringWithFormat:@"分享失败"];
                                  }
                                }
                                completion(!error,message);
    
  }];

}

- (UMSocialMessageObject *)createMessageObject:(ZMBShareMessageType)type
                                         title:(NSString *)title
                                       context:(NSString *)context
                                         descr:(NSString *)descr
                                     thumImage:(UIImage *)image
{
  UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
  
  if (!title || title.length == 0) {
    title = @"易治分享";
  }
  if (!descr || descr.length == 0) {
    descr = @"专注服务于肿瘤患者的App";
  }
  if (!image) {
    image = [UIImage imageNamed:@"my_logo"];
  }
  
  
  switch (type) {
    case ZMBShareMessageTypeText:
    {
      messageObject.text = context;
    }
      break;
    case ZMBShareMessageTypeImage:
    {
      UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:descr thumImage:image];
      [shareObject setShareImage:context];
      messageObject.shareObject = shareObject;
    }
      break;
    case ZMBShareMessageTypeWeb:
    {
      UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:image];

      [shareObject setWebpageUrl:context];
      messageObject.shareObject = shareObject;
    }
      break;
    case ZMBShareMessageTypeVideo:
    {
      UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:descr thumImage:image];
      [shareObject setVideoUrl:context];
      messageObject.shareObject = shareObject;
    }
      break;
    case ZMBShareMessageTypeMusic:
    {
      UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:descr thumImage:image];
      shareObject.musicUrl = context;
      messageObject.shareObject = shareObject;
      
    }
      break;
      
    default:
      break;
  }
  
  return messageObject;
}

@end
