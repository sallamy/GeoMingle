//
//  BaseRequest.m
//  Discover Riyadh
//
//  Created by mohamed salah on 5/22/16.
//  Copyright © 2016 2p.com.sa. All rights reserved.
//

#import "BaseRequest.h"


@implementation BaseRequest
-(HTTPRequestType)type{
    return GET;
}
-(NSDictionary *)body{
    return @{};
}
-(NSDictionary *)header{
      return nil;
}

-(NSString *)url{
    return baseUrl;
}

@end
