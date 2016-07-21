//
//  JSONWebservice.h
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/19/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
Block called when the response success. This could be once

@param data contains the parsed item.
*/
typedef void (^AFJsonSuccessBlock)(NSArray *data);

/**
 Block called if an error occurs.
 @param error the error.
 */
typedef void (^AFJsonErrorBlock)(NSError* error);


@interface JSONWebservice : NSObject
-(void)requestWithURL:(NSString*)url withSuccessBlock:(AFJsonSuccessBlock)successResponse andErrorBlock:(AFJsonErrorBlock)errorResponse;

@end
