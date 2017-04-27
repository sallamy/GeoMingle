//
//  WebServiceHandler.m
//  Discover Riyadh
//
//  Created by mohamed salah on 5/22/16.
//  Copyright © 2016 2p.com.sa. All rights reserved.
//

#import "WebServiceHandler.h"




@implementation WebServiceHandler
-(instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    self.responseSerializer = [AFCompoundResponseSerializer serializer];
 
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
      self.requestSerializer.timeoutInterval = 20;
    return self;
}

+(WebServiceHandler *)sharedInstance
{
    static WebServiceHandler *sharedInstance = nil;
    static dispatch_once_t pred;
    
    // partial fix for the "new" concurrency issue
    if (sharedInstance) return sharedInstance;

    
    dispatch_once(&pred, ^{
        sharedInstance = [WebServiceHandler alloc];
        sharedInstance = [sharedInstance init];
    });
    
    return sharedInstance;
}


-(void)executeRequest:(BaseRequest *)request success:(void (^)(NSObject * response))success
                 fail:(void (^)(NSError * error))fail{
    
    NSURL * url = [[NSURL  alloc]initWithString:request.url];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    
  
   
    if (request.type == GET){
        mRequest.HTTPMethod = @"GET";
		self.requestSerializer = [AFHTTPRequestSerializer serializer];
        mRequest = [[AFHTTPRequestSerializer serializer]requestWithMethod:@"GET" URLString:request.url parameters:request.body error:nil];

     
    }else{
        mRequest.HTTPMethod = @"POST";
		self.requestSerializer = [AFJSONRequestSerializer serializer];

        mRequest = [[AFHTTPRequestSerializer serializer]requestWithMethod:@"POST"
                                                                URLString:request.url
                                                               parameters:request.body
                                                                    error:nil];
       
		
		
        
        NSLog(@"%@",request.url);
    }
    
    if (request.header != nil) {
      mRequest.allHTTPHeaderFields = request.header;
    }
     mRequest.timeoutInterval = 90;
    NSLog(@"URL:%@\n\n\n", mRequest);
     NSLog(@"body:%@\n\n\n", request.body);

    [[self dataTaskWithRequest:mRequest
               uploadProgress:nil
             downloadProgress:nil
            completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                if (error == nil) {
                    NSLog(@"response %@\n\n\n", response);
                    NSLog(@"response %@\n\n\n",responseObject);
                    success(responseObject);
                }else{
                    NSLog(@"error %@",error.description);
                    NSLog(@"response %@\n\n\n", response);
                    if(error.code != -999){
                        fail(error);
                    }
                    
                }
            }] resume];
}
-(void)cancelRequests{
    [self.operationQueue cancelAllOperations];
    for(NSURLSessionDataTask *task in self.dataTasks) {
        [task cancel];
    }
}
@end
