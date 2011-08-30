//
//  PUPathUtils.h
//  PathUtils
//
//  Created by Yevhene Shemet on 30.08.11.
//

#ifndef PUPathUtils_h
#define PUPathUtils_h

#include <CoreGraphics/CoreGraphics.h>

/*
 * Returns path length.
 */
CGFloat PUPathLength(CGPathRef path);

/*
 * Returns point from path.
 */
CGPoint PUTracePath(CGPathRef path, CGFloat length);

/*
 * Returns new path, transformed by fillChunk.
 */
CGPathRef PUTransformPath(CGPathRef path,
                          int numberOfChunks,
                          void (^fillChunk)(CGMutablePathRef newPath, CGPoint pointFrom, CGPoint pointTo));

// Utils
CGPoint PULinePoint(double t, CGPoint from, CGPoint to);

CGPoint PUQuadraticBezierCurvePoint(double t, CGPoint from, CGPoint control, CGPoint to);

CGPoint PUCubicBezierCurvePoint(double t, CGPoint from, CGPoint control1, CGPoint control2, CGPoint to);


CGFloat PULineLength(CGPoint from, CGPoint to);

CGFloat PUQuadraticBezierCurveLength(CGPoint from, CGPoint control, CGPoint to);

CGFloat PUCubicBezierCurveLength(CGPoint from, CGPoint control1, CGPoint control2, CGPoint to);

#endif