//
//  AFUtils.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "AFUtils.h"
#import "UIView+Constraints.h"

NSString* const AFProductDataServerURL = @"https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json";
NSString* const AFProductDataLoaded = @"ProductDataLoaded";
NSString* const AFMainStoryboardName = @"Main";
NSString* const AFWebStoryIdentifier = @"afwebview";

CGFloat const spacing_10 = 10;
CGFloat const spacing_5 = 5;
CGFloat const label_height = 25;
CGFloat const button_height = 40;

@implementation AFUtils

-(id) init
{
    self = [super init];
    
    return self;
}

+(void)applyButtonThemeToButton:(UIButton*)button {
    if (!button) {
        return;
    }
    
    [button setHidden:NO];
    
    button.backgroundColor = [UIColor clearColor];
    button.backgroundColor = [AFUtils buttonBackgroundColor];
    
    [button setTitleColor:[AFUtils buttonTitleColor] forState:UIControlStateNormal];
    [button setTitleColor:[AFUtils buttonTitleColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[AFUtils buttonTitleColor] forState:UIControlStateSelected];
    [button addBorderWidth:1.0f color:[AFUtils buttonTitleColor]];
}

+ (UIColor *) buttonBackgroundColor {
    return [UIColor whiteColor];
}

+ (UIColor *) buttonTitleColor {
    return [UIColor darkGrayColor];
}


+ (NSString *) createWebHTMLWithText:(NSString *)text {
    
    //create the string
    NSMutableString *html = [NSMutableString stringWithString: @"<html><head><title></title></head><body link=\"#d3d3d3\" vlink=\"#d3d3d3\" alink=\"#d3d3d3\" style=\"background:transparent;\">"];
    
    //continue building the string
    NSString *htmlString = [NSString stringWithFormat:@"<p><CENTER><font color=\"#d3d3d3\"> %@ </font></CENTER></p>",text];
    [html appendString:htmlString];
    [html appendString:@"</body></html>"];
    return html;
}

+ (UIStoryboard *) getMainStoryBoardWithName:(NSString *)storyboard {
    return [UIStoryboard storyboardWithName:storyboard bundle:nil];
}

@end
