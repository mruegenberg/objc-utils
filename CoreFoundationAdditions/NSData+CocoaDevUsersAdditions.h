// From http://www.cocoadev.com/index.pl?NSDataCategory

#import <Foundation/Foundation.h>


@interface NSData (NSDataExtension)

/*
 Returns range [start, null byte), or (NSNotFound, 0).
 */
- (NSRange) rangeOfNullTerminatedBytesFrom:(int)start;

/*
 Canonical Base32 encoding/decoding.
 */
+ (NSData *) dataWithBase32String:(NSString *)base32;
- (NSString *) base32String;

// ZLIB
- (NSData *) zlibInflate;
- (NSData *) zlibDeflate;

// GZIP
// Decompress
- (NSData *) gzipInflate;

//Compress
- (NSData *) gzipDeflate;

@end
