//
//  FCYMacros.h
//  fancy-ios
//
//  Created by Felipe Cypriano on 27/06/13.
//
//

/// ------------------
/// @name Memory Utils
/// ------------------

/**
 * Creates a weak variable of self then you should use `FCYStrongifySelfInto`
 * to get a strong reference.
 */
#define FCYWeakifySelf typeof(self) __weak _fcy_weakSelf
/**
 * Creates a strong reference of self from the previously created, using
 * `FCYWeakifySelf`, weak reference.
 *
 * @param name the name of the new strong variable
 */
#define FCYStrongifySelfInto(name) typeof(self) __strong name = _fcy_weakSelf
