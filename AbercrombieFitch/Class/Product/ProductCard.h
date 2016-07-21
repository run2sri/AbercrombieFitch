//
//  ProductCard.h
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProductCard : NSObject {
    
//    NSString *title;
//    NSString *backgroundImageUrl;
//    NSArray *content;
//    NSString *promoMessage;
//    NSString *topDescription;
//    NSString *bottomDescription;
}

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *backgroundImageUrl;
@property (nonatomic, readonly) UIImage *backgroundImage;
@property (nonatomic, readonly) NSArray *contentButtons;
@property (nonatomic, readonly) NSString *promoMessage;
@property (nonatomic, readonly) NSString *topDescription;
@property (nonatomic, readonly) NSString *bottomDescription;

- (id) initProductCardWithDictionary:(NSDictionary *)dict;
- (CGFloat) heightForTableViewCell;
- (NSString *) getButtonTargetURLAtIndex:(NSInteger)index;
@end
