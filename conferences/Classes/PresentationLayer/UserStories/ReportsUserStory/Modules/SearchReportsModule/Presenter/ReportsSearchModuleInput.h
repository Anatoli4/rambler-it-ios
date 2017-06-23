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
#import <ViperMcFlurry/ViperMcFlurry.h>

@protocol ReportsSearchModuleInput <RamblerViperModuleInput>

/**
 @author Zinovyev Konstantin
 
 Method is used to update reports search module with search string
 
 @param searchText текст в поле поиска
 */
- (void)updateModuleWithSearchTerm:(NSString *)searchTerm;

/**
 @author Zinovyev Konstantin
 
 Method is used to configure reports search module with search string
 
 @param searchText search string
 */
- (void)configureReportsSearchModuleWithSearchTerm:(NSString *)searchTerm;

/**
 @author Zinovyev Konstantin
 
 Method is used to close reports search module
 */
- (void)closeSearchModule;


@end

