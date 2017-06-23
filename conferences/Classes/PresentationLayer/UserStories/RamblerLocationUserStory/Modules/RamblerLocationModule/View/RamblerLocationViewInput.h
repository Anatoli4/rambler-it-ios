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

#import <Foundation/Foundation.h>

@class DirectionObject;
@class UBSDKRideParameters;
@class UBSDKRideRequestViewController;

@protocol RamblerLocationViewInput <NSObject>

/**
 @author Egor Tolstoy
 
 Method setups view appearance using directions data
 
 @param directions <#directions description#>
 */
- (void)setupViewWithDirections:(NSArray <DirectionObject *> *)directions;

/**
 @author Surik Sarkisyan
 
 Method setups uber rides default config
 
 @param parameters contains pickupLocation, dropoffLocation, dropoffLocationName etc.
 */
- (void)setupUberRidesDefaultConfigWithParameters:(UBSDKRideParameters *)parameters;

/**
 @author Surik Sarkisyan
 
 Method tells view update ride information and display on ride request button
 */
- (void)updateRideInformation;

/**
 @author Surik Sarkisyan
 
 Method tells view add constraints for ride request button
 */
- (void)addRideRequestButtonConstraint;

/**
 @author Surik Sarkisyan
 
 Method tells view update rideRequestButton parameters
 
 @param parameters contains pickupLocation, dropoffLocation, dropoffLocationName etc.
 */
- (void)updateRideRequestButtonParameters:(UBSDKRideParameters *)parameters;

/**
 @author Surik Sarkisyan
 
 Method tells view dismissRideRequestViewController;
 
 @param UBSDKRideRequestViewController which should be dismissed
 */
- (void)dismissRideRequestViewController:(UBSDKRideRequestViewController *)rideRequestViewController;

/**
 @author Surik Sarkisyan
 
 Method shows alert with title and message
 
 @param title
 @param message
 */
- (void)displayAlertWithTitle:(NSString *)title
                   andMessage:(NSString *)message;

@end
