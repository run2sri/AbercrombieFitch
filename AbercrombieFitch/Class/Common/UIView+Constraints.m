//
//  UIView+Constraints.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/20/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (extended)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void) addBorderWidth:(CGFloat) width color:(UIColor*) color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (NSArray *)constraintsForAttribute:(NSLayoutAttribute)attribute
{
    NSPredicate * firstAttributePredicate = [NSPredicate predicateWithFormat:@"firstItem = %@ AND firstAttribute = %d AND class = %@", self, attribute, [NSLayoutConstraint class]];
    
    NSArray *filteredConstraints = [[self constraints] filteredArrayUsingPredicate:firstAttributePredicate];
    
    if (filteredConstraints.count) {
        return filteredConstraints;
    }
    
    NSPredicate * secondAttributePredicate = [NSPredicate predicateWithFormat:@"secondItem = %@ AND secondAttribute = %d AND class = %@", self, attribute, [NSLayoutConstraint class]];
    
    filteredConstraints = [[self.superview constraints] filteredArrayUsingPredicate:secondAttributePredicate];
    
    return filteredConstraints;
}

- (NSLayoutConstraint *)firstConstraintForAttribute:(NSLayoutAttribute)attribute
{
    NSArray *constraints = [self constraintsForAttribute:attribute];
    NSLayoutConstraint * firstConstraint = constraints.firstObject;
    
    return firstConstraint;
}


@end
