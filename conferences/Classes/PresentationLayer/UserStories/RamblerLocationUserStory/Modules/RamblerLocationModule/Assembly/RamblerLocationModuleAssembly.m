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

#import "RamblerLocationModuleAssembly.h"

#import "ServiceComponents.h"
#import "PresentationLayerHelpersAssembly.h"

#import "RamblerLocationViewController.h"
#import "RamblerLocationInteractor.h"
#import "RamblerLocationPresenter.h"
#import "RamblerLocationRouter.h"
#import "RamblerLocationDataDisplayManager.h"
#import "DirectionCellObjectFactory.h"
#import "UberRidesFactory.h"
#import "RamblerLocationStateStorage.h"

@implementation  RamblerLocationModuleAssembly

- (RamblerLocationViewController *)viewRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationViewController class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterRamblerLocation]];
                              [definition injectProperty:@selector(dataDisplayManager)
                                                    with:[self dataDisplayManagerRamblerLocation]];
                              [definition injectProperty:@selector(requestBehavior)
                                                    with:[self.uberRidesAssembly requestBehaviorWithViewController:[self viewRamblerLocation]]];
                              [definition injectProperty:@selector(uberRidesFactory)
                                                    with:[self uberRidesFactory]];
                          }];
}

- (RamblerLocationInteractor *)interactorRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationInteractor class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(output)
                                                    with:[self presenterRamblerLocation]];
                              [definition injectProperty:@selector(ramblerLocationService)
                                                    with:[self.serviceComponents ramblerLocationService]];
                              [definition injectProperty:@selector(mapLinkBuilder)
                                                    with:[self.presentationLayerHelpersAssembly appleMapsLinkBuilder]];
                              [definition injectProperty:@selector(builder)
                                                    with:[self.uberRidesAssembly rideParametersBuilder]];
                              [definition injectProperty:@selector(locationService)
                                                    with:[self.serviceComponents locationServiceWithDelegate:[self interactorRamblerLocation]]];
                              [definition injectProperty:@selector(ridesClient)
                                                    with:[UBSDKRidesClient new]];
                          }];
}

- (RamblerLocationPresenter *)presenterRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationPresenter class]
                          configuration:^(TyphoonDefinition *definition) {
                            [definition injectProperty:@selector(view) 
                                                  with:[self viewRamblerLocation]];                                            
                            [definition injectProperty:@selector(interactor) 
                                                  with:[self interactorRamblerLocation]];
                            [definition injectProperty:@selector(router) 
                                                  with:[self routerRamblerLocation]];
                              [definition injectProperty:@selector(stateStorage)
                                                    with:[self stateStorageRamblerLocation]];
            }];
}

- (RamblerLocationRouter *)routerRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationRouter class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(application)
                                                    with:[UIApplication sharedApplication]];
                          }];
}

- (RamblerLocationDataDisplayManager *)dataDisplayManagerRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationDataDisplayManager class]
                          configuration:^(TyphoonDefinition *definition) {
                              [definition injectProperty:@selector(cellObjectFactory)
                                                    with:[self directionCellObjectFactory]];
                          }];
}

- (DirectionCellObjectFactory *)directionCellObjectFactory {
    return [TyphoonDefinition withClass:[DirectionCellObjectFactory class]];
}

- (UberRidesFactory *)uberRidesFactory {
    return [TyphoonDefinition withClass:[UberRidesFactory class]];
}

- (DirectionCellObjectFactory *)stateStorageRamblerLocation {
    return [TyphoonDefinition withClass:[RamblerLocationStateStorage class]];
}

@end
