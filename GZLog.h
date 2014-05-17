/*
 *  GZLog.h
 *  GZLog
 *
 *  Created by CHUL HYUN LEE on 08. 11. 08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#define GZ_DEBUG
#ifdef GZ_DEBUG

#define GZLogFunc0() do{ \
NSLog(@"%s(%d)",__func__,__LINE__); \
}while(0)

#define GZLogFunc1(a) do{ \
NSLog(@"%s(%d) %@",__func__,__LINE__,a); \
}while(0)

#define GZLogFunc(format,...) do{ \
NSLog(@"%s(%d) " format,__func__,__LINE__,__VA_ARGS__); \
}while(0)

#define GZLogRetainCount(obj) do{ \
NSLog(@"%s(%d) retainCount:%d",__func__,__LINE__,[obj retainCount]); \
}while(0)

#if 0
#define GZLogFile(format,...) do{ \
NSString* str1 = [[NSString alloc] initWithFormat:@"%s",__FILE__]; \
NSString* str2 = [str1 lastPathComponent]; \
NSLog(str2); \
NSLog(@"(%d) " format,__LINE__,__VA_ARGS__); \
[str1 release]; \
}while(0)
#endif
#else

#define GZLogFunc0()
#define GZLogFunc1(a)
#define GZLogFunc(format,...)
#define GZLogRetainCount(obj)
//#define GZLogFile(format,...)

#endif
