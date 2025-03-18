//
//  TopView.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/3/18.
//

#import "TopView.h"

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dayLabel];
        [self addSubview:self.monthLabel];
        [self addSubview:self.topicLabel];
        [self addSubview:self.avatarImageView];
    }
    return self;
}

#pragma mark - Lazy

- (UILabel *)monthLabel{
    if(_monthLabel == nil){
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 39, 32, 12)];
        _monthLabel.backgroundColor = [UIColor whiteColor];
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar  currentCalendar];
        unsigned int unitFlags = NSMonthCalendarUnit;
        NSDateComponents *d = [calendar components:unitFlags fromDate:currentDate];
        int monthNum = [d month];
        NSString *monthStr;
        switch (monthNum) {
            case 1:
                monthStr = @"一月";
                break;
            case 2:
                monthStr = @"二月";
                break;
            case 3:
                monthStr = @"三月";
                break;
            case 4:
                monthStr = @"四月";
                break;
            case 5:
                monthStr = @"五月";
                break;
            case 6:
                monthStr = @"六月";
                break;
            case 7:
                monthStr = @"七月";
                break;
            case 8:
                monthStr = @"八月";
                break;
            case 9:
                monthStr = @"九月";
                break;
            case 10:
                monthStr = @"十月";
                break;
            case 11:
                monthStr = @"十一月";
                break;
            case 12:
                monthStr = @"十二月";
                break;
        }
        _monthLabel.text = monthStr;
        _monthLabel.font = [UIFont systemFontOfSize:12 weight:bold];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.textColor = [UIColor blackColor];
    }
    return _monthLabel;
}

- (UILabel *)dayLabel{
    if(_dayLabel == nil){
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 14, 30, 20)];
        _dayLabel.backgroundColor = [UIColor whiteColor];
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar  currentCalendar];
        unsigned int unitFlags = NSDayCalendarUnit;
        NSDateComponents *d = [calendar components:unitFlags fromDate:currentDate];
        NSInteger *dayNum = [d day];
        NSString *dayStr = [[NSNumber numberWithInteger:dayNum] stringValue];
        _dayLabel.text = dayStr;
        _dayLabel.font = [UIFont systemFontOfSize:20];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.textColor = [UIColor blackColor];
    }
    return _dayLabel;
}

- (UILabel *)topicLabel{
    if(_topicLabel == nil){
        _topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 17, 100, 25)];
        _topicLabel.backgroundColor = [UIColor whiteColor];
        _topicLabel.text = @"知乎日报";
        _topicLabel.font = [UIFont systemFontOfSize:25];
        _topicLabel.textAlignment = NSTextAlignmentLeft;
        _topicLabel.textColor = [UIColor blackColor];
    }
    return _topicLabel;
}

- (UIImageView *)avatarImageView{
    if(_avatarImageView == nil){
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(340, 13, 34, 34)];
        _avatarImageView.backgroundColor = [UIColor whiteColor];
        _avatarImageView.image = [UIImage imageNamed:@"DefaultAvatar.jpeg"];
        _avatarImageView.layer.cornerRadius = 17;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}


@end
