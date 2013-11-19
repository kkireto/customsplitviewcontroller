//
//  Globals.m
//  CustomSplitViewControll
//
//  Created by Kireto on 12/14/12.
//  Copyright (c) 2012 No Name. All rights reserved.
//

#import "Globals.h"

@implementation Globals


+ (float)osVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)isOSVerionGreaterThanOrEqualTo:(float)compareValue; {
    return ([Globals osVersion] >= compareValue);
}

@end
