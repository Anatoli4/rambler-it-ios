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

#import "EventListTableViewCellObject.h"

#import "EventListTableViewCell.h"
#import "EventPlainObject.h"
#import "MetaEventPlainObject.h"

@interface EventListTableViewCellObject ()

@property (nonatomic, strong, readwrite) NSString *eventTitle;
@property (nonatomic, strong, readwrite) NSURL *imageUrl;
@property (nonatomic, strong, readwrite) NSString *date;
@property (nonatomic, strong, readwrite) NSString *time;
@property (nonatomic, strong, readwrite) EventPlainObject *event;
@property (assign, nonatomic, readwrite) BOOL customBackgroundFlag;

@end

@implementation EventListTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithEvent:(EventPlainObject *)event
                    eventDate:(NSString *)date
                         time:(NSString *)time
         customBackgroundFlag:(BOOL)customBackgroundFlag {
    self = [super init];
    if (self) {
        _date = date;
        _time = time;
        _eventTitle = event.name;
        _imageUrl = [NSURL URLWithString:event.metaEvent.imageUrlPath];
        _event = event;
        _customBackgroundFlag = customBackgroundFlag;
    }
    return self;
}

+ (instancetype)objectWithEvent:(EventPlainObject *)event
                      eventDate:(NSString *)date
                           time:(NSString *)time
           customBackgroundFlag:(BOOL)customBackgroundFlag {
    return [[self alloc] initWithEvent:event
                             eventDate:date
                                  time:time
                  customBackgroundFlag:customBackgroundFlag];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [EventListTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([EventListTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
