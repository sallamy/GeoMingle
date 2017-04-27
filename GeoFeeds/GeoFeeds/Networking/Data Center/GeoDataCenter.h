//
//  DiscoveryDataCenter.h
//  Discover Riyadh
//
//  Created by adel on 5/22/16.
//  Copyright © 2016 2p.com.sa. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef enum : NSUInteger {
	CONNECTION_Error,
	UnExpeced_Error,
    SessionExpired_Error
} ERROR_TYPE;

@interface GeoDataCenter :  NSObject
+(GeoDataCenter *)sharedInstance;
-(void)feedsListWithCompletion:(void (^)(NSObject * response))success;
@end
