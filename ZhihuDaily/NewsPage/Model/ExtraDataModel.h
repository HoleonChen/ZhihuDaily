//
//  ExtraDataModel.h
//  ZhihuDaily
//
//  Created by Holeon on 2025/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtraDataModel : NSObject

@property (nonatomic, assign) NSInteger commentNum;

@property (nonatomic, assign) NSInteger popularityNum;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
