//
//  MenuPageViewController.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuPageViewController : UIViewController

@property (nonatomic, strong)UIImageView *userAvatar;
@property (nonatomic, strong)UILabel *userName;
@property (nonatomic, strong)UITableView *menuTable;
@property (nonatomic, strong)UILabel *copyright;

@end

NS_ASSUME_NONNULL_END
