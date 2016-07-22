//
//  AFUtils.h
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


extern NSString *const AFProductDataServerURL;
extern NSString *const AFProductDataLoaded;
extern NSString* const AFMainStoryboardName;
extern NSString* const AFWebStoryIdentifier;
extern NSString * const ProductCardCellIdentifier;
extern NSString * const NoProductCardCellIdentifier;

extern CGFloat const spacing_10;
extern CGFloat const spacing_5;
extern CGFloat const label_height;
extern CGFloat const button_height;

@interface AFUtils : NSObject
+ (UIColor *) buttonBackgroundColor;
+ (UIColor *) buttonTitleColor;
+ (void)applyButtonThemeToButton:(UIButton*)button;
+ (NSString *) createWebHTMLWithText:(NSString *)text;
+ (UIStoryboard *) getMainStoryBoardWithName:(NSString *)storyboard;
@end


