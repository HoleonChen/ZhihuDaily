//
//  MainPageCollectionViewCell.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/19.
//

#import <KJBannerView/KJBannerView.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainPageBannerViewCell : KJBannerViewCell

@property (nonatomic, strong) UILabel *topicLabel;  //标题

@property (nonatomic, strong) UILabel *hintLabel;  //提示词

@end

NS_ASSUME_NONNULL_END
