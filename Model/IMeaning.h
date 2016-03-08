//
//  IMeaning.h
//  Initialism
//
//  Created by Anurag on 3/8/16.
//  Copyright © 2016 Anurag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMeaning : NSObject
@property (nonatomic, copy) NSString *meaning;
@property NSInteger frequency;
@property NSInteger since;
@property (nonatomic, copy) NSMutableArray *variations;
@end
