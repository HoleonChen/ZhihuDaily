//
//  MainPageCollectionViewModel.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/19.
//

#import "MainPageBannerViewModel.h"

@implementation MainPageBannerViewModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self.newsId = dic[@"id"];
    self.newsTitle = dic[@"title"];
    self.newsUrl = dic[@"url"];
    self.thumbnailUrl = dic[@"images"];
    self.hint = dic[@"hint"];
    return self;
}

@end
