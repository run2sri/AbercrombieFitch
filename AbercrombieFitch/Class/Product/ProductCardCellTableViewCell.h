//
//  ProductCardCellTableViewCell.h
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/20/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductCard;
@protocol ProducrCardDelegate;

@interface ProductCardCellTableViewCell : UITableViewCell
@property (nonatomic, assign) id<ProducrCardDelegate> delegate;
- (void) configureCellAtIndexPath:(NSIndexPath *)indexPath withProduct:(ProductCard *)product;
@end
