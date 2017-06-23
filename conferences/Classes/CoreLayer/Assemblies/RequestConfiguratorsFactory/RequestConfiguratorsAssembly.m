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

#import "RequestConfiguratorsAssembly.h"

#import "RESTRequestConfigurator.h"

static  NSString *const kConfigFileName  = @"Conferences.API.plist";
static  NSString *const kParseRootURLKey = @"API.RootURL";
static  NSString *const kParseRESTPathKey = @"API.RESTPath";

@implementation RequestConfiguratorsAssembly

#pragma mark - Option matcher

- (id<RequestConfigurator>)requestConfiguratorWithType:(NSNumber *)type {
    return [TyphoonDefinition withOption:type matcher:^(TyphoonOptionMatcher *matcher) {
        [matcher caseEqual:@(RequestConfigurationRESTType)
                       use:[self restRequestConfigurator]];
    }];
}

#pragma mark - Concrete definitions

- (id<RequestConfigurator>)restRequestConfigurator {
    return [TyphoonDefinition withClass:[RESTRequestConfigurator class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithBaseURL:apiPath:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:TyphoonConfig(kParseRootURLKey)];
            [initializer injectParameterWith:TyphoonConfig(kParseRESTPathKey)];
        }];
    }];
}

#pragma mark - Config

- (id)configurer {
    return [TyphoonDefinition withConfigName:kConfigFileName];
}

@end
