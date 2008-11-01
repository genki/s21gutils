//
//  PDLRUCacheTest.m
//  PocketDiary
//
//  Created by takiuchi on 08/10/07.
//  Copyright 2008 s21g LLC. All rights reserved.
//

#import "PDLRUCacheTest.h"

@implementation PDLRUCacheTest

- (void)setUp
{
	_cache = [[PDLRUCache alloc] initWithCapacity:2];
}

- (void)tearDown
{
	[_cache release];
}

- (void)testInitialization
{
	STAssertEquals([_cache retainCount], 1U, @"the retainCount should be one.");
	STAssertEquals([_cache count], 0U, @"the count should be 0.");
}

- (void)testBasicBehaviour
{
	id key1 = [NSDate new];
	id object1 = [PDObject new];
	STAssertEquals([key1 retainCount], 1U, @"the retainCount should be 1");
	[_cache setObject:object1 forKey:key1];
	STAssertEquals([_cache count], 1U, @"the count should be 1.");
	STAssertEquals([object1 retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([key1 retainCount], 2U, @"the retainCount should be 2");
	
	id key2 = [NSDate new];
	id object2 = [PDObject new];
	[_cache setObject:object2 forKey:key2];
	[key2 release];
	STAssertEquals([key1 retainCount], 2U, @"the retainCount should be 2");
	
	id key3 = [NSDate new];
	id object3 = [PDObject new];
	[_cache setObject:object3 forKey:key3];
	[key3 release];
	STAssertEquals([_cache count], 2U, @"the count should be 2.");
	STAssertEquals([object1 retainCount], 1U, @"the retainCount should be 1");
	STAssertEquals([key1 retainCount], 1U, @"the retainCount should be 1");
	
	[_cache removeAllObjects];
	STAssertEquals([_cache count], 0U, @"the count should be 0.");
	STAssertEquals([key1 retainCount], 1U, @"the retainCount should be 1");
	[key1 release];
}

@end
