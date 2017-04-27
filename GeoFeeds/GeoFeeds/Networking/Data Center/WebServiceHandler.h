//
//  WebServiceHandler.h
//  Discover Riyadh
//
//  Created by mohamed salah on 5/22/16.
//  Copyright © 2016 2p.com.sa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BaseRequest.h"

@interface WebServiceHandler : AFHTTPSessionManager
+(WebServiceHandler *)sharedInstance;
-(void)executeRequest:(BaseRequest *)request success:(void (^)(NSObject * response))success
                 fail:(void (^)(NSError * error))fail;
-(void)cancelRequests;
@end
