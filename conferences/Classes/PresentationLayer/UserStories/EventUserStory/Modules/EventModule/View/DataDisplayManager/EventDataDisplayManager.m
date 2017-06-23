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

#import "EventDataDisplayManager.h"

#import <Nimbus/NimbusModels.h>

#import "EventCellObjectBuilderBase.h"
#import "EventCellObjectBuilderFactory.h"
#import "EventPlainObject.h"
#import "EXTScope.h"
#import "LectureInfoTableViewCellObject.h"
#import "PreviousLectureTableViewCellObject.h"
#import "EventListTableViewCellObject.h"
#import "EventViewAnimator.h"
#import "TechPlainObject.h"

@interface EventDataDisplayManager () <UITableViewDelegate>

@property (nonatomic, strong) NITableViewModel *tableViewModel;
@property (nonatomic, strong) NITableViewActions *tableViewActions;
@property (nonatomic, strong) EventCellObjectBuilderBase *cellObjectBuilder;
@property (nonatomic, strong) NSArray *cellObjects;

@end

@implementation EventDataDisplayManager

- (void)configureDataDisplayManagerWithEvent:(EventPlainObject *)event
                                  pastEvents:(NSArray *)pastEvents {
    self.cellObjectBuilder = [self.cellObjectBuilderFactory builderForEventType:event.eventType];
    self.cellObjects = [self.cellObjectBuilder cellObjectsForEvent:event
                                                        pastEvents:pastEvents];
}

#pragma mark DataDisplayManager methods

- (id<UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView {
    if (!self.tableViewModel) {
        self.tableViewModel = [self configureTableViewModel];
    }
    return self.tableViewModel;
}

- (id<UITableViewDelegate>)delegateForTableView:(UITableView *)tableView withBaseDelegate:(id<UITableViewDelegate>)baseTableViewDelegate {
    if (!self.tableViewActions) {
        [self setupActionBlocks];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.eventViewAnimator animateWithContentOffset:scrollView.contentOffset];
}

#pragma mark - Private methods

- (void)setupActionBlocks {
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
    
    @weakify(self);
    NIActionBlock lectureInfoActionBlock = ^BOOL(LectureInfoTableViewCellObject *object, UIViewController *controller, NSIndexPath* indexPath) {
        NSString *lectureObjectId = object.lectureId;
        
        [self.delegate didTapLectureInfoCellWithLectureObjectId:lectureObjectId];

        return YES;
    };
    [self.tableViewActions attachToClass:[LectureInfoTableViewCellObject class]
                                tapBlock:lectureInfoActionBlock];
    
    NIActionBlock pastEventActionBlock = ^BOOL(EventListTableViewCellObject *object, UIViewController *controller, NSIndexPath* indexPath) {
        @strongify(self);
        NSString *eventId = object.event.eventId;
        
        [self.delegate didTapEventCellWithEventId:eventId];
        
        return YES;
    };
    [self.tableViewActions attachToClass:[EventListTableViewCellObject class]
                                tapBlock:pastEventActionBlock];
    
    NIActionBlock pastLectureActionBlock = ^BOOL(PreviousLectureTableViewCellObject *object, UIViewController *controller, NSIndexPath* indexPath) {
        NSString *lectureId = object.lectureId;
        
        [self.delegate didTapLectureInfoCellWithLectureObjectId:lectureId];
        
        return YES;
    };
    [self.tableViewActions attachToClass:[PreviousLectureTableViewCellObject class]
                                tapBlock:pastLectureActionBlock];
    
    self.tableViewActions.tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
}

- (NITableViewModel *)configureTableViewModel {
    NITableViewModel *tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:self.cellObjects
                                                                    delegate:(id)[NICellFactory class]];
    
    return tableViewModel;
}

@end
