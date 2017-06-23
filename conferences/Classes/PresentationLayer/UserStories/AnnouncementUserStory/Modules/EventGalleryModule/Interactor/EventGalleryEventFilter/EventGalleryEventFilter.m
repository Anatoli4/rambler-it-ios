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

#import "EventGalleryEventFilter.h"

#import "EventPlainObject.h"
#import "EventGalleryEventFilterConstants.h"

@implementation EventGalleryEventFilter

#pragma mark - Public methods

- (NSArray *)filterFutureEventsFromEvents:(NSArray<EventPlainObject *> *)events {
    NSDate *currentDate = [NSDate date];
    NSArray *sortedEvents = [self sortFutureEventsByDate:events];
    NSMutableArray *resultEvents = [NSMutableArray new];
    
    for (EventPlainObject *event in sortedEvents) {
        if ([event.endDate compare:currentDate] == NSOrderedDescending) {
            [resultEvents addObject:event];
        }
    }
    
    if (resultEvents.count < kEventGalleryMinimumEventCount) {
        NSUInteger additionalEventCount = kEventGalleryMinimumEventCount - resultEvents.count;
        NSMutableArray *pastEvents = [NSMutableArray arrayWithArray:sortedEvents];
        [pastEvents removeObjectsInArray:resultEvents];
        
        NSUInteger count = additionalEventCount < pastEvents.count ? additionalEventCount : pastEvents.count;
        for (NSUInteger i = 0; i < count; i++) {
            [resultEvents addObject:pastEvents[i]];
        }
    }
    
    NSArray *result = [self sortFutureEventsByDate:resultEvents];
    return result;
}

#pragma mark - Private methods

- (NSArray *)sortFutureEventsByDate:(NSArray *)events {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(startDate)) ascending:NO];
    NSArray *sortedEvents = [events sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    return sortedEvents;
}

@end
