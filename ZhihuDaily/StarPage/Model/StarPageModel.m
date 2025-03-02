//
//  StarPageModel.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/3/1.
//

#import "StarPageModel.h"

@implementation StarPageModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self.newsId = dic[@"id"];
    self.newsTitle = dic[@"title"];
    self.thumbnailUrl = dic[@"images"];
    return self;
}

@end
