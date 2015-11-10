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

#import "SSOWebViewController.h"

@interface SSOWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) UITextField *hostTextField;

@property (nonatomic, weak) UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) UIBarButtonItem *backBarButton;
@property (nonatomic, weak) UIBarButtonItem *forwardBarButton;
@property (nonatomic, strong) UIBarButtonItem *stopBarButton;
@property (nonatomic, strong) UIBarButtonItem *refreshBarButton;
@property (nonatomic, weak) UIBarButtonItem *titleItem;

@property (nonatomic, copy) NSArray *loadingToolbarItems;
@property (nonatomic, copy) NSArray *notLoadingToolbarItems;

@end

@implementation SSOWebViewController

- (instancetype)initWithURL:(NSURL *)URL {
    self = [super init];
    if (self) {
        self.URL = URL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITextField *hostTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    hostTextField.borderStyle = UITextBorderStyleNone;
    hostTextField.enabled = NO;
    hostTextField.textAlignment = NSTextAlignmentCenter;
    hostTextField.rightViewMode = UITextFieldViewModeAlways;
    hostTextField.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    hostTextField.textColor = [UIColor grayColor];
    self.hostTextField = hostTextField;
    self.navigationItem.titleView = self.hostTextField;

    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = doneBarButton;

    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@"◀︎" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    self.backBarButton = backBarButton;

    UIBarButtonItem *forwardBarButton = [[UIBarButtonItem alloc] initWithTitle:@"▶︎" style:UIBarButtonItemStylePlain target:self action:@selector(goForward:)];
    self.forwardBarButton = forwardBarButton;

    UIBarButtonItem *stopBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stop:)];
    self.stopBarButton = stopBarButton;

    UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.refreshBarButton = refreshBarButton;

    UIBarButtonItem *spacer0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *spacer4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];

    UIUserInterfaceIdiom idiom = [UIDevice currentDevice].userInterfaceIdiom;
    switch (idiom) {
        case UIUserInterfaceIdiomPhone:
            self.loadingToolbarItems = @[spacer0, self.backBarButton, spacer1, self.forwardBarButton, spacer2, spacer3, self.stopBarButton, spacer4];
            self.notLoadingToolbarItems = @[spacer0, self.backBarButton, spacer1, self.forwardBarButton, spacer2, spacer3, self.refreshBarButton, spacer4];
            self.navigationController.toolbarHidden = NO;
            break;
        case UIUserInterfaceIdiomPad:
            self.loadingToolbarItems = @[self.backBarButton, self.forwardBarButton, spacer1, self.stopBarButton];
            self.notLoadingToolbarItems = @[self.backBarButton, self.forwardBarButton, spacer1, self.refreshBarButton];
            break;
        default:
            break;
    }
    [self updateButtons];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.delegate = self;
    [self.view addSubview:webView];

    self.webView = webView;

    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    [self.webView loadRequest:request];
}

- (IBAction)done:(id)sender {
    [self.webView stopLoading];
    [self.delegate webViewControllerDidFinish:self];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)stop:(id)sender {
    [self.webView stopLoading];
}

- (void)updateHostField {
    NSURL *URL = self.webView.request.URL ?: self.URL;
    if (URL != nil) {
        NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:YES];
        self.hostTextField.text = components.host;
    }
}

- (void)updateButtons {
    self.backBarButton.enabled = self.webView.canGoBack;
    self.forwardBarButton.enabled = self.webView.canGoForward;

    UIUserInterfaceIdiom idiom = [UIDevice currentDevice].userInterfaceIdiom;
    switch (idiom) {
        case UIUserInterfaceIdiomPhone:
            [self setToolbarItems:self.webView.isLoading ? self.loadingToolbarItems : self.notLoadingToolbarItems animated:YES];
            break;
        case UIUserInterfaceIdiomPad:
            [self.navigationItem setLeftBarButtonItems:self.webView.isLoading ? self.loadingToolbarItems : self.notLoadingToolbarItems animated:YES];
            break;
        default:
            break;
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self updateHostField];
    [self updateButtons];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateHostField];
    [self updateButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self updateHostField];
    [self updateButtons];
}

@end
