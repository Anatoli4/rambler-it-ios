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

#import "EventGalleryRouter.h"

#import "EventModuleInput.h"

#import <ViperMcFlurry/ViperMcFlurry.h>

static NSString *const kAnnouncementGalleryModuleToEventModuleSegue = @"EventGalleryModuleToEventModuleSegue";
static NSString *const kAnnouncementGalleryModuleToEventListModuleSegue = @"kAnnouncementGalleryModuleToEventListModuleSegue";

@implementation EventGalleryRouter

#pragma mark - <EventGalleryRouterInput>

- (void)openEventModuleWithEventId:(NSString *)eventId {
    [[self.transitionHandler openModuleUsingSegue:kAnnouncementGalleryModuleToEventModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<EventModuleInput> moduleInput) {
        [moduleInput configureCurrentModuleWithEventObjectId:eventId];
        return nil;
    }];
}

- (void)openEventListModule {
    [[self.transitionHandler openModuleUsingSegue:kAnnouncementGalleryModuleToEventListModuleSegue] thenChainUsingBlock:^id<RamblerViperModuleOutput>(id<EventModuleInput> moduleInput) {
        
        return nil;
    }];
}

@end
