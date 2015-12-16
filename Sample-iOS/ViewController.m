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

#import "ViewController.h"

#import "SSOService.h"

@interface ViewController () <SSOAuthorizationViewControllerDelegate>

@end

@implementation ViewController

- (IBAction)authorize:(id)sender {
    UIViewController *authorizationViewController = [SSOService authorizationViewControllerForEndpoint:@"https://nonweb.demo.surfconext.nl/php-oauth-as/authorize.php" consumerId:@"4dca00da67c692296690e90c50c96b79" state:@"demo" delegate:self];
    [self presentViewController:authorizationViewController animated:YES completion:nil];
}

#pragma mark - SSOAuthorizationViewControllerDelegate

- (void)dismissAuthorizationViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion {
    [self dismissViewControllerAnimated:animated completion:completion];
}

- (void)authorizationViewController:(UIViewController *)viewController didSucceedWithToken:(NSString *)token {
    UIAlertController *successAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Authorization succeeded", @"") message:[NSString stringWithFormat:NSLocalizedString(@"Access token: %@", @""), token] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:nil];
    [successAlert addAction:okAction];
    [self presentViewController:successAlert animated:YES completion:nil];
}

- (void)authorizationViewController:(UIViewController *)viewController didFailWithError:(NSError *)error {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Authorization error", @"") message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"") style:UIAlertActionStyleDefault handler:nil];
    [errorAlert addAction:okAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

@end
