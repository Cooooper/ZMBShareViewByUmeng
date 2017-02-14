//
//  ZMBSharedView.m
//  ZhongMeBan
//
//  Created by Han Yahui on 16/3/9.
//  Copyright © 2016年 Han Yahui. All rights reserved.
//

#import "ZMBShareMenuView.h"

#import "AppDelegate.h"
#import "ZMBShareManger.h"

#import <SVProgressHUD.h>


#define kBGColor  kRGBAColor(160, 160, 160, 0)

@interface ZMBShareMenuView ()
<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ZMBShareMenuView


- (instancetype)initWithShareTitle:(NSString *)title shareUrl:(NSString *)url
{
  self = [super init];
  if (self) {
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = kBGColor;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(hidden)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    
    self.shareTitle = title;
    self.shareUrl = url;

    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 260)];
    self.backgroundView.backgroundColor = kBackgroundColor;
    [self addSubview:self.backgroundView];
    
    self.cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:kTextColor forState:UIControlStateHighlighted];

    [self.cancelButton setBackgroundColor:kWhiteColor];
    [self.cancelButton addTarget:self action:@selector(hidden)];
    [self.backgroundView addSubview:self.cancelButton];
    
    [self.cancelButton addBorderWithColor:kSeparatorColor width:0.5];
    
    
    [self.cancelButton makeConstraints:^(MASConstraintMaker *make) {
      
      make.left.right.bottom.equalTo(self.backgroundView);
      make.height.equalTo(50);
    }];
    
    [self setupCollectionView];
  }
  
  return self;
}


- (void)setupCollectionView
{
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.minimumInteritemSpacing = 20;
  flowLayout.minimumLineSpacing      = 20;
  flowLayout.itemSize     = CGSizeMake(50 , 75);
  flowLayout.sectionInset = UIEdgeInsetsMake(20, 25, 20, 25);//上左下右的布局
  
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                       collectionViewLayout:flowLayout];
  _collectionView.backgroundColor = kSeparatorColor;
  _collectionView.scrollEnabled = YES;
  _collectionView.delegate = self;
  _collectionView.dataSource = self;
  [self.backgroundView addSubview:_collectionView];
  
  [_collectionView registerClass:[ZMBShareMenuCollectionCell class]
      forCellWithReuseIdentifier:@"ZMBShareMenuCollectionCell"];
  
  [_collectionView makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.right.top.equalTo(self.backgroundView);
    make.bottom.equalTo(self.cancelButton.top);
    
  }];
  
  
}

-(void)setDelegate:(id<ZMBShareMenuViewDelegate>)delegate
{
  _delegate = delegate;

  [self reloadData];
  [self.collectionView reloadData];
}


- (void)reloadData
{
  ZMBShareMenuItem *item0 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeWechatSession];
  ZMBShareMenuItem *item1 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeWechatTimeLine];
  ZMBShareMenuItem *item2 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeWechatFavorite];
  ZMBShareMenuItem *item3 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeSina];
  ZMBShareMenuItem *item4 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeQQ];
  ZMBShareMenuItem *item5 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeQzone];
  ZMBShareMenuItem *item6 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeCopyUrl];
  
  BOOL needFavoriteItem = YES;
  
  if ([self.delegate respondsToSelector:@selector(needShowFavoriteItemInSharedView:)]) {
    needFavoriteItem = [self.delegate needShowFavoriteItemInSharedView:self];
  }
  
  if (needFavoriteItem) {
    ZMBShareMenuItem *item7 = [ZMBShareMenuItem initWithSharePlatformType:ZMBSharePlatformTypeZMBFavorite];
    self.shareItems = @[item0,item1,item2,item3,item4,item5,item6,item7];
  }
  else {
    self.shareItems = @[item0,item1,item2,item3,item4,item5,item6];

  }
  
}

#pragma mark -
#pragma makr - CollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.shareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
  ZMBShareMenuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMBShareMenuCollectionCell"
                                                                          forIndexPath:indexPath];
  
  
  ZMBShareMenuItem *item = self.shareItems[indexPath.row];
  
  cell.accessibilityLabel =  item.title;
  cell.titleLabel.text = item.title;
  cell.imageView.image = item.image;
  
  return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  [self hidden];

  ZMBShareMenuItem *item = self.shareItems[indexPath.item];
  
  [self clickItem:item];


}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
  if([touch.view isKindOfClass:[self class]]){
    return YES;
  }
  return NO;
}

