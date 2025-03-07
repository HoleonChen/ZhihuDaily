//
//  MainPageCollectionViewCell.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/19.
//

#import "MainPageBannerViewCell.h"

@implementation MainPageBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.prevImageLabel];
        [self.contentView addSubview:self.topicLabel];
        [self.contentView addSubview:self.hintLabel];
    }
    return self;
}

#pragma mark - Lazy

- (UILabel *)topicLabel {  //标题懒加载
    if (_topicLabel == nil) {
        _topicLabel = [[UILabel alloc] init];
        _topicLabel.frame = CGRectMake(20, 265, 350, 80);  //位置和大小
        _topicLabel.layer.masksToBounds = YES;  //超出边界限制
        _topicLabel.textColor = [UIColor whiteColor];  //字体颜色黑色
        _topicLabel.font = [UIFont systemFontOfSize:22 weight:bold];  //字号18磅
        _topicLabel.numberOfLines = 0;  //不限制行数
        _topicLabel.textAlignment = NSTextAlignmentLeft;  //左对齐
    }
    return _topicLabel;
}

- (UILabel *)hintLabel {  //提示懒加载
    if (_hintLabel == nil) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.frame = CGRectMake(20, 351, 350, 13);  //位置和大小
        _hintLabel.layer.masksToBounds = YES;  //超出边界限制
        _hintLabel.textColor = [UIColor lightGrayColor];  //字体颜色亮灰色
        _hintLabel.font = [UIFont systemFontOfSize:12];  //字号12磅
        _hintLabel.numberOfLines = 1;  //限制行数1
        _hintLabel.textAlignment = NSTextAlignmentLeft;  //左对齐
    }
    return _hintLabel;
}

- (UIImageView *)prevImageLabel {
    if (_prevImageLabel == nil) {
        _prevImageLabel = [[UIImageView alloc] init];
        _prevImageLabel.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 390);  //位置和大小
        _prevImageLabel.layer.masksToBounds = YES;  //超出边界限制
        _prevImageLabel.layer.cornerRadius = 3;  //圆角半径3
    }
    return _prevImageLabel;
}

@end
