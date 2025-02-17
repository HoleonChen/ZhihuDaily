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
        self.backgroundColor = [UIColor whiteColor];
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
    if (_topicLabel == nil) {
        _topicLabel = [[UILabel alloc] init];
        _topicLabel.frame = CGRectMake(15, 20, 270, 40);  //位置和大小
        _topicLabel.layer.masksToBounds = YES;  //超出边界限制
        _topicLabel.textColor = [UIColor blackColor];  //字体颜色黑色
        _topicLabel.font = [UIFont systemFontOfSize:16];  //字号18磅
        _topicLabel.numberOfLines = 2;  //限制行数2
        _topicLabel.textAlignment = NSTextAlignmentLeft;  //左对齐
    }
    return _topicLabel;
}

- (UILabel *)hintLabel {  //提示懒加载
    if (_hintLabel == nil) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.frame = CGRectMake(15, 65, 270, 13);  //位置和大小
        _hintLabel.layer.masksToBounds = YES;  //超出边界限制
        _hintLabel.textColor = [UIColor lightGrayColor];  //字体颜色亮灰色
        _hintLabel.font = [UIFont systemFontOfSize:10];  //字号8磅
        _hintLabel.numberOfLines = 1;  //限制行数1
        _hintLabel.textAlignment = NSTextAlignmentLeft;  //左对齐
    }
    return _hintLabel;
}

- (UIImageView *)prevImageLabel {
    if (_prevImageLabel == nil) {
        _prevImageLabel = [[UIImageView alloc] init];
        _prevImageLabel.frame = CGRectMake(300, 14, 72, 72);  //位置和大小
        _prevImageLabel.layer.masksToBounds = YES;  //超出边界限制
        _prevImageLabel.layer.cornerRadius = 3;  //圆角半径3
    }
    return _prevImageLabel;
}

@end
