//
//  SSOService.h
//  SSOService
//
//  Created by Johan Kool on 3/11/15.
//  Copyright © 2015 Surfnet. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

extern NSString * const _Nonnull SSOServiceErrorDomain;

typedef enum : NSUInteger {
    SSOServiceErrorUnknown = 0,
    SSOServiceErrorAuthenticationCancelled = 1,
    SSOServiceErrorAuthenticationFailed = 2,
} SSOServiceError;

@protocol SSOAuthorizationViewControllerDelegate <NSObject>

- (void)dismissAuthorizationViewController:(UIViewController * _Nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)authorizationViewController:(UIViewController * _Nonnull)viewController didSucceedWithToken:(NSString * _Nonnull)token;
- (void)authorizationViewController:(UIViewController * _Nonnull)viewController didFailWithError:(NSError * _Nonnull)error;

@end

@interface SSOService : NSObject

/// Creates the view controller to present to let the user authorize
+ (UIViewController * _Nonnull)authorizationViewControllerForEndpoint:(NSString * _Nonnull)endpoint consumerId:(NSString * _Nonnull)consumerId state:(NSString * _Nonnull)state delegate:(id <SSOAuthorizationViewControllerDelegate> _Nonnull)delegate;

/// Call this method in your app's delegate application:openURL:options: method
+ (BOOL)handleURL:(NSURL * _Nonnull)url callbackScheme:(NSString * _Nonnull)callbackScheme;

@end

