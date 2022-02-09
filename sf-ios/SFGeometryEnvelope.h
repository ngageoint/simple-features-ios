//
//  SFGeometryEnvelope.h
//  sf-ios
//
//  Created by Brian Osborn on 6/1/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Geometry envelope containing x and y range with optional z and m range
 */
@interface SFGeometryEnvelope : NSObject <NSMutableCopying, NSCoding>

/**
 *  X coordinate range
 */
@property (nonatomic, strong) NSDecimalNumber *minX;
@property (nonatomic, strong) NSDecimalNumber *maxX;

/**
 *  Y coordinate range
 */
@property (nonatomic, strong) NSDecimalNumber *minY;
@property (nonatomic, strong) NSDecimalNumber *maxY;

/**
 * Has Z value and Z coordinate range
 */
@property (nonatomic) BOOL hasZ;
@property (nonatomic, strong) NSDecimalNumber *minZ;
@property (nonatomic, strong) NSDecimalNumber *maxZ;

/**
 *  Has M value and M coordinate range
 */
@property (nonatomic) BOOL hasM;
@property (nonatomic, strong) NSDecimalNumber *minM;
@property (nonatomic, strong) NSDecimalNumber *maxM;

/**
 *  Initialize with no z or m
 *
 *  @return new instance
 */
-(instancetype) init;

/**
 *  Initialize with the has z and m values
 *
 *  @param hasZ geometry has z
 *  @param hasM geometry has m
 *
 *  @return new geometry envelope
 */
-(instancetype) initWithHasZ: (BOOL) hasZ andHasM: (BOOL) hasM;

/**
 *  Initialize with number range
 *
 *  @param minX minimum x
 *  @param minY minimum y
 *  @param maxX maximum x
 *  @param maxY maximum y
 *
 *  @return new geometry envelope
 */
-(instancetype) initWithMinX: (NSDecimalNumber *) minX
                      andMinY: (NSDecimalNumber *) minY
                     andMaxX: (NSDecimalNumber *) maxX
                      andMaxY: (NSDecimalNumber *) maxY;

/**
 *  Initialize with double range
 *
 *  @param minX minimum x
 *  @param minY minimum y
 *  @param maxX maximum x
 *  @param maxY maximum y
 *
 *  @return new geometry envelope
 */
-(instancetype) initWithMinXDouble: (double) minX
                      andMinYDouble: (double) minY
                     andMaxXDouble: (double) maxX
                      andMaxYDouble: (double) maxY;

/**
 *  Initialize with number range
 *
 *  @param minX minimum x
 *  @param minY minimum y
 *  @param minZ minimum z
 *  @param maxX maximum x
 *  @param maxY maximum y
 *  @param maxZ maximum z
 *
 *  @return new geometry envelope
 */
-(instancetype) initWithMinX: (NSDecimalNumber *) minX
                     andMinY: (NSDecimalNumber *) minY
                     andMinZ: (NSDecimalNumber *) minZ
                     andMaxX: (NSDecimalNumber *) maxX
                     andMaxY: (NSDecimalNumber *) maxY
                     andMaxZ: (NSDecimalNumber *) maxZ;

/**
 *  Initialize with number range
 *
 *  @param minX minimum x
 *  @param minY minimum y
 *  @param minZ minimum z
 *  @param minM minimum m
 *  @param maxX maximum x
 *  @param maxY maximum y
 *  @param maxZ maximum z
 *  @param maxM maximum m
 *
 *  @return new geometry envelope
 */
-(instancetype) initWithMinX: (NSDecimalNumber *) minX
                     andMinY: (NSDecimalNumber *) minY
                     andMinZ: (NSDecimalNumber *) minZ
                     andMinM: (NSDecimalNumber *) minM
                     andMaxX: (NSDecimalNumber *) maxX
                     andMaxY: (NSDecimalNumber *) maxY
                     andMaxZ: (NSDecimalNumber *) maxZ
                     andMaxM: (NSDecimalNumber *) maxM;

/**
 * True if has Z coordinates
 *
 * @return has z
 */
-(BOOL) is3D;

/**
 * True if has M measurements
 *
 * @return has m
 */
-(BOOL) isMeasured;

/**
 * Get the x range
 *
 * @return x range
 */
-(double) xRange;

/**
 * Get the y range
 *
 * @return y range
 */
-(double) yRange;

/**
 * Get the z range
 *
 * @return z range
 */
-(NSDecimalNumber *) zRange;

/**
 * Get the m range
 *
 * @return m range
 */
-(NSDecimalNumber *) mRange;

/**
 * Determine if the envelope is of a single point
 *
 * @return true if a single point bounds
 */
-(BOOL) isPoint;

/**
 * Determine if intersects with the provided envelope
 *
 * @param envelope
 *            geometry envelope
 * @return true if intersects
 */
-(BOOL) intersectsWithEnvelope: (SFGeometryEnvelope *) envelope;

/**
 * Determine if intersects with the provided envelope
 *
 * @param envelope
 *            geometry envelope
 * @param allowEmpty
 *            allow empty ranges when determining intersection
 * @return true if intersects
 */
-(BOOL) intersectsWithEnvelope: (SFGeometryEnvelope *) envelope withAllowEmpty: (BOOL) allowEmpty;

/**
 * Get the overlapping geometry envelope with the provided envelope
 *
 * @param envelope
 *            geometry envelope
 * @return geometry envelope
 */
-(SFGeometryEnvelope *) overlapWithEnvelope: (SFGeometryEnvelope *) envelope;

/**
 * Get the overlapping geometry envelope with the provided envelope
 *
 * @param envelope
 *            geometry envelope
 * @param allowEmpty
 *            allow empty ranges when determining overlap
 * @return geometry envelope
 */
-(SFGeometryEnvelope *) overlapWithEnvelope: (SFGeometryEnvelope *) envelope withAllowEmpty: (BOOL) allowEmpty;

/**
 * Get the union geometry envelope combined with the provided envelope
 *
 * @param envelope
 *            geometry envelope
 * @return geometry envelope
 */
-(SFGeometryEnvelope *) unionWithEnvelope: (SFGeometryEnvelope *) envelope;

/**
 * Determine if inclusively contains the provided envelope
 *
 * @param envelope
 *            geometry envelope
 * @return true if contains
 */
-(BOOL) containsEnvelope: (SFGeometryEnvelope *) envelope;

@end
