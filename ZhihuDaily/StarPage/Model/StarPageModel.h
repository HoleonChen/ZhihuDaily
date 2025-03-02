//
//  StarPageModel.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StarPageModel : NSObject

@property (nonatomic, assign) NSInteger newsId;

@property (nonatomic, strong) NSString *newsTitle;

@property (nonatomic, strong) NSString *thumbnailUrl;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
