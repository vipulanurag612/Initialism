//
//  NetworkClient.h
//  Initialism
//
//  Created by Anurag on 3/8/16.
//  Copyright © 2016 Anurag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "IAcronym.h"

#import "AFHTTPSessionManager.h"
#import "IAcronym.h"


typedef void (^ServiceSuccessBlock)(NSURLSessionDataTask *task, IAcronym *acronym);
typedef void (^ServiceFailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface NetworkClient : AFHTTPSessionManager

+(NetworkClient *) sharedManager;

/*
 * This method makes a GET request to the given URL.
*/
- (void)getResponseForURLString: (NSString *)urlString Parameters:(NSDictionary *) parameters success:(ServiceSuccessBlock) success failure:(ServiceFailureBlock) failure;

@end
