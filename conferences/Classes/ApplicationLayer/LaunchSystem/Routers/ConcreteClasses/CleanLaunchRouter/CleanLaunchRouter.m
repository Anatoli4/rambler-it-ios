// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CleanLaunchRouter.h"

#import "TabBarControllerFactory.h"

#import <UIKit/UIKit.h>

@interface CleanLaunchRouter ()

@property (nonatomic, strong) id<TabBarControllerFactory> tabBarControllerFactory;
@property (nonatomic, strong) UIWindow *window;

@end

@implementation CleanLaunchRouter

#pragma mark - Initialization

- (instancetype)initWithTabBarControllerFactory:(id<TabBarControllerFactory>)tabBarControllerFactory
                                         window:(UIWindow *)window {
    self = [super init];
    if (self) {
        _tabBarControllerFactory = tabBarControllerFactory;
        _window = window;
    }
    return self;
}

#pragma mark - Public methods

- (void)openInitialScreen {
    UITabBarController *tabBarController = [self.tabBarControllerFactory obtainPreconfiguredTabBarController];
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
}

@end
