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

#import "EventPresenter.h"
#import "EventViewInput.h"
#import "EventInteractorInput.h"
#import "EventRouterInput.h"
#import "EventPlainObject.h"
#import "EventPresenterStateStorage.h"
#import "LocalizedStrings.h"
#import "MetaEventPlainObject.h"

@implementation EventPresenter

#pragma mark - EventModuleInput

- (void)configureCurrentModuleWithEventObjectId:(NSString *)objectId {
    self.presenterStateStorage.eventObjectId = objectId;
}

#pragma mark - EventViewOutput

- (void)didTriggerViewReadyEvent {
    EventPlainObject *event = [self.interactor obtainEventWithObjectId:self.presenterStateStorage.eventObjectId];
    NSArray *pastEvents = [self.interactor obtainPastEventsForEvent:event];
    [self.view configureViewWithEvent:event
                           pastEvents:pastEvents];
    [self.interactor trackEventVisitForEvent:event];
    self.presenterStateStorage.activity = [self.interactor registerUserActivityForEvent:event];
}

- (void)didTriggerViewWillDisappearEvent {
    [self.interactor unregisterUserActivity:self.presenterStateStorage.activity];
}

- (void)didTapSignUpButtonWithEvent:(EventPlainObject *)event {

}

- (void)didTapSaveToCalendarButtonWithEvent:(EventPlainObject *)event {
    [self.interactor saveEventToCalendar:event];
}

- (void)didTapLectureInfoCellWithLectureObjectIdEvent:(NSString *)lectureObjectId {
    [self.router openLectureModuleWithLectureObjectId:lectureObjectId];
}

- (void)didTapEventCellWithEventId:(NSString *)eventId {
    [self.router openEventModuleWithEventId:eventId];
}

- (void)didTapShareButton {
    EventPlainObject *event = [self.interactor obtainEventWithObjectId:self.presenterStateStorage.eventObjectId];
    NSArray *activityItems = [self.interactor obtainActivityItemsForEvent:event];
    
    [self.router openShareModuleWithActivityItems:activityItems];
}

- (void)didTapSpeakerViewWithSpeakerId:(NSString *)speakerId {
    [self.router openSpeakerInfoModuleWithSpeakerId:speakerId];
}

#pragma mark - EventInteractorOutput

- (void)didSaveEventToCalendarWithError:(NSError *)error {
    if (error) {
        [self.view displayAlertWithTitle:NSLocalizedString(ErrorAlertTitle, nil)
                              andMessage:NSLocalizedString(EventAlreadyStoredInCalendarErrorDescription, nil)];
    }
    else {
        [self.view displayAlertWithTitle:NSLocalizedString(EmptyAlertTitle, nil)
                              andMessage:NSLocalizedString(EventSavedToCalendarAlertMessage, nil)];
    }
}

@end
