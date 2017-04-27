//
//  BaseRequest.h
//  Discover Riyadh
//
//  Created by mohamed salah on 5/22/16.
//  Copyright © 2016 2p.com.sa. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    GET,
    POST
} HTTPRequestType;
//static NSString *baseUrl = @"https://ientestlms.t4edu.com/mobile/api/";
static NSString *baseUrl = @"https://eservices.t4edu.com/MobileApiV3/api/";
@interface BaseRequest : NSURLRequest

@property(nonatomic, strong, readonly)NSDictionary *body;
@property(nonatomic,strong, readonly)NSString *url;
@property(nonatomic, readonly)HTTPRequestType type;
@property(nonatomic, strong, readonly)NSDictionary *header;

@end
