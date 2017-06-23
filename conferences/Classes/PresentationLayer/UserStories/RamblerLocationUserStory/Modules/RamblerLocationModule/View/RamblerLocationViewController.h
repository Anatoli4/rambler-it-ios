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

#import <UIKit/UIKit.h>
#import "RamblerLocationViewInput.h"
#import "RamblerLocationDataDisplayManager.h"
#import <UberRides/UberRides.h>

@class UberRidesFactory;
@protocol RamblerLocationFeedbackGenerator;
@protocol RamblerLocationViewOutput;

@interface RamblerLocationViewController : UIViewController <RamblerLocationViewInput, UBSDKModalViewControllerDelegate, UBSDKRideRequestViewControllerDelegate, RamblerLocationDataDisplayManagerDelegate>

#pragma mark - Dependencies

@property (nonatomic, strong) id<RamblerLocationViewOutput> output;
@property (nonatomic, strong) RamblerLocationDataDisplayManager *dataDisplayManager;
@property (nonatomic, strong) UBSDKRideRequestViewRequestingBehavior *requestBehavior;
@property (nonatomic, readonly, strong) UBSDKRideRequestButton *rideRequestButton;
@property (nonatomic, strong) UberRidesFactory *uberRidesFactory;
@property (nonatomic, strong) id<RamblerLocationFeedbackGenerator> feedbackGenerator;

#pragma mark - Outlets

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIView *rideButtonContainerView;

#pragma mark - IBActions

- (IBAction)didTapShareButton:(id)sender;

@end

