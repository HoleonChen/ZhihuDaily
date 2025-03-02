//
//  StarPageTableViewCell.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/3/1.
//

#import "StarPageTableViewCell.h"

@implementation StarPageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topicLabel];
        [self.contentView addSubview:self.prevImageLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Lazy

- (UILabel *)topicLabel {  //标题懒加载
    if (_topicLabel == nil) {
        _topicLabel = [[UILabel alloc] init];
        _topicLabel.frame = CGRectMake(15, 14, 270, 40);  //位置和大小
        _topicLabel.layer.masksToBounds = YES;  //超出边界限制
        _topicLabel.textColor = [UIColor blackColor];  //字体颜色黑色
        _topicLabel.font = [UIFont systemFontOfSize:16];  //字号16磅
        _topicLabel.numberOfLines = 2;  //限制行数2
        _topicLabel.textAlignment = NSTextAlignmentLeft;  //左对齐
    }
    return _topicLabel;
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
