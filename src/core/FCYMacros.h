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
#define FCYWeakifySelf typeof(self) __weak _fcy_weakSelf = self
/**
 * Creates a strong reference of self from the previously created, using
 * `FCYWeakifySelf`, weak reference.
 *
 * @param name the name of the new strong variable
 */
#define FCYStrongifySelfInto(name) typeof(self) __strong name = _fcy_weakSelf

// ## Private Macros ##
// These __STR_BUILD* macros are a trick to build a string literal to _Pragma
// Source: http://stackoverflow.com/a/8724905/335974
#define __STR_BUILD0(name) #name
#define __STR_BUILD1(name) __STR_BUILD0(clang diagnostic ignored name)
#define __STR_BUILD2(name) __STR_BUILD1(#name)
// ## Private Macros ##

/**
 * Creates a `clang diagnostics push/ignore/pop` around the code
 *
 * Usage example:
 *     FCYSupressWarning(-Wunused-value, {
 *         [[NSObject alloc] init];
 *     });
 *
 * @param warningName this is the warning to ignore. E.g.: -Wunused-value
 * @param code the statement(s) that the ignore will be around
 */
#define FCYSuppressWarning(warningName, code) \
_Pragma("clang diagnostic push") \
_Pragma(__STR_BUILD2(warningName)) \
do { \
    code \
} while (0); \
_Pragma("clang diagnostic pop")
