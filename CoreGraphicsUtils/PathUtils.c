//
//  PUPathUtils.c
//  Background
//
//  Created by Yevhene Shemet on 30.08.11.
//

#include "PathUtils.h"

#include <stdlib.h>

#include <math.h>

#define TAU 0.5

#pragma mark =
#pragma mark PathLength

typedef struct {
    CGPoint startPoint;
    CGFloat length;
    CGPoint lastPoint;
} PUPathLengthApplierFunctionInfo;


void PUPathElementLengthApplierFunction(void *info, const CGPathElement *element)
{
    PUPathLengthApplierFunctionInfo *pathLengthInfo = (PUPathLengthApplierFunctionInfo *)info;
    switch (element->type) {
        case kCGPathElementMoveToPoint:
            // points[0] - destination point.
            pathLengthInfo->startPoint = element->points[0];
            pathLengthInfo->lastPoint = pathLengthInfo->startPoint;
            break;
        case kCGPathElementAddLineToPoint:
            // points[0] - destination point.
            pathLengthInfo->length += PULineLength(pathLengthInfo->lastPoint,
                                                   element->points[0]);
            pathLengthInfo->lastPoint = element->points[0];
            break;
        case kCGPathElementAddQuadCurveToPoint:
            // points[0] - control point 1.
            // points[1] - destination point.
            pathLengthInfo->length += PUQuadraticBezierCurveLength(pathLengthInfo->lastPoint,
                                                                   element->points[0],
                                                                   element->points[1]);
            pathLengthInfo->lastPoint = element->points[1];
            break;
        case kCGPathElementAddCurveToPoint:
            // points[0] - control point 1.
            // points[1] - control point 2.
            // points[2] - destination point.
            pathLengthInfo->length += PUCubicBezierCurveLength(pathLengthInfo->lastPoint,
                                                               element->points[0],
                                                               element->points[1],
                                                               element->points[2]);
            pathLengthInfo->lastPoint = element->points[2];
            break;
        case kCGPathElementCloseSubpath:
            // no points.
            if (!CGPointEqualToPoint(pathLengthInfo->lastPoint,
                                     pathLengthInfo->startPoint)) {
                pathLengthInfo->length += PULineLength(pathLengthInfo->lastPoint,
                                                       pathLengthInfo->startPoint);
            }
            pathLengthInfo->lastPoint = pathLengthInfo->startPoint;
            break;
    }
}

CGFloat PUPathLength(CGPathRef path)
{
    PUPathLengthApplierFunctionInfo info;
    info.startPoint = CGPointZero;
    info.length = 0;
    info.lastPoint = CGPointZero;
    CGPathApply(path, &info, PUPathElementLengthApplierFunction);
    return info.length;
}


#pragma mark =
#pragma mark TracePath

typedef struct {
    CGPoint startPoint;
    CGFloat lengthLeft;
    CGPoint lastPoint;
    CGPoint result;
    bool isFound;
} PUTracePathApplierFunctionInfo;