- (void)hidden
{
  UINavigationController *nav = [AppDelegate shareInstance].selectedNavigationController;
  nav.interactivePopGestureRecognizer.enabled = YES;
  
  [UIView animateWithDuration:0.3 animations:^{
    self.backgroundView.y = kScreenHeight;
    self.alpha = 0;
  } completion:^(BOOL finished) {
    if (finished) {
      [self removeFromSuperview];
    }
  }];
  
  if (self.didClickCancelButton) {
    self.didClickCancelButton();
  }
  
}

- (void)show
{
  UINavigationController *nav = [AppDelegate shareInstance].selectedNavigationController;
  [nav.view addSubview:self];
  nav.interactivePopGestureRecognizer.enabled = NO;
  
  
  [UIView animateWithDuration:0.3 animations:^{
    self.backgroundColor = [kBlackColor colorWithAlphaComponent:0.15];
    self.backgroundView.y = kScreenHeight - self.backgroundView.frame.size.height;
  }];
}

- (void)tapOnItem:(UITapGestureRecognizer *)tapGestureRecognizer
{
  [self hidden];

  ZMBShareMenuItem *item = (ZMBShareMenuItem *)tapGestureRecognizer.view;
  
  [self clickItem:item];

}

- (void)clickItem:(ZMBShareMenuItem *)item
{
  UMSocialPlatformType umType = UMSocialPlatformType_UnKnown;
  
  switch (item.type) {

    case ZMBSharePlatformTypeSina:
      umType = UMSocialPlatformType_Sina;
      break;
    case ZMBSharePlatformTypeWechatSession:
      umType = UMSocialPlatformType_WechatSession;
      break;
    case ZMBSharePlatformTypeWechatTimeLine:
      umType = UMSocialPlatformType_WechatTimeLine;
      break;
    case ZMBSharePlatformTypeWechatFavorite:
      umType = UMSocialPlatformType_WechatFavorite;
      break;
    case ZMBSharePlatformTypeQQ:
      umType = UMSocialPlatformType_QQ;
      break;
    case ZMBSharePlatformTypeQzone:
      umType = UMSocialPlatformType_Qzone;
      break;
    case ZMBSharePlatformTypeCopyUrl:
    {
      if ([self.delegate respondsToSelector:@selector(sharedView:didClickCopyUrlItem:)]) {
        [self.delegate sharedView:self didClickCopyUrlItem:item];
      }
      return;
    }
      break;
    case ZMBSharePlatformTypeZMBFavorite:
    {
      if ([self.delegate respondsToSelector:@selector(sharedView:didClickFavoriteItem:)]) {
        [self.delegate sharedView:self didClickFavoriteItem:item];
      }
      return;
    }
      break;
      
    default:
      break;
  }
  
  NSString *title = self.shareTitle;
  NSString *url = self.shareUrl;
  NSString *text = @"专注服务于肿瘤患者的App";
  UIImage *image = [UIImage imageNamed:@"my_logo"];
  
  ZMBShareManger *shareManger = [ZMBShareManger defaultManager];
  
  UMSocialMessageObject *messageObject = [shareManger createMessageObject:ZMBShareMessageTypeWeb
                                                                    title:title
                                                                  context:url
                                                                    descr:text
                                                                thumImage:image];
  
  [shareManger shareDataToPlatform:umType messageObject:messageObject completion:^(BOOL success, NSString *message) {
    
    [self showWithStatus:message success:success];
  }];
  
  
  if (self.didClickMenuItem) {
    self.didClickMenuItem(item);
  }
  
}

- (void)showWithStatus:(NSString *)status success:(BOOL)success
{
  [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
  [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.9f alpha:0.9f]];
  [SVProgressHUD setMinimumDismissTimeInterval:2];
  
  if (success) {
    [SVProgressHUD showSuccessWithStatus:status];
  }
  else {
    [SVProgressHUD showErrorWithStatus:status];
  }
  
}


@end


@implementation ZMBShareMenuCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = kTextColor;
    self.titleLabel.font = kFont(12);
    [self addSubview:self.titleLabel];
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self);
      make.top.equalTo(self);
      make.size.equalTo(CGSizeMake(50, 50));
      
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.imageView);
      make.top.equalTo(self.imageView.bottom).offset(kPaddingVertical/2);
      make.width.equalTo(self);
      make.height.equalTo(20);
    }];
    
  }
  return self;
}

@end



