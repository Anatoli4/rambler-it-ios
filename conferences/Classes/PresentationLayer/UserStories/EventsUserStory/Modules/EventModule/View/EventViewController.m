//
//  EventView.m
//  Conferences
//
//  Created by Karpushin Artem on 01/11/15.
//  Copyright 2015 Rambler. All rights reserved.
//

#import "EventViewController.h"
#import "EventViewOutput.h"
#import "EventDataDisplayManager.h"
#import "DataDisplayManager.h"
#import "EventTableViewCellActionProtocol.h"

#import <CrutchKit/Proxying/Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h>

@interface EventViewController() <EventTableViewCellActionProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpaceToTableViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewToHeaderConstraint;

@end

@implementation EventViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    [self cd_startObserveProtocol:@protocol(EventTableViewCellActionProtocol)];
	[self.output setupView];
}

#pragma mark - EventViewInput

- (void)configureViewWithEvent:(PlainEvent *)event {
    [self.dataDisplayManager configureDataDisplayManagerWithEvent:event];
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
    
    // обновление высоты ячейки
//    [self.view updateConstraintsIfNeeded];
//    [self.tableView beginUpdates];
//    [self.tableView endUpdates];
}

#pragma mark - EventTableViewCellActionProtocol

- (void)didTapSignUpButton:(UIButton *)button {
    [self.output didTriggerSignUpButtonTappedEvent:button];
}

- (void)didTapSaveToCalendarButton:(UIButton *)button {
    [self.output didTriggerSaveToCalendarButtonTappedEvent:button];
}

- (void)didTapReadMoreEventDescriptionButton:(UIButton *)button {
    [self.output didTriggerReadMoreEventDescriptionButtonTappedEvent:button];
}

- (void)didTapReadMoreLectionDescriptionButton:(UIButton *)button {
    [self.output didTriggerReadMoreLectionDescriptionButtonTappedEvent:button];
}

- (void)didTapCurrentTranslationButton:(UIButton *)button {
    [self.output didTriggerCurrentTranslationButtonTapEvent:button];
}

@end