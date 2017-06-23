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

/**
 @author Artem Karpushin
 
 Class is designed to cast a date to a string with specific format
 */
@interface DateFormatter : NSObject

/**
 @author Egor Tolstoy
 
 Method is used to obtain string from date with format "d MMMM yyyy в HH:mm"
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayMonthYearTimeFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format "d MMMM в HH:mm"
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayMonthTimeFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format "d MMMM yyyy"
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayMonthYearFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format "d MMMM"
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayMonthFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format "MMMM"
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithMonthFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format "d"
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithDayFormat:(NSDate *)date;

/**
 @author Artem Karpushin
 
 Method is used to obtain string from date with format "HH:mm"
 
 @param date NSDate object
 
 @return NSString object
 */
- (NSString *)obtainDateWithTimeFormat:(NSDate *)date;

@end
