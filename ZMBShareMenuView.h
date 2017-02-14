//
//  ZMBSharedView.h
//  ZhongMeBan
//
//  Created by Han Yahui on 16/3/9.
//  Copyright © 2016年 Han Yahui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZMBShareMenuItem.h"


@class ZMBShareMenuView;

@protocol ZMBShareMenuViewDelegate <NSObject>

- (void)sharedView:(ZMBShareMenuView *)sharedView didClickFavoriteItem:(ZMBShareMenuItem *)item;

- (void)sharedView:(ZMBShareMenuView *)sharedView didClickCopyUrlItem:(ZMBShareMenuItem *)item;

- (BOOL)needShowFavoriteItemInSharedView:(ZMBShareMenuView *)sharedView;


@end

@interface ZMBShareMenuView : UIView

- (instancetype)initWithShareTitle:(NSString *)title shareUrl:(NSString *)url;

@property (nonatomic,strong) NSArray *shareItems;

@property (nonatomic,weak) id<ZMBShareMenuViewDelegate> delegate;

@property (nonatomic,copy) void(^didClickMenuItem)(ZMBShareMenuItem *item);
@property (nonatomic,copy) void(^didClickCancelButton)();

@property (nonatomic,copy) NSString *shareTitle;
@property (nonatomic,copy) NSString *shareUrl;

- (void)show;


@end


@interface ZMBShareMenuCollectionCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel     *titleLabel;

@end


