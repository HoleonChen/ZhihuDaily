//
//  MainPageModel.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/4.
//

#import "MainPageNewsItemModel.h"

@implementation MainPageNewsItemModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self.newsId = dic[@"id"];
    self.newsTitle = dic[@"title"];
    self.newsUrl = dic[@"url"];
    self.thumbnailUrl = dic[@"images"];
    self.hint = dic[@"hint"];
    return self;
}

@end
