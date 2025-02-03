//
//  MainPageTableViewCell.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/3.
//

#import "MainPageTableViewCell.h"

@implementation MainPageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{  //将各个元素添加到Cell中
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.topicLabel];
        [self.contentView addSubview:self.hintLabel];
        [self.contentView addSubview:self.prevImageLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getter //懒加载

- (UILabel *)topicLabel {  //标题懒加载
    if (self == nil) {
        _topicLabel = [[UILabel alloc] init];
        _topicLabel.frame = CGRectMake(45, 65, 810, 115);  //位置和大小
        _topicLabel.layer.masksToBounds = YES;  //超出边界限制
        _topicLabel.textColor = [UIColor blackColor];  //字体颜色黑色
        _topicLabel.font = [UIFont systemFontOfSize:36];  //字号36磅
        _topicLabel.numberOfLines = 2;  //限制行数2
        _topicLabel.textAlignment = NSTextAlignmentLeft;  //左对齐
    }
    return _topicLabel;
}

- (UILabel *)hintLabel {  //提示懒加载
    if (self == nil) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.frame = CGRectMake(45, 205, 800, 40);  //位置和大小
        _hintLabel.layer.masksToBounds = YES;  //超出边界限制
        _hintLabel.textColor = [UIColor lightGrayColor];  //字体颜色亮灰色
        _hintLabel.font = [UIFont systemFontOfSize:26];  //字号26磅
        _hintLabel.numberOfLines = 1;  //限制行数1
        _hintLabel.textAlignment = NSTextAlignmentLeft;  //左对齐
    }
    return _hintLabel;
}

- (UIImageView *)prevImageLabel {
    if (self == nil) {
        _prevImageLabel = [[UIImageView alloc] init];
        _prevImageLabel.frame = CGRectMake(905, 45, 218, 218);  //位置和大小
        _prevImageLabel.layer.masksToBounds = YES;  //超出边界限制
        _prevImageLabel.layer.cornerRadius = 3;  //圆角半径3
    }
    return _prevImageLabel;
}

@end
