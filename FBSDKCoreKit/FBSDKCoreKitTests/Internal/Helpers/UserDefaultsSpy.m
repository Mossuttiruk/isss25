// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "UserDefaultsSpy.h"

#import <FBSDKCoreKit_Basics/FBSDKCoreKit_Basics.h>

@implementation UserDefaultsSpy

+ (instancetype)new
{
  return [[UserDefaultsSpy alloc] init];
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _capturedValues = [NSDictionary dictionary];
    _stringForKeyCallback = ^(NSString *key) { return key; };
  }

  return self;
}

- (NSString *)stringForKey:(NSString *)defaultName
{
  return _stringForKeyCallback(defaultName);
}

- (id)objectForKey:(NSString *)defaultName
{
  _capturedObjectRetrievalKey = defaultName;
  return [_capturedValues objectForKey:defaultName];
}

- (void)setObject:(id)value forKey:(NSString *)defaultName
{
  NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithDictionary:_capturedValues];

  if (value) {
    [FBSDKTypeUtility dictionary:tmp setObject:value forKey:defaultName];
  } else {
    [tmp removeObjectForKey:defaultName];
  }

  _capturedValues = tmp;
  _capturedSetObjectKey = defaultName;
}

@end
