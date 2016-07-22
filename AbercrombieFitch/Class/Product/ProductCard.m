//
//  ProductCard.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "ProductCard.h"
#import "SDWebImageDownloader.h"
#import "AFUtils.h"

#define TITLE @"title"
#define BACKGROUNDIMAGE @"backgroundImage"
#define CONTENT @"content"
#define TARGET @"target"
#define PROMOMESSAGE @"promoMessage"
#define TOPDESCRIPTION @"topDescription"
#define BOTTOMDESCRIPTION @"bottomDescription"


@interface ProductCard()
@property (nonatomic, strong) NSDictionary *productCardRecords;
@property (nonatomic, strong) UIImage *bgImage;
@end


@implementation ProductCard


//Constructor

- (id) initProductCardWithDictionary:(NSDictionary *)dict {

    if (self = [super init]) {
        _productCardRecords = dict;
        [self loadBackgroundImage];
    }
    return self;
}

#pragma mark - Product Model Properties

-(NSString *)title {
    return _productCardRecords[TITLE];
}
-(NSString *)backgroundImageUrl {
    return _productCardRecords[BACKGROUNDIMAGE];
}
-(NSArray *)contentButtons {
    NSArray *shopContents = _productCardRecords[CONTENT];
    NSMutableArray *_contentButtons = [NSMutableArray arrayWithCapacity:[shopContents count]];
    for (NSDictionary *content in shopContents) {
        UIButton *shopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [shopButton setTitle:content[TITLE] forState:UIControlStateNormal];
        [_contentButtons addObject:shopButton];
    }
    return _contentButtons;
}

- (NSString *) getButtonTargetURLAtIndex:(NSInteger)index {
     NSArray *shopContents = _productCardRecords[CONTENT];
    NSString *url = nil;
    if ([shopContents count] >= index) {
        NSDictionary *content = shopContents[index];
        url = content[TARGET];
    }
    return url;
}

-(NSString *)promoMessage {
    return _productCardRecords[PROMOMESSAGE];
}
-(NSString *)topDescription {
    return _productCardRecords[TOPDESCRIPTION];
}
-(NSString *)bottomDescription {
    return _productCardRecords[BOTTOMDESCRIPTION];
}

-(UIImage *)backgroundImage {
    return _bgImage;
}

// Load background Image in background and assigned object. if more value, will be stored into Coredata
- (void) loadBackgroundImage {
    if (self.backgroundImageUrl) {
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        [downloader downloadImageWithURL:[NSURL URLWithString:self.backgroundImageUrl]
                                 options:0
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    // progression tracking code
                                }
                               completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                   if (image && finished) {
                                       _bgImage = image;
                                   }
                               }];
    }
}

// Calculating Cell height based properties and background image size

- (CGFloat) heightForTableViewCell {
    
    // Values will be calculated dynamically
    CGFloat height = 0;
    height = spacing_10;
    if (_bgImage) {
        height += _bgImage.size.height + spacing_10;
    }
    
    if (self.topDescription) {
        height += label_height + spacing_5;
    }
    
    if (self.title) {
        height += label_height + spacing_5;
    }

    if (self.promoMessage) {
        height += label_height + spacing_5;
    }
    
    if (self.bottomDescription) {
        height += label_height + spacing_5;
    }
    
    height += spacing_5;
    
    if ([self.contentButtons count] > 0) {
        height += ([self.contentButtons count] * button_height) + spacing_10;
    }
    
    height += spacing_10; //Bottom spacing
    
    return height;
}
@end
