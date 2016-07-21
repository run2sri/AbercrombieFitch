//
//  UIView+Constraints.h
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/20/16.
//  Copyright © 2016 A&F. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (extended)
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
-(void) addBorderWidth:(CGFloat) width color:(UIColor*) color;
- (NSLayoutConstraint *)firstConstraintForAttribute:(NSLayoutAttribute)attribute;
@end
