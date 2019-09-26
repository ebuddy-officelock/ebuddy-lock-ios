//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

#import "UIFont+OWS.h"
#import <SignalCoreKit/iOSVersions.h>

NS_ASSUME_NONNULL_BEGIN

@implementation UIFont (OWS)

//+ (UIFont *)ows_thinFontWithSize:(CGFloat)size
//{
//    return [UIFont fontWithName:@"Inter-Thin" size:size];
//}

+ (UIFont *)ows_lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Inter-Light" size:size];
}

+ (UIFont *)ows_regularFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Inter-Regular" size:size];
}

+ (UIFont *)ows_italicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Inter-Italic" size:size];
}

+ (UIFont *)ows_mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Inter-Medium" size:size];
}

+ (UIFont *)ows_semiBoldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Inter-SemiBold" size:size];
}

//+ (UIFont *)ows_semiBoldItalicFontWithSize:(CGFloat)size
//{
//    return [UIFont fontWithName:@"Inter-SemiBoldItalic" size:size];
//}

+ (UIFont *)ows_boldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Inter-Bold" size:size];
}

//+ (UIFont *)ows_boldItalicFontWithSize:(CGFloat)size
//{
//    return [UIFont fontWithName:@"Inter-BoldItalic" size:size];
//}

#pragma mark - Icon Fonts

+ (UIFont *)ows_fontAwesomeFont:(CGFloat)size
{
    return [UIFont fontWithName:@"FontAwesome" size:size];
}

+ (UIFont *)ows_dripIconsFont:(CGFloat)size
{
    return [UIFont fontWithName:@"dripicons-v2" size:size];
}

+ (UIFont *)ows_elegantIconsFont:(CGFloat)size
{
    return [UIFont fontWithName:@"ElegantIcons" size:size];
}

#pragma mark - Dynamic Type

+ (UIFont *)dynamicCustomFontWithTextStyle:(UIFontTextStyle)style withSize:(CGFloat)size andWeight:(UIFontWeight)weight {
    
    UIFont *customFont = [UIFont fontWithName:@"Inter-Regular" size:size];
    if (weight == UIFontWeightBold || weight == UIFontWeightBlack || weight == UIFontWeightHeavy) {
        customFont = [UIFont fontWithName:@"Inter-Bold" size:size];
    } else if (weight == UIFontWeightMedium || weight == UIFontWeightSemibold) {
        customFont = [UIFont fontWithName:@"Inter-SemiBold" size:size];
    } else {
        customFont = [UIFont fontWithName:@"Inter-Regular" size:size];
    }
    
    if (@available(iOS 11.0, *)) {
        UIFontMetrics *metrics = [UIFontMetrics metricsForTextStyle:style];
        return [metrics scaledFontForFont:customFont];
    } else {
        return [UIFont preferredFontForTextStyle:style];
    }
}

+ (UIFont *)ows_dynamicTypeTitle1Font
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleTitle1 withSize:28 andWeight:UIFontWeightBold];
}

+ (UIFont *)ows_dynamicTypeTitle2Font
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleTitle2 withSize:22 andWeight:UIFontWeightBold];
}

+ (UIFont *)ows_dynamicTypeTitle3Font
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleTitle3 withSize:20 andWeight:UIFontWeightBold];
}

+ (UIFont *)ows_dynamicTypeHeadlineFont
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleHeadline withSize:17 andWeight:UIFontWeightMedium];
}

+ (UIFont *)ows_dynamicTypeBodyFont
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleHeadline withSize:16 andWeight:UIFontWeightRegular];
}

+ (UIFont *)ows_dynamicTypeSubheadlineFont
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleHeadline withSize:14 andWeight:UIFontWeightRegular];
}

+ (UIFont *)ows_dynamicTypeFootnoteFont
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleHeadline withSize:13 andWeight:UIFontWeightRegular];
}

+ (UIFont *)ows_dynamicTypeCaption1Font
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleHeadline withSize:12 andWeight:UIFontWeightRegular];
}

+ (UIFont *)ows_dynamicTypeCaption2Font
{
    return [UIFont dynamicCustomFontWithTextStyle:UIFontTextStyleHeadline withSize:11 andWeight:UIFontWeightRegular];
}

#pragma mark - Dynamic Type Clamped

+ (NSNumber *)maxPointSizeForTextStyle:(UIFontTextStyle)style {
    static NSDictionary<UIFontTextStyle, NSNumber *> *maxPointSizeMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary<UIFontTextStyle, NSNumber *> *map = [@{
                                                                   UIFontTextStyleTitle1 : @(34.0),
                                                                   UIFontTextStyleTitle2 : @(28.0),
                                                                   UIFontTextStyleTitle3 : @(26.0),
                                                                   UIFontTextStyleHeadline : @(23.0),
                                                                   UIFontTextStyleBody : @(23.0),
                                                                   UIFontTextStyleSubheadline : @(21.0),
                                                                   UIFontTextStyleFootnote : @(19.0),
                                                                   UIFontTextStyleCaption1 : @(18.0),
                                                                   UIFontTextStyleCaption2 : @(17.0),
                                                                   } mutableCopy];
        if (@available(iOS 11.0, *)) {
            map[UIFontTextStyleLargeTitle] = @(40.0);
        }
        maxPointSizeMap = map;
    });
    
    NSNumber *_Nullable maxPointSize = maxPointSizeMap[style];
    return maxPointSize;
}

