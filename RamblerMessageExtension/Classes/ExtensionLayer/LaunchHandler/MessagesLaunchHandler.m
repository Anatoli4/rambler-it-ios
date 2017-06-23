// Copyright (c) 2015 RAMBLER&Co
//
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

#import "MessagesLaunchHandler.h"

#import "ObjectTransformer.h"
#import "LaunchRouter.h"

#import <CoreSpotlight/CoreSpotlight.h>

@interface MessagesLaunchHandler ()

@property (nonatomic, strong) id<ObjectTransformer> objectTransformer;
@property (nonatomic, strong) id<LaunchRouter> launchRouter;

@end

@implementation MessagesLaunchHandler

#pragma mark - Initialization

- (instancetype)initWithObjectTransformer:(id<ObjectTransformer>)objectTransformer
                             launchRouter:(id<LaunchRouter>)launchRouter {
    self = [super init];
    if (self) {
        _objectTransformer = objectTransformer;
        _launchRouter = launchRouter;
    }
    return self;
}

#pragma mark - <LaunchHandler>

- (BOOL)canHandleLaunchWithActivity:(NSUserActivity *)activity {
    NSString *identifier = [self identifierFromActivity:activity];
    return [self.objectTransformer isCorrectIdentifier:identifier];
}

- (void)handleLaunchWithActivity:(NSUserActivity *)activity {
    NSString *identifier = [self identifierFromActivity:activity];
    id object = [self.objectTransformer objectForIdentifier:identifier];
    [self.launchRouter openScreenWithData:object];
}

#pragma mark - Private methods

- (NSString *)identifierFromActivity:(NSUserActivity *)activity {
    NSDictionary *userInfo = activity.userInfo;
    NSString *activityIdentifier = userInfo[CSSearchableItemActivityIdentifier];
    return activityIdentifier;
}


@end
