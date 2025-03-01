//
//  NewsPageViewController.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/28.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsPageViewController : UIViewController

@property (nonatomic, strong) NSURL *newsUrl;

@property (nonatomic, assign) NSInteger *newsId;

@end

NS_ASSUME_NONNULL_END
