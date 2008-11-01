//
//  PDLRUCache.h
//  PocketDiary
//
//  Created by takiuchi on 08/10/06.
//  Copyright 2008 s21g LLC. All rights reserved.
//

#import "PDObject.h"

extern NSString * const kPDLRUCacheCacheOutNotification;

@class PDLinkedList;

@interface PDLRUCache : NSObject
{	
	PDLinkedList *_list;
	NSMutableDictionary *_cache;
	NSMutableDictionary *_pointer;
	NSUInteger _capacity;
}

- (id)initWithCapacity:(NSUInteger)capacity;
- (id)objectForKey:(id)key;
- (void)setObject:(id<PDIdentity>)object forKey:(id)key;
- (void)removeAllObjects;
- (NSUInteger)count;

@end