void PUPathElementTraceApplierFunction(void *info, const CGPathElement *element)
{
    PUTracePathApplierFunctionInfo *tracePathInfo = (PUTracePathApplierFunctionInfo *)info;
    if (tracePathInfo->isFound) {
        return;
    }
    CGFloat pathElementLength = 0;
    switch (element->type) {
        case kCGPathElementMoveToPoint:
            // points[0] - destination point.
            tracePathInfo->startPoint = element->points[0];
            tracePathInfo->lastPoint = tracePathInfo->startPoint;
            tracePathInfo->result = tracePathInfo->lastPoint;
            break;
        case kCGPathElementAddLineToPoint:
            // points[0] - destination point.
            pathElementLength = PULineLength(tracePathInfo->lastPoint, element->points[0]);
            if (tracePathInfo->lengthLeft < pathElementLength) {
                tracePathInfo->result = PULinePoint(tracePathInfo->lengthLeft / pathElementLength,
                                                    tracePathInfo->lastPoint,
                                                    element->points[0]);
                tracePathInfo->lengthLeft = 0;
                tracePathInfo->isFound = true;
            } else {
                tracePathInfo->lastPoint = element->points[0];
                tracePathInfo->lengthLeft -= pathElementLength;
            }
            break;
        case kCGPathElementAddQuadCurveToPoint:
            // points[0] - control point 1.
            // points[1] - destination point.
            pathElementLength = PUQuadraticBezierCurveLength(tracePathInfo->lastPoint,
                                                             element->points[0],
                                                             element->points[1]);
            if (tracePathInfo->lengthLeft < pathElementLength) {
                tracePathInfo->result = PUQuadraticBezierCurvePoint(tracePathInfo->lengthLeft / pathElementLength,
                                                                    tracePathInfo->lastPoint,
                                                                    element->points[0],
                                                                    element->points[1]);
                tracePathInfo->lengthLeft = 0;
                tracePathInfo->isFound = true;
            } else {
                tracePathInfo->lastPoint = element->points[1];
                tracePathInfo->lengthLeft -= pathElementLength;
            }
            break;
        case kCGPathElementAddCurveToPoint:
            // points[0] - control point 1.
            // points[1] - control point 2.
            // points[2] - destination point.
            pathElementLength = PUCubicBezierCurveLength(tracePathInfo->lastPoint,
                                                         element->points[0],
                                                         element->points[1],
                                                         element->points[2]);
            if (tracePathInfo->lengthLeft < pathElementLength) {
                tracePathInfo->result = PUCubicBezierCurvePoint(tracePathInfo->lengthLeft / pathElementLength,
                                                                tracePathInfo->lastPoint,
                                                                element->points[0],
                                                                element->points[1],
                                                                element->points[2]);
                tracePathInfo->lengthLeft = 0;
                tracePathInfo->isFound = true;
            } else {
                tracePathInfo->lastPoint = element->points[2];
                tracePathInfo->lengthLeft -= pathElementLength;
            }
            break;
        case kCGPathElementCloseSubpath:
            // no points.
            if (!CGPointEqualToPoint(tracePathInfo->lastPoint,
                                     tracePathInfo->startPoint)) {
                pathElementLength = PULineLength(tracePathInfo->lastPoint, tracePathInfo->startPoint);
                if (tracePathInfo->lengthLeft < pathElementLength) {
                    tracePathInfo->result = PULinePoint(tracePathInfo->lengthLeft / pathElementLength,
                                                        tracePathInfo->lastPoint,
                                                        tracePathInfo->startPoint);
                    tracePathInfo->lengthLeft = 0;
                    tracePathInfo->isFound = true;
                } else {
                    tracePathInfo->lastPoint = element->points[0];
                    tracePathInfo->lengthLeft -= pathElementLength;
                }
            }
            break;
    }
}

CGPoint PUTracePath(CGPathRef path, CGFloat length)
{
    PUTracePathApplierFunctionInfo info;
    info.startPoint = CGPointZero;
    info.lengthLeft = length;
    info.lastPoint = CGPointZero;
    info.result = CGPointZero;
    info.isFound = false;
    CGPathApply(path, &info, PUPathElementTraceApplierFunction);
    return info.result;
}


#pragma mark =
#pragma mark TransformedPath

CGPathRef PUTransformPath(CGPathRef path,
                          int numberOfChunks,
                          void (^fillChunk)(CGMutablePathRef newPath, CGPoint pointFrom, CGPoint pointTo))
{
    CGMutablePathRef transformedPath = CGPathCreateMutable();
    CGPoint firstPoint = PUTracePath(path, 0);
    CGPathMoveToPoint(transformedPath, NULL, firstPoint.x, firstPoint.y);

    CGFloat pathLength = PUPathLength(path);
    CGFloat chunkLength = pathLength / numberOfChunks;
    CGPoint pointFrom = CGPointZero;
    CGPoint pointTo = firstPoint;
    for (int i = 0; i < numberOfChunks - 1; ++i) {
        pointFrom = pointTo;
        pointTo = PUTracePath(path, (i+1)*chunkLength);
        fillChunk(transformedPath, pointFrom, pointTo);
    }
    fillChunk(transformedPath, pointTo, firstPoint);
    
    return transformedPath;
}

