//
//  MainPageTableViewCell.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/3.
//  主页底下的新闻列表的Cell试图

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainPageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *topicLabel;  //标题

@property (nonatomic, strong) UILabel *hintLabel;  //提示

@property (nonatomic, strong) UIImageView *prevImageLabel;  //预览图

@end

NS_ASSUME_NONNULL_END
