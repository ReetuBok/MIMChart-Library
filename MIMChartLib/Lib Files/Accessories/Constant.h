typedef enum
{
    USERDEFINED=1,
    REDTINT,
    GREENTINT,
    BEIGETINT
    
}TINTCOLOR;



typedef enum
{
    GTYPE_USERDEFINED,
    GTYPE_DEFAULT,
    GTYPE_RADIAL,
    GTYPE_HLINEAR,
    GTYPE_VLINEAR,
    GTYPE_ALINEAR //AT SOME ANGLE BUT ITS LINEAR
    
}GRADIENTTYPE;


typedef enum
{
    ALIGNMENT_CENTER,
    ALIGNMENT_LEFT,
    ALIGNMENT_RIGHT,
    ALIGNMENT_TOP,
    ALIGNMENT_BOTTOM,
    
}ALIGNMENT;

typedef enum
{
    DIRECTION_LEFT,
    DIRECTION_RIGHT,
    DIRECTION_TOP,
    DIRECTION_BOTTOM,
    
}DIRECTION;




typedef enum
{
    mPIE_DETAIL_POPUP_TYPE1=1,
    mPIE_DETAIL_POPUP_TYPE2,
    mPIE_DETAIL_POPUP_TYPE3,
    mPIE_DETAIL_POPUP_TYPE4,
    mPIE_DETAIL_POPUP_TYPE5,
    mPIE_DETAIL_POPUP_USERDEFINED,
    
}PIE_DETAIL_POPUP_TYPE;


typedef enum
{
    POPUP_ARROW_WHITE=1,
    POPUP_ARROW_BLACK,
    
}POPUP_ARROW_TINT_STYLE;


typedef enum
{
    INFOBOX_STYLE1=1, // Default one without interaction
    INFOBOX_STYLE2,//Rotation of pie and translation of info box up and down
    INFOBOX_STYLE3,//Selected Pie becomes bigger and related label in info box flashes and highlights
    
}INFOBOX_STYLE;


typedef enum
{
    mPIE_BUBBLE_STYLE1=1,//Square
    mPIE_BUBBLE_STYLE2,//Circle
    mPIE_BUBBLE_STYLE3,//Square translates from Pie
    mPIE_BUBBLE_STYLE4,//Circle translates from Pie
    mPIE_BUBBLE_STYLE5,//Square fades In
    mPIE_BUBBLE_STYLE6,//Circle fades In
    mPIE_BUBBLE_STYLE7,//Show all by default.//User can hide them - fade them out
    //Later we can add more effects in disappearing/appearing
    
}PIE_BUBBLE_STYLE;



typedef enum
{
    X_TITLES_STYLE1=1, 
    X_TITLES_STYLE2,
    X_TITLES_STYLE3,
    X_TITLES_STYLE4,
}X_TITLES_STYLE;


typedef enum
{
    WALL_PATTERN_STYLE1=1, 
    WALL_PATTERN_STYLE2,
    WALL_PATTERN_STYLE3,
    WALL_PATTERN_STYLE4,
    WALL_PATTERN_STYLE5,
}WALL_PATTERN_STYLE;



typedef enum
{
    BAR_ANIMATION_VGROW_STYLE=1, 
    
}BAR_ANIMATION_STYLE;


