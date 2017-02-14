//
//  ZMBShareManger.h
//  ZhongMeBan
//
//  Created by Han Yahui on 2016/10/13.
//  Copyright © 2016年 ideabinder. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UMSocialCore/UMSocialCore.h>


typedef NS_ENUM(NSInteger,ZMBShareMessageType) {
  
  ZMBShareMessageTypeText  = 1,
  ZMBShareMessageTypeImage = 2,
  ZMBShareMessageTypeWeb   = 3,
  ZMBShareMessageTypeVideo = 4,
  ZMBShareMessageTypeMusic = 5,
  
};


@interface ZMBShareManger : NSObject

+ (ZMBShareManger *)defaultManager;

- (void)shareDataToPlatform:(UMSocialPlatformType)platformType
              messageObject:(UMSocialMessageObject *)messageObject
                 completion:(void(^)(BOOL success,NSString *message))completion;

/**
 * type 分享信息的类型
 * title 分享信息的标题 defualt is '易治'
 * context 分享信息的上下文
 type = text,context is text,
 type = web,context is webUrl,
 type = image,context is imageUrl,
 type = video,context is videoUrl,
 type = music,context is musicUrl,

 * descr 分享信息的描述 defualt is '遇见你，让一切变得更美好'
 * image 分享信息的缩略图  defualt is 'my_logo'
 **/
- (UMSocialMessageObject *)createMessageObject:(ZMBShareMessageType)type
                                         title:(NSString *)title
                                       context:(NSString *)context
                                         descr:(NSString *)descr
                                     thumImage:(UIImage *)image;

@end
