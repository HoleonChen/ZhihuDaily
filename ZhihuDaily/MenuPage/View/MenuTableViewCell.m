//
//  MenuTableViewCell.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/27.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.topicLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Lazy

- (UILabel *)topicLabel{
    if(_topicLabel == nil){
        _topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 70, 20)];
        _topicLabel.backgroundColor = [UIColor whiteColor];
        _topicLabel.textAlignment = NSTextAlignmentCenter;
        _topicLabel.textColor = [UIColor blackColor];
        _topicLabel.layer.masksToBounds = YES;
        _topicLabel.numberOfLines = 1;
        _topicLabel.font = [UIFont systemFontOfSize:14];
    }
    return _topicLabel;
}

- (UIImageView *)arrowImage{
    if(_arrowImage == nil){
        _arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(357, 20, 20, 20)];
        _arrowImage.backgroundColor = [UIColor blackColor];
        _arrowImage.layer.masksToBounds = YES;
        
    }
}

@end
