//
//  AppDelegate.m
//  SSOServiceDemo
//
//  Created by Johan Kool on 4/11/15.
//  Copyright © 2015 Surfnet. All rights reserved.
//

#import "AppDelegate.h"

#import "SSOService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    BOOL urlHandled = [SSOService handleURL:url callbackScheme:@"sfoauth"];
    if (!urlHandled) {
        // Handle any other URLs
    }
    return urlHandled;
}

@end
