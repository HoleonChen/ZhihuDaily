//
//  MainPageCollectionViewModel.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainPageCollectionViewModel : NSObject

@property (nonatomic, assign) NSInteger newsId;

@property (nonatomic, strong) NSString *newsTitle;

@property (nonatomic, strong) NSString *newsUrl;

@property (nonatomic, strong) NSArray *thumbnailUrl;

@property (nonatomic, strong) NSString *hint;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
