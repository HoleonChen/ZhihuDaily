//
//  ExtraDataModel.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/3/2.
//

#import "ExtraDataModel.h"

@implementation ExtraDataModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    self.commentNum = dic[@"comments"];
    self.popularityNum = dic[@"popularity"];
    return self;
}

@end
