//
//  PDObject.m
//  PocketDiary
//
//  Created by takiuchi on 08/10/09.
//  Copyright 2008 s21g LLC. All rights reserved.
//

#import "PDObject.h"

@implementation PDObject

- (id)identifier
{
	return [NSValue valueWithPointer:self];
}

@end
