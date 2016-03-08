//
//  IDetailViewController.h
//  Initialism
//
//  Created by Anurag on 3/8/16.
//  Copyright © 2016 Anurag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMeaning.h"

@interface IDetailViewController : UIViewController
@property (nonatomic,strong) IMeaning *meaning;
@end