#pragma mark =
#pragma mark Utils

CGPoint PULinePoint(double t, CGPoint from, CGPoint to)
{
    CGPoint point;
    point.x = from.x + t * (to.x - from.x);
    point.y = from.y + t * (to.y - from.y);
    return point;
}

CGPoint PUQuadraticBezierCurvePoint(double t, CGPoint from, CGPoint control, CGPoint to)
{
    CGPoint point;
    point.x = pow(1-t, 2)*from.x + 2*(1-t)*t*control.x + pow(t, 2)*to.x;
    point.y = pow(1-t, 2)*from.y + 2*(1-t)*t*control.y + pow(t, 2)*to.y;
    return point;
}

CGPoint PUCubicBezierCurvePoint(double t, CGPoint from, CGPoint control1, CGPoint control2, CGPoint to)
{
    CGPoint point;
    point.x = pow(1-t, 3)*from.x + 3*pow(1-t, 2)*t*control1.x + 3*(1-t)*pow(t, 2)*control2.x + pow(t, 3)*to.x;
    point.y = pow(1-t, 3)*from.y + 3*pow(1-t, 2)*t*control1.y + 3*(1-t)*pow(t, 2)*control2.y + pow(t, 3)*to.y;
    return point;
}

CGFloat PULineLength(CGPoint from, CGPoint to)
{
    return sqrt(pow((to.x - from.x), 2) +
                pow((to.y - from.y), 2));
}

CGFloat PUFunctionLength(CGPoint (^f)(double), double tStep)
{
    CGFloat length = 0;
    
    CGPoint point0;
    CGPoint point1 = f(0);
    
    for (double t = 0; t <= 1; t += tStep) {
        point0 = point1;
        point1 = f(t);
        length += PULineLength(point0, point1);
    }
    
    return length;
}

CGFloat PUQuadraticBezierCurveLength(CGPoint from, CGPoint control, CGPoint to)
{
    float length = PUFunctionLength(^CGPoint(double t) {
        return PUQuadraticBezierCurvePoint(t, from, control, to);
    }, 0.001);
    
    return length;
}

CGFloat PUCubicBezierCurveLength(CGPoint from, CGPoint control1, CGPoint control2, CGPoint to)
{
    float length = PUFunctionLength(^CGPoint(double t) {
        return PUCubicBezierCurvePoint(t, from, control1, control2, to);
    }, 0.001);
    
    return length;
}


// Approximation from: http://segfaultlabs.com/docs/quadratic-bezier-curve-length
/*CGFloat QuadraticBezierCurveLength(CGPoint from, CGPoint control, CGPoint to)
 {
 CGPoint a,b;
 a.x = from.x - 2*control.x + to.x;
 a.y = from.y - 2*control.y + to.y;
 b.x = 2*control.x - 2*from.x;
 b.y = 2*control.y - 2*from.y;
 float A = 4*(a.x*a.x + a.y*a.y);
 float B = 4*(a.x*b.x + a.y*b.y);
 float C = b.x*b.x + b.y*b.y;
 
 float length = ( (2*A+B)*sqrt(A+B+C) - B*sqrt(C) )/( 4 * A ) +
 ( 4*A*C-B*B) / (8*pow(A, 3.0/2.0) ) * log( (2*A+B+2*sqrt(A)*sqrt(A+B+C)) / (B+2*sqrt(A*C)) );
 
 return length;
 }*/