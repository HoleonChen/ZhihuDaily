#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "KJBannerHeader.h"
#import "KJBannerView.h"
#import "KJBannerViewCell.h"
#import "KJBannerViewFlowLayout.h"
#import "KJBannerViewTimer.h"
#import "KJPageControl.h"
#import "KJAutoPurgingCache.h"
#import "KJImageCache.h"
#import "KJNetworkManager.h"
#import "KJWebImageDownloader.h"
#import "KJWebImageHeader.h"
#import "UIView+KJWebImage.h"

FOUNDATION_EXPORT double KJBannerViewVersionNumber;
FOUNDATION_EXPORT const unsigned char KJBannerViewVersionString[];

