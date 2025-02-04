//
//  MainPageModel.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainPageNewsItemModel : NSObject

@property (nonatomic, assign) NSInteger newsId;

@property (nonatomic, strong) NSString *newsTitle;

@property (nonatomic, strong) NSString *newsUrl;

@property (nonatomic, strong) NSString *thumbnailUrl;

@property (nonatomic, strong) NSString *hint;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