+ (NSNumber *)regularPointSizeForTextStyle:(UIFontTextStyle)style {
    static NSDictionary<UIFontTextStyle, NSNumber *> *regularPointSizeMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary<UIFontTextStyle, NSNumber *> *map = [@{
                                                                   UIFontTextStyleTitle1 : @(28.0),
                                                                   UIFontTextStyleTitle2 : @(22.0),
                                                                   UIFontTextStyleTitle3 : @(20.0),
                                                                   UIFontTextStyleHeadline : @(17.0),
                                                                   UIFontTextStyleBody : @(16.0),
                                                                   UIFontTextStyleSubheadline : @(14.0),
                                                                   UIFontTextStyleFootnote : @(13.0),
                                                                   UIFontTextStyleCaption1 : @(12.0),
                                                                   UIFontTextStyleCaption2 : @(11.0),
                                                                   } mutableCopy];
        
        if (@available(iOS 11.0, *)) {
            map[UIFontTextStyleLargeTitle] = @(32.0);
        }
        
        regularPointSizeMap = map;
    });
    
    NSNumber *_Nullable regularPointSize = regularPointSizeMap[style];
    return regularPointSize;
}

+ (UIFont *)preferredFontForTextStyleClamped:(UIFontTextStyle)fontTextStyle
{
    // We clamp the dynamic type sizes at the max size available
    // without "larger accessibility sizes" enabled.
    NSNumber *maxPointSize = [self maxPointSizeForTextStyle:fontTextStyle];
    NSNumber *regularPointSize = [self regularPointSizeForTextStyle:fontTextStyle];
    UIFont *font = [UIFont dynamicCustomFontWithTextStyle:fontTextStyle withSize:regularPointSize.floatValue andWeight:UIFontWeightRegular];
    
    if (maxPointSize) {
        if (maxPointSize.floatValue < font.pointSize) {
            return [font fontWithSize:maxPointSize.floatValue];
        }
    } else {
        OWSFailDebug(@"Missing max point size for style: %@", fontTextStyle);
    }
    return font;
}

+ (UIFont *)ows_dynamicTypeLargeTitle1ClampedFont
{
    if (@available(iOS 11.0, *)) {
        return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleLargeTitle];
    } else {
        return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleTitle1];
    }
}

+ (UIFont *)ows_dynamicTypeTitle1ClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleTitle1];
}

+ (UIFont *)ows_dynamicTypeTitle2ClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleTitle2];
}

+ (UIFont *)ows_dynamicTypeTitle3ClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleTitle3];
}

+ (UIFont *)ows_dynamicTypeHeadlineClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleHeadline];
}

+ (UIFont *)ows_dynamicTypeBodyClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleBody];
}

+ (UIFont *)ows_dynamicTypeSubheadlineClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleSubheadline];
}

+ (UIFont *)ows_dynamicTypeFootnoteClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleFootnote];
}

+ (UIFont *)ows_dynamicTypeCaption1ClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleCaption1];
}

+ (UIFont *)ows_dynamicTypeCaption2ClampedFont
{
    return [UIFont preferredFontForTextStyleClamped:UIFontTextStyleCaption2];
}

#pragma mark - Styles

- (UIFont *)ows_italic
{
    //TODO - Fix that it also takes weight into account
    UIFont *italicFont = [UIFont ows_italicFontWithSize:self.pointSize];
    return italicFont;
}

- (UIFont *)ows_bold
{
    return  [UIFont ows_boldFontWithSize:self.pointSize];
}

- (UIFont *)styleWithSymbolicTraits:(UIFontDescriptorSymbolicTraits)symbolicTraits
{
    UIFontDescriptor *fontDescriptor = [self.fontDescriptor fontDescriptorWithSymbolicTraits:symbolicTraits];
    UIFont *font = [UIFont fontWithDescriptor:fontDescriptor size:0];
    OWSAssertDebug(font);
    return font ?: self;
}

- (UIFont *)ows_mediumWeight
{
    // The recommended approach of deriving "medium" weight fonts for dynamic
    // type fonts is:
    //
    // [UIFontDescriptor fontDescriptorByAddingAttributes:...]
    //
    // But this doesn't seem to work in practice on iOS 11 using UIFontWeightMedium.

    UIFont *derivedFont = [UIFont ows_semiBoldFontWithSize:self.pointSize];
    return derivedFont;
}

@end

NS_ASSUME_NONNULL_END
