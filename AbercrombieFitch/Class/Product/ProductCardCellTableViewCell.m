//
//  ProductCardCellTableViewCell.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/20/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "ProductCardCellTableViewCell.h"
#import "ProductCard.h"
#import "UIView+Constraints.h"
#import "AFUtils.h"
#import "ProducrCardDelegate.h"

@interface ProductCardCellTableViewCell() <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UILabel *topDescription;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *promoLabel;
@property (nonatomic, weak) IBOutlet UIWebView *bottomDescription;
@property (nonatomic, weak) IBOutlet UIView *shopButtonView;
@property (nonatomic, weak) IBOutlet UIButton *shopMen;
@property (nonatomic, weak) IBOutlet UIButton *shopWomen;

@property (nonatomic, strong) ProductCard *productCard;
@end


@implementation ProductCardCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Configure the view for normal state
- (void) configureCellAtIndexPath:(NSIndexPath *)indexPath withProduct:(ProductCard *)product {
    NSLog(@"Indexpath row %ld",(long)indexPath.row);
    _productCard = product;
    [self privateLayoutSubviews];
    _backgroundImage.image = product.backgroundImage;
    _topDescription.text = product.topDescription;
    _titleLabel.text = product.title;
    _promoLabel.text = product.promoMessage;
    [self loadBottomDescriptionWithText:product.bottomDescription];
    int i = 0;
    CGFloat y = 0;
    CGFloat verticalSpace = 5;

    NSArray *_subViews = [_shopButtonView subviews];
    for (UIView *v in _subViews) {
        [v removeFromSuperview];
    }
    for (UIButton *shopButton in product.contentButtons) {
        shopButton.tag = i;
        [shopButton addTarget:self action:@selector(shopButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [AFUtils applyButtonThemeToButton:shopButton];
        [shopButton setFrame:CGRectMake((_shopButtonView.width/2)-150, y, 300, button_height)];
        y = y + verticalSpace + button_height;
        [_shopButtonView addSubview:shopButton];
        i++;
    }
    [_shopButtonView setHeight:y];
    [self layoutIfNeeded];
}

// IBAction for shop button, it will notify to main view controller

- (void) shopButtonPressed:(UIButton *)sender {
    NSInteger index = sender.tag;
    [_delegate loadURL:[_productCard getButtonTargetURLAtIndex:index]];
}

// Load bottom descript in webview

- (void) loadBottomDescriptionWithText:(NSString *)webText {
    _bottomDescription.delegate = self;
    _bottomDescription.scrollView.scrollEnabled = NO;
    _bottomDescription.scrollView.bounces = NO;
    [_bottomDescription loadHTMLString:[AFUtils createWebHTMLWithText:webText] baseURL:nil];
}

// If the value is not present for object,it will set heoght 0 and hide the subview object of cell

- (void) privateLayoutSubviews {
    
    NSLayoutConstraint * bgImageWidthtConstraint = [_backgroundImage firstConstraintForAttribute:NSLayoutAttributeWidth];
    NSLayoutConstraint * bgImageHeightConstraint = [_backgroundImage firstConstraintForAttribute:NSLayoutAttributeHeight];
    if (_productCard.backgroundImage) {
        _backgroundImage.hidden = NO;
        CGFloat width = _productCard.backgroundImage.size.width;
        CGFloat height = _productCard.backgroundImage.size.height;
        bgImageWidthtConstraint.constant = width;
        bgImageHeightConstraint.constant = height;
    } else {
        _backgroundImage.hidden = YES;
        bgImageHeightConstraint.constant = 0;
    }
    
    NSLayoutConstraint * topDescriptionHeightConstraint = [_topDescription firstConstraintForAttribute:NSLayoutAttributeHeight];
    if (!_productCard.topDescription) {
        _topDescription.hidden = YES;
        topDescriptionHeightConstraint.constant = 0;
    } else {
        _topDescription.hidden = NO;
        topDescriptionHeightConstraint.constant = label_height;
    }
    
    NSLayoutConstraint * titleHeightConstraint = [_titleLabel firstConstraintForAttribute:NSLayoutAttributeHeight];
    if (!_productCard.title) {
        _titleLabel.hidden = YES;
        titleHeightConstraint.constant = 0;
    } else {
        _titleLabel.hidden = NO;
        titleHeightConstraint.constant = label_height;
    }

    NSLayoutConstraint * promoHeightConstraint = [_promoLabel firstConstraintForAttribute:NSLayoutAttributeHeight];
    if (!_productCard.promoMessage) {
        _promoLabel.hidden = YES;
        promoHeightConstraint.constant = 0;
    } else {
        _promoLabel.hidden = NO;
        promoHeightConstraint.constant = label_height;
    }
    
    NSLayoutConstraint * bottomDescriptionHeightConstraint = [_bottomDescription firstConstraintForAttribute:NSLayoutAttributeHeight];
    if (!_productCard.bottomDescription) {
        _bottomDescription.hidden = YES;
        bottomDescriptionHeightConstraint.constant = 0;
    } else {
        _bottomDescription.hidden = NO;
        bottomDescriptionHeightConstraint.constant = label_height;
    }

    NSLayoutConstraint * shopViewHeightConstraint = [_shopButtonView firstConstraintForAttribute:NSLayoutAttributeHeight];
    if ([_productCard.contentButtons count] > 0) {
        _shopButtonView.hidden = NO;
        shopViewHeightConstraint.constant = [_productCard.contentButtons count] * button_height;
    } else {
        _shopButtonView.hidden = YES;
        shopViewHeightConstraint.constant = 0;
    }
}

// Apply theme object for each object
- (void) applyThemeForSubviews {
    
}

#pragma mark - webview delegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *requestURL = [request URL];
    if (![requestURL.absoluteString isEqualToString:@"about:blank"]) {

        NSString *trimmedRequestURLString = requestURL.absoluteString;
        // Strip out applewebdata://<UUID> prefix applied when HTML is loaded locally
        if ([requestURL.scheme isEqualToString:@"applewebdata"]) {
            
            trimmedRequestURLString = [trimmedRequestURLString stringByReplacingOccurrencesOfString:@"^(?:applewebdata://[0-9A-Z-]*/?)" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, trimmedRequestURLString.length)];
            if (trimmedRequestURLString.length > 0) {
                trimmedRequestURLString = [trimmedRequestURLString stringByReplacingOccurrencesOfString:@"/%22" withString:@""];
                trimmedRequestURLString = [trimmedRequestURLString stringByReplacingOccurrencesOfString:@"%22" withString:@""];
            }
        }
        [_delegate loadURL:trimmedRequestURLString];
        return NO;
    }
    return YES;
}



@end
