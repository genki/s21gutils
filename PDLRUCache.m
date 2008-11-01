//
//  PDLRUCache.m
//  PocketDiary
//
//  Created by takiuchi on 08/10/06.
//  Copyright 2008 s21g LLC. All rights reserved.
//

#import "PDLRUCache.h"
#import "PDLinkedList.h"

NSString * const kPDLRUCacheCacheOutNotification = @"PDLRUCacheCacheOutNotification";

@implementation PDLRUCache

- (id)
initWithCapacity:(NSUInteger)capacity
{
	if(![super init]) return self;
	_cache = [[NSMutableDictionary alloc] initWithCapacity:capacity];
	if(!_cache){
		[self dealloc];
		return nil;
	}
	_pointer = [[NSMutableDictionary alloc] initWithCapacity:capacity];
	if(!_pointer){
		[self dealloc];
		return nil;
	}
	_list = [PDLinkedList new];
	if(!_list){
		[self dealloc];
		return nil;
	}
	_capacity = capacity;
	return self;
}

- (void)
updateObject:(id<PDIdentity>)object
andKey:(id)key
{
	id objectKey = [object identifier];
	PDLinkedListNode *node = [_pointer objectForKey:objectKey];
	if(node) [_list remove:node];
	node = [_list push:key];
	[_pointer setObject:node forKey:objectKey];
}

- (void)
willCacheOutObject:(id)object
{
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	NSMutableDictionary *userInfo = [NSMutableDictionary new];
	[userInfo setObject:object forKey:@"object"];
	[center postNotificationName:kPDLRUCacheCacheOutNotification object:self userInfo:userInfo];
	[userInfo release];
}

- (id)
objectForKey:(id)key
{
	id object = [_cache objectForKey:key];
	if(object){
		[self updateObject:object andKey:key];
	}
	return object;
}

- (void)
setObject:(id<PDIdentity>)object
forKey:(id)key
{
	if([_cache count] == _capacity){
		id keyLRU = [_list shift];
		id keyObject = [_cache objectForKey:keyLRU];
		[self willCacheOutObject:keyObject];
		[_pointer removeObjectForKey:[keyObject identifier]];
		[_cache removeObjectForKey:keyLRU];
		[keyLRU release];
	}
	[self updateObject:object andKey:key];
	[_cache setObject:object forKey:key];
}

- (void)removeAllObjects
{
	for(id key in _list){
		[self willCacheOutObject:[_cache objectForKey:key]];
	}
	[_list clear];
	[_pointer removeAllObjects];
	[_cache removeAllObjects];
}

- (NSUInteger)count
{
	return [_cache count];
}

- (void)dealloc
{
	[self removeAllObjects];
	[_list release];
	[_pointer release];
	[_cache release];
	[super dealloc];
}

@end
