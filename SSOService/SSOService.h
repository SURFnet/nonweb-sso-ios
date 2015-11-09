/*
 * Copyright 2015 SURFnet BV, The Netherlands
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

extern NSString * const _Nonnull SSOServiceErrorDomain;

typedef enum : NSUInteger {
    SSOServiceErrorUnknown = 0,
    SSOServiceErrorAuthorizationCancelled = 1,
    SSOServiceErrorAuthorizationFailed = 2,
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

