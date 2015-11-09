# nonweb-sso-ios

Readme 

This library lets your user connect using Surfnet Conext.

# iOS

## Include library

If you are using CocoaPods, add the following line to your Podfile:

    pod 'SSOService'

alternatively, add the code from the SSOService folder into your project directly.

## Register URL scheme

In the Info.plist of your app, add an entry in CFBundleURLTypes with the value for CFBundleURLSchemes set to the one registered with Surfnet.

## Showing authorization screen

When you want to let the user login, create an authorization view controller and display it. You should also implement a few delegate callback methods.

    - (IBAction)authorize:(id)sender {
        UIViewController *authorizationViewController = [SSOService authorizationViewControllerForEndpoint:@"https://nonweb.demo.surfconext.nl/php-oauth-as/authorize.php" consumerId:@"4dca00da67c692296690e90c50c96b79" state:@"demo" delegate:self];
        [self presentViewController:authorizationViewController animated:YES completion:nil];
    }

    #pragma mark - SSOAuthorizationViewControllerDelegate

    - (void)dismissAuthorizationViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion {
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
