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
#import <UIKit/UIKit.h>

/**
 @author Golovko Mikhail
 
 Модель настроек для расчёта размеров ячеек тегов
 */
@interface TagCellSizeConfig : NSObject

/**
 @author Golovko Mikhail
 
 Ширина компонента отображения тегов
 */
@property (nonatomic, assign, readonly) CGFloat contentWidth;

/**
 @author Golovko Mikhail
 
 Отступ между элементами
 */
@property (nonatomic, assign, readonly) CGFloat itemSpacing;

/**
 @author Golovko Mikhail
 
 Высота ячейки тэгов
 */
@property (nonatomic, assign, readonly) CGFloat itemHeight;

/**
 @author Konstantin Zinovyev
 
 Смещение слева/справа текста в ячейке тэгов
 */
@property (nonatomic, assign, readonly) CGFloat itemSideInset;

/**
 @author Konstantin Zinovyev
 
 Шрифт используемый в ячейке тэгов
 */
@property (nonatomic, assign, readonly) UIFont *font;

/**
 @author Golovko Mikhail
 
 Метод возвращает дефолтную конфигурацию
 
 @return TagCellSizeConfig
 */
+ (instancetype)defaultConfig;

- (instancetype)initWithContentWidth:(CGFloat)contentWidth
                         itemSpacing:(CGFloat)itemSpacing
                          itemHeight:(CGFloat)itemHeight
                       itemSideInset:(CGFloat)itemSideInset
                                font:(UIFont *)font;


@end