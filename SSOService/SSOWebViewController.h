//
//  SSOWebViewController.h
//  SSOService
//
//  Created by Johan Kool on 5/11/15.
//  Copyright © 2015 Surfnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSOWebViewController;

@protocol SSOWebViewControllerDelegate <NSObject>

- (void)webViewControllerDidFinish:(SSOWebViewController *)controller;

@end

@interface SSOWebViewController : UIViewController

- (instancetype)initWithURL:(NSURL *)URL;

@property (nonatomic, weak) id <SSOWebViewControllerDelegate> delegate;

@end
