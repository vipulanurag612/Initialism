//
//  NetworkClient.m
//  Initialism
//
//  Created by Anurag on 3/8/16.
//  Copyright © 2016 Anurag. All rights reserved.
//

#import "NetworkClient.h"
#import "NetworkClient.h"
#import "IMeaning.h"

@implementation NetworkClient

+(NetworkClient *) sharedManager {
    
    static NetworkClient *sharedManager = nil;
    static dispatch_once_t once ;
    dispatch_once(&once, ^{
        sharedManager = [[NetworkClient alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (void)getResponseForURLString: (NSString *)urlString Parameters:(NSDictionary *) parameters success:(ServiceSuccessBlock) success failure:(ServiceFailureBlock) failure
{
    
    /*
     These are the accepted content types in AFURLResponseSerialization.
     @"application/json", @"text/json", @"text/javascript"
     
     But below api is sending "Content-Type" = "text/plain;
     http://www.nactem.ac.uk/software/acromine/dictionary.py
     */
    // Below line is to accept response of any type
    // Better solution is to ask the Server to send content type as "application/json"
    self.responseSerializer.acceptableContentTypes = nil;
    
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
        if (success) {
            success(task, [self parseResponseObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

#pragma mark- Simple JSON to Object mapper methods

/*
 * Below helper methods for object mapping are more Service specific.
 * For large set of services, better implement a generic solution.
 */

-(IAcronym *) parseResponseObject:(id) responseObject {
    
    if([responseObject isKindOfClass:[NSArray class]] && [responseObject count] > 0 ){
        for(NSDictionary *dict in responseObject){
            
            // even though response object is of type array, we are just capturing 1st object as the response of this web service always has just one object for acronym and its corresponding meanings.
            
            IAcronym *acronym = [[IAcronym alloc] init];
            [acronym setShortForm: [dict objectForKey:@"sf"]] ;
            [acronym setMeanings:[self getMeanings:[dict objectForKey:@"lfs"]]];
            return acronym;
        }
        
    }
    return nil;
}

-(NSMutableArray *) getMeanings:(NSMutableArray *) responseArray {
    NSMutableArray *meaningArray = [NSMutableArray array];
    for(NSDictionary *dict in responseArray){
        
        IMeaning *meaning = [[IMeaning alloc] init];
        [meaning setMeaning: [dict objectForKey:@"lf"]] ;
        [meaning setFrequency: [[dict objectForKey:@"freq"] integerValue]] ;
        [meaning setSince: [[dict objectForKey:@"since"] integerValue]] ;
        [meaning setVariations:[self getVariations:[dict objectForKey:@"vars"]]];
        [meaningArray addObject:meaning];
    }
    return meaningArray;
}

-(NSMutableArray *) getVariations:(NSMutableArray *) responseArray {
    NSMutableArray *variationsArray = [NSMutableArray array];
    for(NSDictionary *dict in responseArray){
        
        IMeaning *meaning = [[IMeaning alloc] init];
        [meaning setMeaning: [dict objectForKey:@"lf"]] ;
        [meaning setFrequency: [[dict objectForKey:@"freq"] integerValue]] ;
        [meaning setSince: [[dict objectForKey:@"since"] integerValue]] ;
        
        [variationsArray addObject:meaning];
    }
    return variationsArray;
}


@end
