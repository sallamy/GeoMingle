//
//  DiscoveryDataCenter.m
//  Discover Riyadh
//
//  Created by adel on 5/22/16.
//  Copyright © 2016 2p.com.sa. All rights reserved.
//

#import "GeoDataCenter.h"
#import "WebServiceHandler.h"
#import "GeoFeeds-Swift.h"
#import "OCMapper.h"
#import "JSONKit.h"
@implementation GeoDataCenter

+(GeoDataCenter *)sharedInstance {
	static GeoDataCenter *sharedInstance = nil;
	static dispatch_once_t pred;
	
	// partial fix for the "new" concurrency issue
	if (sharedInstance) return sharedInstance;
	
	dispatch_once(&pred, ^{
		sharedInstance = [GeoDataCenter alloc];
		sharedInstance = [sharedInstance init];
	});
	
	return sharedInstance;
}

-(void)feedsListWithCompletion:(void (^)(NSObject * response))success{

    
   
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"feeds" ofType:@"json"];
        NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
        JSONDecoder *decoder = [JSONDecoder decoder];
       NSArray * List=   [(NSDictionary*)[decoder parseJSONData:[fileContent dataUsingEncoding:NSUTF8StringEncoding]] objectForKey:@"feeds"]   ;

    


            InCodeMappingProvider *inCodeMappingProvider = [[InCodeMappingProvider alloc] init];
            [inCodeMappingProvider mapFromDictionaryKey:@"commentsList" toPropertyKey:@"commentsList" withObjectType:[comment class ] forClass:[feed class]];
            [[ObjectMapper sharedInstance] setMappingProvider:inCodeMappingProvider];
            
           NSArray *array = [feed objectFromDictionary:[[decoder parseJSONData:[fileContent dataUsingEncoding:NSUTF8StringEncoding]]  objectForKey:@"feeds"]];
    success(array);
//            for (ReservationModel *rse in array) {
//                rse.status = status_id;
//            }
//    

}


@end
