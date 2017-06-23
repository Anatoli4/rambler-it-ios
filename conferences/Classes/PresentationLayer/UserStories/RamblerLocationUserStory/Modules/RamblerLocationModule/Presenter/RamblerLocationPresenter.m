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

#import "RamblerLocationPresenter.h"
#import "RamblerLocationViewInput.h"
#import "RamblerLocationInteractorInput.h"
#import "RamblerLocationRouterInput.h"
#import "LocalizedStrings.h"
#import "RamblerLocationStateStorage.h"

@implementation RamblerLocationPresenter

#pragma mark - RamblerLocationViewOutput

- (void)didTriggerViewReadyEvent {
    NSArray *directions = [self.interactor obtainDirections];
    [self.view setupViewWithDirections:directions];
    
    UBSDKRideParameters *parameters = [self.interactor obtainDefaultParameters];
    [self.view setupUberRidesDefaultConfigWithParameters:parameters];
    [self.view addRideRequestButtonConstraint];
    [self.view updateRideInformation];
    [self.interactor performRideInfoForUserCurrentLocationIfPossible];
    
    NSUserActivity *activity = [self.interactor registerUserActivity];
    self.stateStorage.activity = activity;
}

- (void)uberModalViewControllerWillDismiss {
    [self.view updateRideInformation];
}

- (void)didTriggerViewWillDisappearEvent {
    [self.interactor unregisterUserActivity:self.stateStorage.activity];
}

- (void)didTriggerShareButtonTapEvent {
    NSURL *locationUrl = [self.interactor obtainRamblerLocationUrl];
    [self.router openMapsWithUrl:locationUrl];
}

- (void)rideRequestViewController:(UBSDKRideRequestViewController *)rideRequestViewController
                  didReceiveError:(NSError *)error {
    [self.view dismissRideRequestViewController:rideRequestViewController];
    [self.view displayAlertWithTitle:RCLocalize(ErrorAlertTitle)
                          andMessage:RCLocalize(kUberAuthErrorMessage)];
}

#pragma mark - RamblerLocationInteractorOutput

- (void)rideParametersDidLoad:(UBSDKRideParameters *)parameters {
    [self.view updateRideRequestButtonParameters:parameters];
    [self.view updateRideInformation];
}

@end
