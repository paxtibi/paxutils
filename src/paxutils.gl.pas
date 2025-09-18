unit paxutils.gl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, paxutils;

const
  {$IFDEF LINUX}
 libGL  = 'libGL';
 libGLU = 'libGLU';
  {$ENDIF}
  {$IFDEF WINDOWS}
 libGL  = 'opengl32';
 libGLU = 'glu32';
  {$ENDIF}


type
  GLenum = cardinal;
  PGLenum = ^GLenum;
  GLboolean = byte;
  PGLboolean = ^GLboolean;
  GLbitfield = cardinal;
  PGLbitfield = ^GLbitfield;
  GLbyte = shortint;
  PGLbyte = ^GLbyte;
  GLshort = smallint;
  PGLshort = ^GLshort;
  GLint = integer;
  PGLint = ^GLint;
  GLsizei = integer;
  PGLsizei = ^GLsizei;
  GLubyte = byte;
  PGLubyte = ^GLubyte;
  GLushort = word;
  PGLushort = ^GLushort;
  GLuint = cardinal;
  PGLuint = ^GLuint;
  GLfloat = single;
  PGLfloat = ^GLfloat;
  GLclampf = single;
  PGLclampf = ^GLclampf;
  GLdouble = double;
  PGLdouble = ^GLdouble;
  GLclampd = double;
  PGLclampd = ^GLclampd;
  { GLvoid     = void; }        PGLvoid = Pointer;
  PPGLvoid = ^PGLvoid;

  TGLenum = GLenum;
  TGLboolean = GLboolean;
  TGLbitfield = GLbitfield;
  TGLbyte = GLbyte;
  TGLshort = GLshort;
  TGLint = GLint;
  TGLsizei = GLsizei;
  TGLubyte = GLubyte;
  TGLushort = GLushort;
  TGLuint = GLuint;
  TGLfloat = GLfloat;
  TGLclampf = GLclampf;
  TGLdouble = GLdouble;
  TGLclampd = GLclampd;

  {******************************************************************************}

const
  // Version
  GL_VERSION_1_1 = 1;

  // AccumOp
  GL_ACCUM = $0100;
  GL_LOAD = $0101;
  GL_RETURN = $0102;
  GL_MULT = $0103;
  GL_ADD = $0104;

  // AlphaFunction
  GL_NEVER = $0200;
  GL_LESS = $0201;
  GL_EQUAL = $0202;
  GL_LEQUAL = $0203;
  GL_GREATER = $0204;
  GL_NOTEQUAL = $0205;
  GL_GEQUAL = $0206;
  GL_ALWAYS = $0207;

  // AttribMask
  GL_CURRENT_BIT = $00000001;
  GL_POINT_BIT = $00000002;
  GL_LINE_BIT = $00000004;
  GL_POLYGON_BIT = $00000008;
  GL_POLYGON_STIPPLE_BIT = $00000010;
  GL_PIXEL_MODE_BIT = $00000020;
  GL_LIGHTING_BIT = $00000040;
  GL_FOG_BIT = $00000080;
  GL_DEPTH_BUFFER_BIT = $00000100;
  GL_ACCUM_BUFFER_BIT = $00000200;
  GL_STENCIL_BUFFER_BIT = $00000400;
  GL_VIEWPORT_BIT = $00000800;
  GL_TRANSFORM_BIT = $00001000;
  GL_ENABLE_BIT = $00002000;
  GL_COLOR_BUFFER_BIT = $00004000;
  GL_HINT_BIT = $00008000;
  GL_EVAL_BIT = $00010000;
  GL_LIST_BIT = $00020000;
  GL_TEXTURE_BIT = $00040000;
  GL_SCISSOR_BIT = $00080000;
  GL_ALL_ATTRIB_BITS = $000FFFFF;

  // BeginMode
  GL_POINTS = $0000;
  GL_LINES = $0001;
  GL_LINE_LOOP = $0002;
  GL_LINE_STRIP = $0003;
  GL_TRIANGLES = $0004;
  GL_TRIANGLE_STRIP = $0005;
  GL_TRIANGLE_FAN = $0006;
  GL_QUADS = $0007;
  GL_QUAD_STRIP = $0008;
  GL_POLYGON = $0009;

  // BlendingFactorDest
  GL_ZERO = 0;
  GL_ONE = 1;
  GL_SRC_COLOR = $0300;
  GL_ONE_MINUS_SRC_COLOR = $0301;
  GL_SRC_ALPHA = $0302;
  GL_ONE_MINUS_SRC_ALPHA = $0303;
  GL_DST_ALPHA = $0304;
  GL_ONE_MINUS_DST_ALPHA = $0305;

  // BlendingFactorSrc
  //      GL_ZERO
  //      GL_ONE
  GL_DST_COLOR = $0306;
  GL_ONE_MINUS_DST_COLOR = $0307;
  GL_SRC_ALPHA_SATURATE = $0308;
  //      GL_SRC_ALPHA
  //      GL_ONE_MINUS_SRC_ALPHA
  //      GL_DST_ALPHA
  //      GL_ONE_MINUS_DST_ALPHA

  // Boolean
  GL_TRUE = 1;
  GL_FALSE = 0;

  // ClearBufferMask
  //      GL_COLOR_BUFFER_BIT
  //      GL_ACCUM_BUFFER_BIT
  //      GL_STENCIL_BUFFER_BIT
  //      GL_DEPTH_BUFFER_BIT

  // ClientArrayType
  //      GL_VERTEX_ARRAY
  //      GL_NORMAL_ARRAY
  //      GL_COLOR_ARRAY
  //      GL_INDEX_ARRAY
  //      GL_TEXTURE_COORD_ARRAY
  //      GL_EDGE_FLAG_ARRAY

  // ClipPlaneName
  GL_CLIP_PLANE0 = $3000;
  GL_CLIP_PLANE1 = $3001;
  GL_CLIP_PLANE2 = $3002;
  GL_CLIP_PLANE3 = $3003;
  GL_CLIP_PLANE4 = $3004;
  GL_CLIP_PLANE5 = $3005;

  // ColorMaterialFace
  //      GL_FRONT
  //      GL_BACK
  //      GL_FRONT_AND_BACK

  // ColorMaterialParameter
  //      GL_AMBIENT
  //      GL_DIFFUSE
  //      GL_SPECULAR
  //      GL_EMISSION
  //      GL_AMBIENT_AND_DIFFUSE

  // ColorPointerType
  //      GL_BYTE
  //      GL_UNSIGNED_BYTE
  //      GL_SHORT
  //      GL_UNSIGNED_SHORT
  //      GL_INT
  //      GL_UNSIGNED_INT
  //      GL_FLOAT
  //      GL_DOUBLE

  // CullFaceMode
  //      GL_FRONT
  //      GL_BACK
  //      GL_FRONT_AND_BACK

  // DataType
  GL_BYTE = $1400;
  GL_UNSIGNED_BYTE = $1401;
  GL_SHORT = $1402;
  GL_UNSIGNED_SHORT = $1403;
  GL_INT = $1404;
  GL_UNSIGNED_INT = $1405;
  GL_FLOAT = $1406;
  GL_2_BYTES = $1407;
  GL_3_BYTES = $1408;
  GL_4_BYTES = $1409;
  GL_DOUBLE = $140A;

  // DepthFunction
  //      GL_NEVER
  //      GL_LESS
  //      GL_EQUAL
  //      GL_LEQUAL
  //      GL_GREATER
  //      GL_NOTEQUAL
  //      GL_GEQUAL
  //      GL_ALWAYS

  // DrawBufferMode
  GL_NONE = 0;
  GL_FRONT_LEFT = $0400;
  GL_FRONT_RIGHT = $0401;
  GL_BACK_LEFT = $0402;
  GL_BACK_RIGHT = $0403;
  GL_FRONT = $0404;
  GL_BACK = $0405;
  GL_LEFT = $0406;
  GL_RIGHT = $0407;
  GL_FRONT_AND_BACK = $0408;
  GL_AUX0 = $0409;
  GL_AUX1 = $040A;
  GL_AUX2 = $040B;
  GL_AUX3 = $040C;

  // Enable
  //      GL_FOG
  //      GL_LIGHTING
  //      GL_TEXTURE_1D
  //      GL_TEXTURE_2D
  //      GL_LINE_STIPPLE
  //      GL_POLYGON_STIPPLE
  //      GL_CULL_FACE
  //      GL_ALPHA_TEST
  //      GL_BLEND
  //      GL_INDEX_LOGIC_OP
  //      GL_COLOR_LOGIC_OP
  //      GL_DITHER
  //      GL_STENCIL_TEST
  //      GL_DEPTH_TEST
  //      GL_CLIP_PLANE0
  //      GL_CLIP_PLANE1
  //      GL_CLIP_PLANE2
  //      GL_CLIP_PLANE3
  //      GL_CLIP_PLANE4
  //      GL_CLIP_PLANE5
  //      GL_LIGHT0
  //      GL_LIGHT1
  //      GL_LIGHT2
  //      GL_LIGHT3
  //      GL_LIGHT4
  //      GL_LIGHT5
  //      GL_LIGHT6
  //      GL_LIGHT7
  //      GL_TEXTURE_GEN_S
  //      GL_TEXTURE_GEN_T
  //      GL_TEXTURE_GEN_R
  //      GL_TEXTURE_GEN_Q
  //      GL_MAP1_VERTEX_3
  //      GL_MAP1_VERTEX_4
  //      GL_MAP1_COLOR_4
  //      GL_MAP1_INDEX
  //      GL_MAP1_NORMAL
  //      GL_MAP1_TEXTURE_COORD_1
  //      GL_MAP1_TEXTURE_COORD_2
  //      GL_MAP1_TEXTURE_COORD_3
  //      GL_MAP1_TEXTURE_COORD_4
  //      GL_MAP2_VERTEX_3
  //      GL_MAP2_VERTEX_4
  //      GL_MAP2_COLOR_4
  //      GL_MAP2_INDEX
  //      GL_MAP2_NORMAL
  //      GL_MAP2_TEXTURE_COORD_1
  //      GL_MAP2_TEXTURE_COORD_2
  //      GL_MAP2_TEXTURE_COORD_3
  //      GL_MAP2_TEXTURE_COORD_4
  //      GL_POINT_SMOOTH
  //      GL_LINE_SMOOTH
  //      GL_POLYGON_SMOOTH
  //      GL_SCISSOR_TEST
  //      GL_COLOR_MATERIAL
  //      GL_NORMALIZE
  //      GL_AUTO_NORMAL
  //      GL_VERTEX_ARRAY
  //      GL_NORMAL_ARRAY
  //      GL_COLOR_ARRAY
  //      GL_INDEX_ARRAY
  //      GL_TEXTURE_COORD_ARRAY
  //      GL_EDGE_FLAG_ARRAY
  //      GL_POLYGON_OFFSET_POINT
  //      GL_POLYGON_OFFSET_LINE
  //      GL_POLYGON_OFFSET_FILL

  // ErrorCode
  GL_NO_ERROR = 0;
  GL_INVALID_ENUM = $0500;
  GL_INVALID_VALUE = $0501;
  GL_INVALID_OPERATION = $0502;
  GL_STACK_OVERFLOW = $0503;
  GL_STACK_UNDERFLOW = $0504;
  GL_OUT_OF_MEMORY = $0505;

  // FeedBackMode
  GL_2D = $0600;
  GL_3D = $0601;
  GL_3D_COLOR = $0602;
  GL_3D_COLOR_TEXTURE = $0603;
  GL_4D_COLOR_TEXTURE = $0604;

  // FeedBackToken
  GL_PASS_THROUGH_TOKEN = $0700;
  GL_POINT_TOKEN = $0701;
  GL_LINE_TOKEN = $0702;
  GL_POLYGON_TOKEN = $0703;
  GL_BITMAP_TOKEN = $0704;
  GL_DRAW_PIXEL_TOKEN = $0705;
  GL_COPY_PIXEL_TOKEN = $0706;
  GL_LINE_RESET_TOKEN = $0707;

  // FogMode
  //      GL_LINEAR
  GL_EXP = $0800;
  GL_EXP2 = $0801;

  // FogParameter
  //      GL_FOG_COLOR
  //      GL_FOG_DENSITY
  //      GL_FOG_END
  //      GL_FOG_INDEX
  //      GL_FOG_MODE
  //      GL_FOG_START

  // FrontFaceDirection
  GL_CW = $0900;
  GL_CCW = $0901;

  // GetMapTarget
  GL_COEFF = $0A00;
  GL_ORDER = $0A01;
  GL_DOMAIN = $0A02;

  // GetPixelMap
  //      GL_PIXEL_MAP_I_TO_I
  //      GL_PIXEL_MAP_S_TO_S
  //      GL_PIXEL_MAP_I_TO_R
  //      GL_PIXEL_MAP_I_TO_G
  //      GL_PIXEL_MAP_I_TO_B
  //      GL_PIXEL_MAP_I_TO_A
  //      GL_PIXEL_MAP_R_TO_R
  //      GL_PIXEL_MAP_G_TO_G
  //      GL_PIXEL_MAP_B_TO_B
  //      GL_PIXEL_MAP_A_TO_A

  // GetPointerTarget
  //      GL_VERTEX_ARRAY_POINTER
  //      GL_NORMAL_ARRAY_POINTER
  //      GL_COLOR_ARRAY_POINTER
  //      GL_INDEX_ARRAY_POINTER
  //      GL_TEXTURE_COORD_ARRAY_POINTER
  //      GL_EDGE_FLAG_ARRAY_POINTER

  // GetTarget
  GL_CURRENT_COLOR = $0B00;
  GL_CURRENT_INDEX = $0B01;
  GL_CURRENT_NORMAL = $0B02;
  GL_CURRENT_TEXTURE_COORDS = $0B03;
  GL_CURRENT_RASTER_COLOR = $0B04;
  GL_CURRENT_RASTER_INDEX = $0B05;
  GL_CURRENT_RASTER_TEXTURE_COORDS = $0B06;
  GL_CURRENT_RASTER_POSITION = $0B07;
  GL_CURRENT_RASTER_POSITION_VALID = $0B08;
  GL_CURRENT_RASTER_DISTANCE = $0B09;
  GL_POINT_SMOOTH = $0B10;
  GL_POINT_SIZE = $0B11;
  GL_POINT_SIZE_RANGE = $0B12;
  GL_POINT_SIZE_GRANULARITY = $0B13;
  GL_LINE_SMOOTH = $0B20;
  GL_LINE_WIDTH = $0B21;
  GL_LINE_WIDTH_RANGE = $0B22;
  GL_LINE_WIDTH_GRANULARITY = $0B23;
  GL_LINE_STIPPLE = $0B24;
  GL_LINE_STIPPLE_PATTERN = $0B25;
  GL_LINE_STIPPLE_REPEAT = $0B26;
  GL_LIST_MODE = $0B30;
  GL_MAX_LIST_NESTING = $0B31;
  GL_LIST_BASE = $0B32;
  GL_LIST_INDEX = $0B33;
  GL_POLYGON_MODE = $0B40;
  GL_POLYGON_SMOOTH = $0B41;
  GL_POLYGON_STIPPLE = $0B42;
  GL_EDGE_FLAG = $0B43;
  GL_CULL_FACE = $0B44;
  GL_CULL_FACE_MODE = $0B45;
  GL_FRONT_FACE = $0B46;
  GL_LIGHTING = $0B50;
  GL_LIGHT_MODEL_LOCAL_VIEWER = $0B51;
  GL_LIGHT_MODEL_TWO_SIDE = $0B52;
  GL_LIGHT_MODEL_AMBIENT = $0B53;
  GL_SHADE_MODEL = $0B54;
  GL_COLOR_MATERIAL_FACE = $0B55;
  GL_COLOR_MATERIAL_PARAMETER = $0B56;
  GL_COLOR_MATERIAL = $0B57;
  GL_FOG = $0B60;
  GL_FOG_INDEX = $0B61;
  GL_FOG_DENSITY = $0B62;
  GL_FOG_START = $0B63;
  GL_FOG_END = $0B64;
  GL_FOG_MODE = $0B65;
  GL_FOG_COLOR = $0B66;
  GL_DEPTH_RANGE = $0B70;
  GL_DEPTH_TEST = $0B71;
  GL_DEPTH_WRITEMASK = $0B72;
  GL_DEPTH_CLEAR_VALUE = $0B73;
  GL_DEPTH_FUNC = $0B74;
  GL_ACCUM_CLEAR_VALUE = $0B80;
  GL_STENCIL_TEST = $0B90;
  GL_STENCIL_CLEAR_VALUE = $0B91;
  GL_STENCIL_FUNC = $0B92;
  GL_STENCIL_VALUE_MASK = $0B93;
  GL_STENCIL_FAIL = $0B94;
  GL_STENCIL_PASS_DEPTH_FAIL = $0B95;
  GL_STENCIL_PASS_DEPTH_PASS = $0B96;
  GL_STENCIL_REF = $0B97;
  GL_STENCIL_WRITEMASK = $0B98;
  GL_MATRIX_MODE = $0BA0;
  GL_NORMALIZE = $0BA1;
  GL_VIEWPORT = $0BA2;
  GL_MODELVIEW_STACK_DEPTH = $0BA3;
  GL_PROJECTION_STACK_DEPTH = $0BA4;
  GL_TEXTURE_STACK_DEPTH = $0BA5;
  GL_MODELVIEW_MATRIX = $0BA6;
  GL_PROJECTION_MATRIX = $0BA7;
  GL_TEXTURE_MATRIX = $0BA8;
  GL_ATTRIB_STACK_DEPTH = $0BB0;
  GL_CLIENT_ATTRIB_STACK_DEPTH = $0BB1;
  GL_ALPHA_TEST = $0BC0;
  GL_ALPHA_TEST_FUNC = $0BC1;
  GL_ALPHA_TEST_REF = $0BC2;
  GL_DITHER = $0BD0;
  GL_BLEND_DST = $0BE0;
  GL_BLEND_SRC = $0BE1;
  GL_BLEND = $0BE2;
  GL_LOGIC_OP_MODE = $0BF0;
  GL_INDEX_LOGIC_OP = $0BF1;
  GL_COLOR_LOGIC_OP = $0BF2;
  GL_AUX_BUFFERS = $0C00;
  GL_DRAW_BUFFER = $0C01;
  GL_READ_BUFFER = $0C02;
  GL_SCISSOR_BOX = $0C10;
  GL_SCISSOR_TEST = $0C11;
  GL_INDEX_CLEAR_VALUE = $0C20;
  GL_INDEX_WRITEMASK = $0C21;
  GL_COLOR_CLEAR_VALUE = $0C22;
  GL_COLOR_WRITEMASK = $0C23;
  GL_INDEX_MODE = $0C30;
  GL_RGBA_MODE = $0C31;
  GL_DOUBLEBUFFER = $0C32;
  GL_STEREO = $0C33;
  GL_RENDER_MODE = $0C40;
  GL_PERSPECTIVE_CORRECTION_HINT = $0C50;
  GL_POINT_SMOOTH_HINT = $0C51;
  GL_LINE_SMOOTH_HINT = $0C52;
  GL_POLYGON_SMOOTH_HINT = $0C53;
  GL_FOG_HINT = $0C54;
  GL_TEXTURE_GEN_S = $0C60;
  GL_TEXTURE_GEN_T = $0C61;
  GL_TEXTURE_GEN_R = $0C62;
  GL_TEXTURE_GEN_Q = $0C63;
  GL_PIXEL_MAP_I_TO_I = $0C70;
  GL_PIXEL_MAP_S_TO_S = $0C71;
  GL_PIXEL_MAP_I_TO_R = $0C72;
  GL_PIXEL_MAP_I_TO_G = $0C73;
  GL_PIXEL_MAP_I_TO_B = $0C74;
  GL_PIXEL_MAP_I_TO_A = $0C75;
  GL_PIXEL_MAP_R_TO_R = $0C76;
  GL_PIXEL_MAP_G_TO_G = $0C77;
  GL_PIXEL_MAP_B_TO_B = $0C78;
  GL_PIXEL_MAP_A_TO_A = $0C79;
  GL_PIXEL_MAP_I_TO_I_SIZE = $0CB0;
  GL_PIXEL_MAP_S_TO_S_SIZE = $0CB1;
  GL_PIXEL_MAP_I_TO_R_SIZE = $0CB2;
  GL_PIXEL_MAP_I_TO_G_SIZE = $0CB3;
  GL_PIXEL_MAP_I_TO_B_SIZE = $0CB4;
  GL_PIXEL_MAP_I_TO_A_SIZE = $0CB5;
  GL_PIXEL_MAP_R_TO_R_SIZE = $0CB6;
  GL_PIXEL_MAP_G_TO_G_SIZE = $0CB7;
  GL_PIXEL_MAP_B_TO_B_SIZE = $0CB8;
  GL_PIXEL_MAP_A_TO_A_SIZE = $0CB9;
  GL_UNPACK_SWAP_BYTES = $0CF0;
  GL_UNPACK_LSB_FIRST = $0CF1;
  GL_UNPACK_ROW_LENGTH = $0CF2;
  GL_UNPACK_SKIP_ROWS = $0CF3;
  GL_UNPACK_SKIP_PIXELS = $0CF4;
  GL_UNPACK_ALIGNMENT = $0CF5;
  GL_PACK_SWAP_BYTES = $0D00;
  GL_PACK_LSB_FIRST = $0D01;
  GL_PACK_ROW_LENGTH = $0D02;
  GL_PACK_SKIP_ROWS = $0D03;
  GL_PACK_SKIP_PIXELS = $0D04;
  GL_PACK_ALIGNMENT = $0D05;
  GL_MAP_COLOR = $0D10;
  GL_MAP_STENCIL = $0D11;
  GL_INDEX_SHIFT = $0D12;
  GL_INDEX_OFFSET = $0D13;
  GL_RED_SCALE = $0D14;
  GL_RED_BIAS = $0D15;
  GL_ZOOM_X = $0D16;
  GL_ZOOM_Y = $0D17;
  GL_GREEN_SCALE = $0D18;
  GL_GREEN_BIAS = $0D19;
  GL_BLUE_SCALE = $0D1A;
  GL_BLUE_BIAS = $0D1B;
  GL_ALPHA_SCALE = $0D1C;
  GL_ALPHA_BIAS = $0D1D;
  GL_DEPTH_SCALE = $0D1E;
  GL_DEPTH_BIAS = $0D1F;
  GL_MAX_EVAL_ORDER = $0D30;
  GL_MAX_LIGHTS = $0D31;
  GL_MAX_CLIP_PLANES = $0D32;
  GL_MAX_TEXTURE_SIZE = $0D33;
  GL_MAX_PIXEL_MAP_TABLE = $0D34;
  GL_MAX_ATTRIB_STACK_DEPTH = $0D35;
  GL_MAX_MODELVIEW_STACK_DEPTH = $0D36;
  GL_MAX_NAME_STACK_DEPTH = $0D37;
  GL_MAX_PROJECTION_STACK_DEPTH = $0D38;
  GL_MAX_TEXTURE_STACK_DEPTH = $0D39;
  GL_MAX_VIEWPORT_DIMS = $0D3A;
  GL_MAX_CLIENT_ATTRIB_STACK_DEPTH = $0D3B;
  GL_SUBPIXEL_BITS = $0D50;
  GL_INDEX_BITS = $0D51;
  GL_RED_BITS = $0D52;
  GL_GREEN_BITS = $0D53;
  GL_BLUE_BITS = $0D54;
  GL_ALPHA_BITS = $0D55;
  GL_DEPTH_BITS = $0D56;
  GL_STENCIL_BITS = $0D57;
  GL_ACCUM_RED_BITS = $0D58;
  GL_ACCUM_GREEN_BITS = $0D59;
  GL_ACCUM_BLUE_BITS = $0D5A;
  GL_ACCUM_ALPHA_BITS = $0D5B;
  GL_NAME_STACK_DEPTH = $0D70;
  GL_AUTO_NORMAL = $0D80;
  GL_MAP1_COLOR_4 = $0D90;
  GL_MAP1_INDEX = $0D91;
  GL_MAP1_NORMAL = $0D92;
  GL_MAP1_TEXTURE_COORD_1 = $0D93;
  GL_MAP1_TEXTURE_COORD_2 = $0D94;
  GL_MAP1_TEXTURE_COORD_3 = $0D95;
  GL_MAP1_TEXTURE_COORD_4 = $0D96;
  GL_MAP1_VERTEX_3 = $0D97;
  GL_MAP1_VERTEX_4 = $0D98;
  GL_MAP2_COLOR_4 = $0DB0;
  GL_MAP2_INDEX = $0DB1;
  GL_MAP2_NORMAL = $0DB2;
  GL_MAP2_TEXTURE_COORD_1 = $0DB3;
  GL_MAP2_TEXTURE_COORD_2 = $0DB4;
  GL_MAP2_TEXTURE_COORD_3 = $0DB5;
  GL_MAP2_TEXTURE_COORD_4 = $0DB6;
  GL_MAP2_VERTEX_3 = $0DB7;
  GL_MAP2_VERTEX_4 = $0DB8;
  GL_MAP1_GRID_DOMAIN = $0DD0;
  GL_MAP1_GRID_SEGMENTS = $0DD1;
  GL_MAP2_GRID_DOMAIN = $0DD2;
  GL_MAP2_GRID_SEGMENTS = $0DD3;
  GL_TEXTURE_1D = $0DE0;
  GL_TEXTURE_2D = $0DE1;
  GL_FEEDBACK_BUFFER_POINTER = $0DF0;
  GL_FEEDBACK_BUFFER_SIZE = $0DF1;
  GL_FEEDBACK_BUFFER_TYPE = $0DF2;
  GL_SELECTION_BUFFER_POINTER = $0DF3;
  GL_SELECTION_BUFFER_SIZE = $0DF4;
  //      GL_TEXTURE_BINDING_1D
  //      GL_TEXTURE_BINDING_2D
  //      GL_VERTEX_ARRAY
  //      GL_NORMAL_ARRAY
  //      GL_COLOR_ARRAY
  //      GL_INDEX_ARRAY
  //      GL_TEXTURE_COORD_ARRAY
  //      GL_EDGE_FLAG_ARRAY
  //      GL_VERTEX_ARRAY_SIZE
  //      GL_VERTEX_ARRAY_TYPE
  //      GL_VERTEX_ARRAY_STRIDE
  //      GL_NORMAL_ARRAY_TYPE
  //      GL_NORMAL_ARRAY_STRIDE
  //      GL_COLOR_ARRAY_SIZE
  //      GL_COLOR_ARRAY_TYPE
  //      GL_COLOR_ARRAY_STRIDE
  //      GL_INDEX_ARRAY_TYPE
  //      GL_INDEX_ARRAY_STRIDE
  //      GL_TEXTURE_COORD_ARRAY_SIZE
  //      GL_TEXTURE_COORD_ARRAY_TYPE
  //      GL_TEXTURE_COORD_ARRAY_STRIDE
  //      GL_EDGE_FLAG_ARRAY_STRIDE
  //      GL_POLYGON_OFFSET_FACTOR
  //      GL_POLYGON_OFFSET_UNITS

  // GetTextureParameter
  //      GL_TEXTURE_MAG_FILTER
  //      GL_TEXTURE_MIN_FILTER
  //      GL_TEXTURE_WRAP_S
  //      GL_TEXTURE_WRAP_T
  GL_TEXTURE_WIDTH = $1000;
  GL_TEXTURE_HEIGHT = $1001;
  GL_TEXTURE_INTERNAL_FORMAT = $1003;
  GL_TEXTURE_BORDER_COLOR = $1004;
  GL_TEXTURE_BORDER = $1005;
  //      GL_TEXTURE_RED_SIZE
  //      GL_TEXTURE_GREEN_SIZE
  //      GL_TEXTURE_BLUE_SIZE
  //      GL_TEXTURE_ALPHA_SIZE
  //      GL_TEXTURE_LUMINANCE_SIZE
  //      GL_TEXTURE_INTENSITY_SIZE
  //      GL_TEXTURE_PRIORITY
  //      GL_TEXTURE_RESIDENT

  // HintMode
  GL_DONT_CARE = $1100;
  GL_FASTEST = $1101;
  GL_NICEST = $1102;

  // HintTarget
  //      GL_PERSPECTIVE_CORRECTION_HINT
  //      GL_POINT_SMOOTH_HINT
  //      GL_LINE_SMOOTH_HINT
  //      GL_POLYGON_SMOOTH_HINT
  //      GL_FOG_HINT

  // IndexPointerType
  //      GL_SHORT
  //      GL_INT
  //      GL_FLOAT
  //      GL_DOUBLE

  // LightModelParameter
  //      GL_LIGHT_MODEL_AMBIENT
  //      GL_LIGHT_MODEL_LOCAL_VIEWER
  //      GL_LIGHT_MODEL_TWO_SIDE

  // LightName
  GL_LIGHT0 = $4000;
  GL_LIGHT1 = $4001;
  GL_LIGHT2 = $4002;
  GL_LIGHT3 = $4003;
  GL_LIGHT4 = $4004;
  GL_LIGHT5 = $4005;
  GL_LIGHT6 = $4006;
  GL_LIGHT7 = $4007;

  // LightParameter
  GL_AMBIENT = $1200;
  GL_DIFFUSE = $1201;
  GL_SPECULAR = $1202;
  GL_POSITION = $1203;
  GL_SPOT_DIRECTION = $1204;
  GL_SPOT_EXPONENT = $1205;
  GL_SPOT_CUTOFF = $1206;
  GL_CONSTANT_ATTENUATION = $1207;
  GL_LINEAR_ATTENUATION = $1208;
  GL_QUADRATIC_ATTENUATION = $1209;

  // InterleavedArrays
  //      GL_V2F
  //      GL_V3F
  //      GL_C4UB_V2F
  //      GL_C4UB_V3F
  //      GL_C3F_V3F
  //      GL_N3F_V3F
  //      GL_C4F_N3F_V3F
  //      GL_T2F_V3F
  //      GL_T4F_V4F
  //      GL_T2F_C4UB_V3F
  //      GL_T2F_C3F_V3F
  //      GL_T2F_N3F_V3F
  //      GL_T2F_C4F_N3F_V3F
  //      GL_T4F_C4F_N3F_V4F

  // ListMode
  GL_COMPILE = $1300;
  GL_COMPILE_AND_EXECUTE = $1301;

  // ListNameType
  //      GL_BYTE
  //      GL_UNSIGNED_BYTE
  //      GL_SHORT
  //      GL_UNSIGNED_SHORT
  //      GL_INT
  //      GL_UNSIGNED_INT
  //      GL_FLOAT
  //      GL_2_BYTES
  //      GL_3_BYTES
  //      GL_4_BYTES

  // LogicOp
  GL_CLEAR = $1500;
  GL_AND = $1501;
  GL_AND_REVERSE = $1502;
  GL_COPY = $1503;
  GL_AND_INVERTED = $1504;
  GL_NOOP = $1505;
  GL_XOR = $1506;
  GL_OR = $1507;
  GL_NOR = $1508;
  GL_EQUIV = $1509;
  GL_INVERT = $150A;
  GL_OR_REVERSE = $150B;
  GL_COPY_INVERTED = $150C;
  GL_OR_INVERTED = $150D;
  GL_NAND = $150E;
  GL_SET = $150F;

  // MapTarget
  //      GL_MAP1_COLOR_4
  //      GL_MAP1_INDEX
  //      GL_MAP1_NORMAL
  //      GL_MAP1_TEXTURE_COORD_1
  //      GL_MAP1_TEXTURE_COORD_2
  //      GL_MAP1_TEXTURE_COORD_3
  //      GL_MAP1_TEXTURE_COORD_4
  //      GL_MAP1_VERTEX_3
  //      GL_MAP1_VERTEX_4
  //      GL_MAP2_COLOR_4
  //      GL_MAP2_INDEX
  //      GL_MAP2_NORMAL
  //      GL_MAP2_TEXTURE_COORD_1
  //      GL_MAP2_TEXTURE_COORD_2
  //      GL_MAP2_TEXTURE_COORD_3
  //      GL_MAP2_TEXTURE_COORD_4
  //      GL_MAP2_VERTEX_3
  //      GL_MAP2_VERTEX_4

  // MaterialFace
  //      GL_FRONT
  //      GL_BACK
  //      GL_FRONT_AND_BACK

  // MaterialParameter
  GL_EMISSION = $1600;
  GL_SHININESS = $1601;
  GL_AMBIENT_AND_DIFFUSE = $1602;
  GL_COLOR_INDEXES = $1603;
  //      GL_AMBIENT
  //      GL_DIFFUSE
  //      GL_SPECULAR

  // MatrixMode
  GL_MODELVIEW = $1700;
  GL_PROJECTION = $1701;
  GL_TEXTURE = $1702;

  // MeshMode1
  //      GL_POINT
  //      GL_LINE

  // MeshMode2
  //      GL_POINT
  //      GL_LINE
  //      GL_FILL

  // NormalPointerType
  //      GL_BYTE
  //      GL_SHORT
  //      GL_INT
  //      GL_FLOAT
  //      GL_DOUBLE

  // PixelCopyType
  GL_COLOR = $1800;
  GL_DEPTH = $1801;
  GL_STENCIL = $1802;

  // PixelFormat
  GL_COLOR_INDEX = $1900;
  GL_STENCIL_INDEX = $1901;
  GL_DEPTH_COMPONENT = $1902;
  GL_RED = $1903;
  GL_GREEN = $1904;
  GL_BLUE = $1905;
  GL_ALPHA = $1906;
  GL_RGB = $1907;
  GL_RGBA = $1908;
  GL_LUMINANCE = $1909;
  GL_LUMINANCE_ALPHA = $190A;

  // PixelMap
  //      GL_PIXEL_MAP_I_TO_I
  //      GL_PIXEL_MAP_S_TO_S
  //      GL_PIXEL_MAP_I_TO_R
  //      GL_PIXEL_MAP_I_TO_G
  //      GL_PIXEL_MAP_I_TO_B
  //      GL_PIXEL_MAP_I_TO_A
  //      GL_PIXEL_MAP_R_TO_R
  //      GL_PIXEL_MAP_G_TO_G
  //      GL_PIXEL_MAP_B_TO_B
  //      GL_PIXEL_MAP_A_TO_A

  // PixelStore
  //      GL_UNPACK_SWAP_BYTES
  //      GL_UNPACK_LSB_FIRST
  //      GL_UNPACK_ROW_LENGTH
  //      GL_UNPACK_SKIP_ROWS
  //      GL_UNPACK_SKIP_PIXELS
  //      GL_UNPACK_ALIGNMENT
  //      GL_PACK_SWAP_BYTES
  //      GL_PACK_LSB_FIRST
  //      GL_PACK_ROW_LENGTH
  //      GL_PACK_SKIP_ROWS
  //      GL_PACK_SKIP_PIXELS
  //      GL_PACK_ALIGNMENT

  // PixelTransfer
  //      GL_MAP_COLOR
  //      GL_MAP_STENCIL
  //      GL_INDEX_SHIFT
  //      GL_INDEX_OFFSET
  //      GL_RED_SCALE
  //      GL_RED_BIAS
  //      GL_GREEN_SCALE
  //      GL_GREEN_BIAS
  //      GL_BLUE_SCALE
  //      GL_BLUE_BIAS
  //      GL_ALPHA_SCALE
  //      GL_ALPHA_BIAS
  //      GL_DEPTH_SCALE
  //      GL_DEPTH_BIAS

  // PixelType
  GL_BITMAP = $1A00;
  //      GL_BYTE
  //      GL_UNSIGNED_BYTE
  //      GL_SHORT
  //      GL_UNSIGNED_SHORT
  //      GL_INT
  //      GL_UNSIGNED_INT
  //      GL_FLOAT

  // PolygonMode
  GL_POINT = $1B00;
  GL_LINE = $1B01;
  GL_FILL = $1B02;

  // ReadBufferMode
  //      GL_FRONT_LEFT
  //      GL_FRONT_RIGHT
  //      GL_BACK_LEFT
  //      GL_BACK_RIGHT
  //      GL_FRONT
  //      GL_BACK
  //      GL_LEFT
  //      GL_RIGHT
  //      GL_AUX0
  //      GL_AUX1
  //      GL_AUX2
  //      GL_AUX3

  // RenderingMode
  GL_RENDER = $1C00;
  GL_FEEDBACK = $1C01;
  GL_SELECT = $1C02;

  // ShadingModel
  GL_FLAT = $1D00;
  GL_SMOOTH = $1D01;

  // StencilFunction
  //      GL_NEVER
  //      GL_LESS
  //      GL_EQUAL
  //      GL_LEQUAL
  //      GL_GREATER
  //      GL_NOTEQUAL
  //      GL_GEQUAL
  //      GL_ALWAYS

  // StencilOp
  //      GL_ZERO
  GL_KEEP = $1E00;
  GL_REPLACE = $1E01;
  GL_INCR = $1E02;
  GL_DECR = $1E03;
  //      GL_INVERT

  // StringName
  GL_VENDOR = $1F00;
  GL_RENDERER = $1F01;
  GL_VERSION = $1F02;
  GL_EXTENSIONS = $1F03;

  // TextureCoordName
  GL_S = $2000;
  GL_T = $2001;
  GL_R = $2002;
  GL_Q = $2003;

  // TexCoordPointerType
  //      GL_SHORT
  //      GL_INT
  //      GL_FLOAT
  //      GL_DOUBLE

  // TextureEnvMode
  GL_MODULATE = $2100;
  GL_DECAL = $2101;
  //      GL_BLEND
  //      GL_REPLACE

  // TextureEnvParameter
  GL_TEXTURE_ENV_MODE = $2200;
  GL_TEXTURE_ENV_COLOR = $2201;

  // TextureEnvTarget
  GL_TEXTURE_ENV = $2300;

  // TextureGenMode
  GL_EYE_LINEAR = $2400;
  GL_OBJECT_LINEAR = $2401;
  GL_SPHERE_MAP = $2402;

  // TextureGenParameter
  GL_TEXTURE_GEN_MODE = $2500;
  GL_OBJECT_PLANE = $2501;
  GL_EYE_PLANE = $2502;

  // TextureMagFilter
  GL_NEAREST = $2600;
  GL_LINEAR = $2601;

  // TextureMinFilter
  //      GL_NEAREST
  //      GL_LINEAR
  GL_NEAREST_MIPMAP_NEAREST = $2700;
  GL_LINEAR_MIPMAP_NEAREST = $2701;
  GL_NEAREST_MIPMAP_LINEAR = $2702;
  GL_LINEAR_MIPMAP_LINEAR = $2703;

  // TextureParameterName
  GL_TEXTURE_MAG_FILTER = $2800;
  GL_TEXTURE_MIN_FILTER = $2801;
  GL_TEXTURE_WRAP_S = $2802;
  GL_TEXTURE_WRAP_T = $2803;
  //      GL_TEXTURE_BORDER_COLOR
  //      GL_TEXTURE_PRIORITY

  // TextureTarget
  //      GL_TEXTURE_1D
  //      GL_TEXTURE_2D
  //      GL_PROXY_TEXTURE_1D
  //      GL_PROXY_TEXTURE_2D

  // TextureWrapMode
  GL_CLAMP = $2900;
  GL_REPEAT = $2901;

  // VertexPointerType
  //      GL_SHORT
  //      GL_INT
  //      GL_FLOAT
  //      GL_DOUBLE

  // ClientAttribMask
  GL_CLIENT_PIXEL_STORE_BIT = $00000001;
  GL_CLIENT_VERTEX_ARRAY_BIT = $00000002;
  GL_CLIENT_ALL_ATTRIB_BITS = $FFFFFFFF;

  // polygon_offset
  GL_POLYGON_OFFSET_FACTOR = $8038;
  GL_POLYGON_OFFSET_UNITS = $2A00;
  GL_POLYGON_OFFSET_POINT = $2A01;
  GL_POLYGON_OFFSET_LINE = $2A02;
  GL_POLYGON_OFFSET_FILL = $8037;

  // texture
  GL_ALPHA4 = $803B;
  GL_ALPHA8 = $803C;
  GL_ALPHA12 = $803D;
  GL_ALPHA16 = $803E;
  GL_LUMINANCE4 = $803F;
  GL_LUMINANCE8 = $8040;
  GL_LUMINANCE12 = $8041;
  GL_LUMINANCE16 = $8042;
  GL_LUMINANCE4_ALPHA4 = $8043;
  GL_LUMINANCE6_ALPHA2 = $8044;
  GL_LUMINANCE8_ALPHA8 = $8045;
  GL_LUMINANCE12_ALPHA4 = $8046;
  GL_LUMINANCE12_ALPHA12 = $8047;
  GL_LUMINANCE16_ALPHA16 = $8048;
  GL_INTENSITY = $8049;
  GL_INTENSITY4 = $804A;
  GL_INTENSITY8 = $804B;
  GL_INTENSITY12 = $804C;
  GL_INTENSITY16 = $804D;
  GL_R3_G3_B2 = $2A10;
  GL_RGB4 = $804F;
  GL_RGB5 = $8050;
  GL_RGB8 = $8051;
  GL_RGB10 = $8052;
  GL_RGB12 = $8053;
  GL_RGB16 = $8054;
  GL_RGBA2 = $8055;
  GL_RGBA4 = $8056;
  GL_RGB5_A1 = $8057;
  GL_RGBA8 = $8058;
  GL_RGB10_A2 = $8059;
  GL_RGBA12 = $805A;
  GL_RGBA16 = $805B;
  GL_TEXTURE_RED_SIZE = $805C;
  GL_TEXTURE_GREEN_SIZE = $805D;
  GL_TEXTURE_BLUE_SIZE = $805E;
  GL_TEXTURE_ALPHA_SIZE = $805F;
  GL_TEXTURE_LUMINANCE_SIZE = $8060;
  GL_TEXTURE_INTENSITY_SIZE = $8061;
  GL_PROXY_TEXTURE_1D = $8063;
  GL_PROXY_TEXTURE_2D = $8064;

  // texture_object
  GL_TEXTURE_PRIORITY = $8066;
  GL_TEXTURE_RESIDENT = $8067;
  GL_TEXTURE_BINDING_1D = $8068;
  GL_TEXTURE_BINDING_2D = $8069;

  // vertex_array
  GL_VERTEX_ARRAY = $8074;
  GL_NORMAL_ARRAY = $8075;
  GL_COLOR_ARRAY = $8076;
  GL_INDEX_ARRAY = $8077;
  GL_TEXTURE_COORD_ARRAY = $8078;
  GL_EDGE_FLAG_ARRAY = $8079;
  GL_VERTEX_ARRAY_SIZE = $807A;
  GL_VERTEX_ARRAY_TYPE = $807B;
  GL_VERTEX_ARRAY_STRIDE = $807C;
  GL_NORMAL_ARRAY_TYPE = $807E;
  GL_NORMAL_ARRAY_STRIDE = $807F;
  GL_COLOR_ARRAY_SIZE = $8081;
  GL_COLOR_ARRAY_TYPE = $8082;
  GL_COLOR_ARRAY_STRIDE = $8083;
  GL_INDEX_ARRAY_TYPE = $8085;
  GL_INDEX_ARRAY_STRIDE = $8086;
  GL_TEXTURE_COORD_ARRAY_SIZE = $8088;
  GL_TEXTURE_COORD_ARRAY_TYPE = $8089;
  GL_TEXTURE_COORD_ARRAY_STRIDE = $808A;
  GL_EDGE_FLAG_ARRAY_STRIDE = $808C;
  GL_VERTEX_ARRAY_POINTER = $808E;
  GL_NORMAL_ARRAY_POINTER = $808F;
  GL_COLOR_ARRAY_POINTER = $8090;
  GL_INDEX_ARRAY_POINTER = $8091;
  GL_TEXTURE_COORD_ARRAY_POINTER = $8092;
  GL_EDGE_FLAG_ARRAY_POINTER = $8093;
  GL_V2F = $2A20;
  GL_V3F = $2A21;
  GL_C4UB_V2F = $2A22;
  GL_C4UB_V3F = $2A23;
  GL_C3F_V3F = $2A24;
  GL_N3F_V3F = $2A25;
  GL_C4F_N3F_V3F = $2A26;
  GL_T2F_V3F = $2A27;
  GL_T4F_V4F = $2A28;
  GL_T2F_C4UB_V3F = $2A29;
  GL_T2F_C3F_V3F = $2A2A;
  GL_T2F_N3F_V3F = $2A2B;
  GL_T2F_C4F_N3F_V3F = $2A2C;
  GL_T4F_C4F_N3F_V4F = $2A2D;

  // For compatibility with OpenGL v1.0
  GL_LOGIC_OP = GL_INDEX_LOGIC_OP;
  GL_TEXTURE_COMPONENTS = GL_TEXTURE_INTERNAL_FORMAT;

type
  TGLAccum = procedure(op: GLenum; Value: GLfloat); cdecl;
  TGLAlphaFunc = procedure(func: GLenum; ref: GLclampf); cdecl;
  TGLAreTexturesResident = function(n: GLsizei; const textures: PGLuint; residences: PGLboolean): GLboolean; cdecl;
  TGLArrayElement = procedure(i: GLint); cdecl;
  TGLBegin = procedure(mode: GLenum); cdecl;
  TGLBindTexture = procedure(target: GLenum; texture: GLuint); cdecl;
  TGLBitmap = procedure(Width, Height: GLsizei; xorig, yorig: GLfloat; xmove, ymove: GLfloat; const bitmap: PGLubyte); cdecl;
  TGLBlendFunc = procedure(sfactor, dfactor: GLenum); cdecl;
  TGLCallList = procedure(list: GLuint); cdecl;
  TGLCallLists = procedure(n: GLsizei; atype: GLenum; const lists: Pointer); cdecl;
  TGLClear = procedure(mask: GLbitfield); cdecl;
  TGLClearAccum = procedure(red, green, blue, alpha: GLfloat); cdecl;
  TGLClearColor = procedure(red, green, blue, alpha: GLclampf); cdecl;
  TGLClearDepth = procedure(depth: GLclampd); cdecl;
  TGLClearIndex = procedure(c: GLfloat); cdecl;
  TGLClearStencil = procedure(s: GLint); cdecl;
  TGLClipPlane = procedure(plane: GLenum; const equation: PGLdouble); cdecl;
  TGLColor3b = procedure(red, green, blue: GLbyte); cdecl;
  TGLColor3bv = procedure(const v: PGLbyte); cdecl;
  TGLColor3d = procedure(red, green, blue: GLdouble); cdecl;
  TGLColor3dv = procedure(const v: PGLdouble); cdecl;
  TGLColor3f = procedure(red, green, blue: GLfloat); cdecl;
  TGLColor3fv = procedure(const v: PGLfloat); cdecl;
  TGLColor3i = procedure(red, green, blue: GLint); cdecl;
  TGLColor3iv = procedure(const v: PGLint); cdecl;
  TGLColor3s = procedure(red, green, blue: GLshort); cdecl;
  TGLColor3sv = procedure(const v: PGLshort); cdecl;
  TGLColor3ub = procedure(red, green, blue: GLubyte); cdecl;
  TGLColor3ubv = procedure(const v: PGLubyte); cdecl;
  TGLColor3ui = procedure(red, green, blue: GLuint); cdecl;
  TGLColor3uiv = procedure(const v: PGLuint); cdecl;
  TGLColor3us = procedure(red, green, blue: GLushort); cdecl;
  TGLColor3usv = procedure(const v: PGLushort); cdecl;
  TGLColor4b = procedure(red, green, blue, alpha: GLbyte); cdecl;
  TGLColor4bv = procedure(const v: PGLbyte); cdecl;
  TGLColor4d = procedure(red, green, blue, alpha: GLdouble); cdecl;
  TGLColor4dv = procedure(const v: PGLdouble); cdecl;
  TGLColor4f = procedure(red, green, blue, alpha: GLfloat); cdecl;
  TGLColor4fv = procedure(const v: PGLfloat); cdecl;
  TGLColor4i = procedure(red, green, blue, alpha: GLint); cdecl;
  TGLColor4iv = procedure(const v: PGLint); cdecl;
  TGLColor4s = procedure(red, green, blue, alpha: GLshort); cdecl;
  TGLColor4sv = procedure(const v: PGLshort); cdecl;
  TGLColor4ub = procedure(red, green, blue, alpha: GLubyte); cdecl;
  TGLColor4ubv = procedure(const v: PGLubyte); cdecl;
  TGLColor4ui = procedure(red, green, blue, alpha: GLuint); cdecl;
  TGLColor4uiv = procedure(const v: PGLuint); cdecl;
  TGLColor4us = procedure(red, green, blue, alpha: GLushort); cdecl;
  TGLColor4usv = procedure(const v: PGLushort); cdecl;
  TGLColorMask = procedure(red, green, blue, alpha: GLboolean); cdecl;
  TGLColorMaterial = procedure(face, mode: GLenum); cdecl;
  TGLColorPointer = procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); cdecl;
  TGLCopyPixels = procedure(x, y: GLint; Width, Height: GLsizei; atype: GLenum); cdecl;
  TGLCopyTexImage1D = procedure(target: GLenum; level: GLint; internalFormat: GLenum; x, y: GLint; Width: GLsizei; border: GLint); cdecl;
  TGLCopyTexImage2D = procedure(target: GLenum; level: GLint; internalFormat: GLenum; x, y: GLint; Width, Height: GLsizei; border: GLint); cdecl;
  TGLCopyTexSubImage1D = procedure(target: GLenum; level, xoffset, x, y: GLint; Width: GLsizei); cdecl;
  TGLCopyTexSubImage2D = procedure(target: GLenum; level, xoffset, yoffset, x, y: GLint; Width, Height: GLsizei); cdecl;
  TGLCullFace = procedure(mode: GLenum); cdecl;
  TGLDeleteLists = procedure(list: GLuint; range: GLsizei); cdecl;
  TGLDeleteTextures = procedure(n: GLsizei; const textures: PGLuint); cdecl;
  TGLDepthFunc = procedure(func: GLenum); cdecl;
  TGLDepthMask = procedure(flag: GLboolean); cdecl;
  TGLDepthRange = procedure(zNear, zFar: GLclampd); cdecl;
  TGLDisable = procedure(cap: GLenum); cdecl;
  TGLDisableClientState = procedure(aarray: GLenum); cdecl;
  TGLDrawArrays = procedure(mode: GLenum; First: GLint; Count: GLsizei); cdecl;
  TGLDrawBuffer = procedure(mode: GLenum); cdecl;
  TGLDrawElements = procedure(mode: GLenum; Count: GLsizei; atype: GLenum; const indices: Pointer); cdecl;
  TGLDrawPixels = procedure(Width, Height: GLsizei; format, atype: GLenum; const pixels: Pointer); cdecl;
  TGLEdgeFlag = procedure(flag: GLboolean); cdecl;
  TGLEdgeFlagPointer = procedure(stride: GLsizei; const pointer: Pointer); cdecl;
  TGLEdgeFlagv = procedure(const flag: PGLboolean); cdecl;
  TGLEnable = procedure(cap: GLenum); cdecl;
  TGLEnableClientState = procedure(aarray: GLenum); cdecl;
  TGLEnd = procedure; cdecl;
  TGLEndList = procedure; cdecl;
  TGLEvalCoord1d = procedure(u: GLdouble); cdecl;
  TGLEvalCoord1dv = procedure(const u: PGLdouble); cdecl;
  TGLEvalCoord1f = procedure(u: GLfloat); cdecl;
  TGLEvalCoord1fv = procedure(const u: PGLfloat); cdecl;
  TGLEvalCoord2d = procedure(u, v: GLdouble); cdecl;
  TGLEvalCoord2dv = procedure(const u: PGLdouble); cdecl;
  TGLEvalCoord2f = procedure(u, v: GLfloat); cdecl;
  TGLEvalCoord2fv = procedure(const u: PGLfloat); cdecl;
  TGLEvalMesh1 = procedure(mode: GLenum; i1, i2: GLint); cdecl;
  TGLEvalMesh2 = procedure(mode: GLenum; i1, i2, j1, j2: GLint); cdecl;
  TGLEvalPoint1 = procedure(i: GLint); cdecl;
  TGLEvalPoint2 = procedure(i, j: GLint); cdecl;
  TGLFeedbackBuffer = procedure(size: GLsizei; atype: GLenum; buffer: PGLfloat); cdecl;
  TGLFinish = procedure; cdecl;
  TGLFlush = procedure; cdecl;
  TGLFogf = procedure(pname: GLenum; param: GLfloat); cdecl;
  TGLFogfv = procedure(pname: GLenum; const params: PGLfloat); cdecl;
  TGLFogi = procedure(pname: GLenum; param: GLint); cdecl;
  TGLFogiv = procedure(pname: GLenum; const params: PGLint); cdecl;
  TGLFrontFace = procedure(mode: GLenum); cdecl;
  TGLFrustum = procedure(left, right, bottom, top, zNear, zFar: GLdouble); cdecl;
  TGLGenLists = function(range: GLsizei): GLuint; cdecl;
  TGLGenTextures = procedure(n: GLsizei; textures: PGLuint); cdecl;
  TGLGetBooleanv = procedure(pname: GLenum; params: PGLboolean); cdecl;
  TGLGetClipPlane = procedure(plane: GLenum; equation: PGLdouble); cdecl;
  TGLGetDoublev = procedure(pname: GLenum; params: PGLdouble); cdecl;
  TGLGetError = function: GLenum; cdecl;
  TGLGetFloatv = procedure(pname: GLenum; params: PGLfloat); cdecl;
  TGLGetIntegerv = procedure(pname: GLenum; params: PGLint); cdecl;
  TGLGetLightfv = procedure(light, pname: GLenum; params: PGLfloat); cdecl;
  TGLGetLightiv = procedure(light, pname: GLenum; params: PGLint); cdecl;
  TGLGetMapdv = procedure(target, query: GLenum; v: PGLdouble); cdecl;
  TGLGetMapfv = procedure(target, query: GLenum; v: PGLfloat); cdecl;
  TGLGetMapiv = procedure(target, query: GLenum; v: PGLint); cdecl;
  TGLGetMaterialfv = procedure(face, pname: GLenum; params: PGLfloat); cdecl;
  TGLGetMaterialiv = procedure(face, pname: GLenum; params: PGLint); cdecl;
  TGLGetPixelMapfv = procedure(map: GLenum; values: PGLfloat); cdecl;
  TGLGetPixelMapuiv = procedure(map: GLenum; values: PGLuint); cdecl;
  TGLGetPixelMapusv = procedure(map: GLenum; values: PGLushort); cdecl;
  TGLGetPointerv = procedure(pname: GLenum; params: Pointer); cdecl;
  TGLGetPolygonStipple = procedure(mask: PGLubyte); cdecl;
  TGLGetString = function(Name: GLenum): pansichar; cdecl;
  TGLGetTexEnvfv = procedure(target, pname: GLenum; params: PGLfloat); cdecl;
  TGLGetTexEnviv = procedure(target, pname: GLenum; params: PGLint); cdecl;
  TGLGetTexGendv = procedure(coord, pname: GLenum; params: PGLdouble); cdecl;
  TGLGetTexGenfv = procedure(coord, pname: GLenum; params: PGLfloat); cdecl;
  TGLGetTexGeniv = procedure(coord, pname: GLenum; params: PGLint); cdecl;
  TGLGetTexImage = procedure(target: GLenum; level: GLint; format: GLenum; atype: GLenum; pixels: Pointer); cdecl;
  TGLGetTexLevelParameterfv = procedure(target: GLenum; level: GLint; pname: GLenum; params: Pointer); cdecl;
  TGLGetTexLevelParameteriv = procedure(target: GLenum; level: GLint; pname: GLenum; params: PGLint); cdecl;
  TGLGetTexParameterfv = procedure(target, pname: GLenum; params: PGLfloat); cdecl;
  TGLGetTexParameteriv = procedure(target, pname: GLenum; params: PGLint); cdecl;
  TGLHint = procedure(target, mode: GLenum); cdecl;
  TGLIndexMask = procedure(mask: GLuint); cdecl;
  TGLIndexPointer = procedure(atype: GLenum; stride: GLsizei; const pointer: Pointer); cdecl;
  TGLIndexd = procedure(c: GLdouble); cdecl;
  TGLIndexdv = procedure(const c: PGLdouble); cdecl;
  TGLIndexf = procedure(c: GLfloat); cdecl;
  TGLIndexfv = procedure(const c: PGLfloat); cdecl;
  TGLIndexi = procedure(c: GLint); cdecl;
  TGLIndexiv = procedure(const c: PGLint); cdecl;
  TGLIndexs = procedure(c: GLshort); cdecl;
  TGLIndexsv = procedure(const c: PGLshort); cdecl;
  TGLIndexub = procedure(c: GLubyte); cdecl;
  TGLIndexubv = procedure(const c: PGLubyte); cdecl;
  TGLInitNames = procedure; cdecl;
  TGLInterleavedArrays = procedure(format: GLenum; stride: GLsizei; const pointer: Pointer); cdecl;
  TGLIsEnabled = function(cap: GLenum): GLboolean; cdecl;
  TGLIsList = function(list: GLuint): GLboolean; cdecl;
  TGLIsTexture = function(texture: GLuint): GLboolean; cdecl;
  TGLLightModelf = procedure(pname: GLenum; param: GLfloat); cdecl;
  TGLLightModelfv = procedure(pname: GLenum; const params: PGLfloat); cdecl;
  TGLLightModeli = procedure(pname: GLenum; param: GLint); cdecl;
  TGLLightModeliv = procedure(pname: GLenum; const params: PGLint); cdecl;
  TGLLightf = procedure(light, pname: GLenum; param: GLfloat); cdecl;
  TGLLightfv = procedure(light, pname: GLenum; const params: PGLfloat); cdecl;
  TGLLighti = procedure(light, pname: GLenum; param: GLint); cdecl;
  TGLLightiv = procedure(light, pname: GLenum; const params: PGLint); cdecl;
  TGLLineStipple = procedure(factor: GLint; pattern: GLushort); cdecl;
  TGLLineWidth = procedure(Width: GLfloat); cdecl;
  TGLListBase = procedure(base: GLuint); cdecl;
  TGLLoadIdentity = procedure; cdecl;
  TGLLoadMatrixd = procedure(const m: PGLdouble); cdecl;
  TGLLoadMatrixf = procedure(const m: PGLfloat); cdecl;
  TGLLoadName = procedure(Name: GLuint); cdecl;
  TGLLogicOp = procedure(opcode: GLenum); cdecl;
  TGLMap1d = procedure(target: GLenum; u1, u2: GLdouble; stride, order: GLint; const points: PGLdouble); cdecl;
  TGLMap1f = procedure(target: GLenum; u1, u2: GLfloat; stride, order: GLint; const points: PGLfloat); cdecl;
  TGLMap2d = procedure(target: GLenum; u1, u2: GLdouble; ustride, uorder: GLint; v1, v2: GLdouble; vstride, vorder: GLint; const points: PGLdouble); cdecl;
  TGLMap2f = procedure(target: GLenum; u1, u2: GLfloat; ustride, uorder: GLint; v1, v2: GLfloat; vstride, vorder: GLint; const points: PGLfloat); cdecl;
  TGLMapGrid1d = procedure(un: GLint; u1, u2: GLdouble); cdecl;
  TGLMapGrid1f = procedure(un: GLint; u1, u2: GLfloat); cdecl;
  TGLMapGrid2d = procedure(un: GLint; u1, u2: GLdouble; vn: GLint; v1, v2: GLdouble); cdecl;
  TGLMapGrid2f = procedure(un: GLint; u1, u2: GLfloat; vn: GLint; v1, v2: GLfloat); cdecl;
  TGLMaterialf = procedure(face, pname: GLenum; param: GLfloat); cdecl;
  TGLMaterialfv = procedure(face, pname: GLenum; const params: PGLfloat); cdecl;
  TGLMateriali = procedure(face, pname: GLenum; param: GLint); cdecl;
  TGLMaterialiv = procedure(face, pname: GLenum; const params: PGLint); cdecl;
  TGLMatrixMode = procedure(mode: GLenum); cdecl;
  TGLMultMatrixd = procedure(const m: PGLdouble); cdecl;
  TGLMultMatrixf = procedure(const m: PGLfloat); cdecl;
  TGLNewList = procedure(list: GLuint; mode: GLenum); cdecl;
  TGLNormal3b = procedure(nx, ny, nz: GLbyte); cdecl;
  TGLNormal3bv = procedure(const v: PGLbyte); cdecl;
  TGLNormal3d = procedure(nx, ny, nz: GLdouble); cdecl;
  TGLNormal3dv = procedure(const v: PGLdouble); cdecl;
  TGLNormal3f = procedure(nx, ny, nz: GLfloat); cdecl;
  TGLNormal3fv = procedure(const v: PGLfloat); cdecl;
  TGLNormal3i = procedure(nx, ny, nz: GLint); cdecl;
  TGLNormal3iv = procedure(const v: PGLint); cdecl;
  TGLNormal3s = procedure(nx, ny, nz: GLshort); cdecl;
  TGLNormal3sv = procedure(const v: PGLshort); cdecl;
  TGLNormalPointer = procedure(atype: GLenum; stride: GLsizei; const pointer: Pointer); cdecl;
  TGLOrtho = procedure(left, right, bottom, top, zNear, zFar: GLdouble); cdecl;
  TGLPassThrough = procedure(token: GLfloat); cdecl;
  TGLPixelMapfv = procedure(map: GLenum; mapsize: GLint; const values: PGLfloat); cdecl;
  TGLPixelMapuiv = procedure(map: GLenum; mapsize: GLint; const values: PGLuint); cdecl;
  TGLPixelMapusv = procedure(map: GLenum; mapsize: GLint; const values: PGLushort); cdecl;
  TGLPixelStoref = procedure(pname: GLenum; param: GLfloat); cdecl;
  TGLPixelStorei = procedure(pname: GLenum; param: GLint); cdecl;
  TGLPixelTransferf = procedure(pname: GLenum; param: GLfloat); cdecl;
  TGLPixelTransferi = procedure(pname: GLenum; param: GLint); cdecl;
  TGLPixelZoom = procedure(xfactor, yfactor: GLfloat); cdecl;
  TGLPointSize = procedure(size: GLfloat); cdecl;
  TGLPolygonMode = procedure(face, mode: GLenum); cdecl;
  TGLPolygonOffset = procedure(factor, units: GLfloat); cdecl;
  TGLPolygonStipple = procedure(const mask: PGLubyte); cdecl;
  TGLPopAttrib = procedure; cdecl;
  TGLPopClientAttrib = procedure; cdecl;
  TGLPopMatrix = procedure; cdecl;
  TGLPopName = procedure; cdecl;
  TGLPrioritizeTextures = procedure(n: GLsizei; const textures: PGLuint; const priorities: PGLclampf); cdecl;
  TGLPushAttrib = procedure(mask: GLbitfield); cdecl;
  TGLPushClientAttrib = procedure(mask: GLbitfield); cdecl;
  TGLPushMatrix = procedure; cdecl;
  TGLPushName = procedure(Name: GLuint); cdecl;
  TGLRasterPos2d = procedure(x, y: GLdouble); cdecl;
  TGLRasterPos2dv = procedure(const v: PGLdouble); cdecl;
  TGLRasterPos2f = procedure(x, y: GLfloat); cdecl;
  TGLRasterPos2fv = procedure(const v: PGLfloat); cdecl;
  TGLRasterPos2i = procedure(x, y: GLint); cdecl;
  TGLRasterPos2iv = procedure(const v: PGLint); cdecl;
  TGLRasterPos2s = procedure(x, y: GLshort); cdecl;
  TGLRasterPos2sv = procedure(const v: PGLshort); cdecl;
  TGLRasterPos3d = procedure(x, y, z: GLdouble); cdecl;
  TGLRasterPos3dv = procedure(const v: PGLdouble); cdecl;
  TGLRasterPos3f = procedure(x, y, z: GLfloat); cdecl;
  TGLRasterPos3fv = procedure(const v: PGLfloat); cdecl;
  TGLRasterPos3i = procedure(x, y, z: GLint); cdecl;
  TGLRasterPos3iv = procedure(const v: PGLint); cdecl;
  TGLRasterPos3s = procedure(x, y, z: GLshort); cdecl;
  TGLRasterPos3sv = procedure(const v: PGLshort); cdecl;
  TGLRasterPos4d = procedure(x, y, z, w: GLdouble); cdecl;
  TGLRasterPos4dv = procedure(const v: PGLdouble); cdecl;
  TGLRasterPos4f = procedure(x, y, z, w: GLfloat); cdecl;
  TGLRasterPos4fv = procedure(const v: PGLfloat); cdecl;
  TGLRasterPos4i = procedure(x, y, z, w: GLint); cdecl;
  TGLRasterPos4iv = procedure(const v: PGLint); cdecl;
  TGLRasterPos4s = procedure(x, y, z, w: GLshort); cdecl;
  TGLRasterPos4sv = procedure(const v: PGLshort); cdecl;
  TGLReadBuffer = procedure(mode: GLenum); cdecl;
  TGLReadPixels = procedure(x, y: GLint; Width, Height: GLsizei; format, atype: GLenum; pixels: Pointer); cdecl;
  TGLRectd = procedure(x1, y1, x2, y2: GLdouble); cdecl;
  TGLRectdv = procedure(const v1: PGLdouble; const v2: PGLdouble); cdecl;
  TGLRectf = procedure(x1, y1, x2, y2: GLfloat); cdecl;
  TGLRectfv = procedure(const v1: PGLfloat; const v2: PGLfloat); cdecl;
  TGLRecti = procedure(x1, y1, x2, y2: GLint); cdecl;
  TGLRectiv = procedure(const v1: PGLint; const v2: PGLint); cdecl;
  TGLRects = procedure(x1, y1, x2, y2: GLshort); cdecl;
  TGLRectsv = procedure(const v1: PGLshort; const v2: PGLshort); cdecl;
  TGLRenderMode = function(mode: GLint): GLint; cdecl;
  TGLRotated = procedure(angle, x, y, z: GLdouble); cdecl;
  TGLRotatef = procedure(angle, x, y, z: GLfloat); cdecl;
  TGLScaled = procedure(x, y, z: GLdouble); cdecl;
  TGLScalef = procedure(x, y, z: GLfloat); cdecl;
  TGLScissor = procedure(x, y: GLint; Width, Height: GLsizei); cdecl;
  TGLSelectBuffer = procedure(size: GLsizei; buffer: PGLuint); cdecl;
  TGLShadeModel = procedure(mode: GLenum); cdecl;
  TGLStencilFunc = procedure(func: GLenum; ref: GLint; mask: GLuint); cdecl;
  TGLStencilMask = procedure(mask: GLuint); cdecl;
  TGLStencilOp = procedure(fail, zfail, zpass: GLenum); cdecl;
  TGLTexCoord1d = procedure(s: GLdouble); cdecl;
  TGLTexCoord1dv = procedure(const v: PGLdouble); cdecl;
  TGLTexCoord1f = procedure(s: GLfloat); cdecl;
  TGLTexCoord1fv = procedure(const v: PGLfloat); cdecl;
  TGLTexCoord1i = procedure(s: GLint); cdecl;
  TGLTexCoord1iv = procedure(const v: PGLint); cdecl;
  TGLTexCoord1s = procedure(s: GLshort); cdecl;
  TGLTexCoord1sv = procedure(const v: PGLshort); cdecl;
  TGLTexCoord2d = procedure(s, t: GLdouble); cdecl;
  TGLTexCoord2dv = procedure(const v: PGLdouble); cdecl;
  TGLTexCoord2f = procedure(s, t: GLfloat); cdecl;
  TGLTexCoord2fv = procedure(const v: PGLfloat); cdecl;
  TGLTexCoord2i = procedure(s, t: GLint); cdecl;
  TGLTexCoord2iv = procedure(const v: PGLint); cdecl;
  TGLTexCoord2s = procedure(s, t: GLshort); cdecl;
  TGLTexCoord2sv = procedure(const v: PGLshort); cdecl;
  TGLTexCoord3d = procedure(s, t, r: GLdouble); cdecl;
  TGLTexCoord3dv = procedure(const v: PGLdouble); cdecl;
  TGLTexCoord3f = procedure(s, t, r: GLfloat); cdecl;
  TGLTexCoord3fv = procedure(const v: PGLfloat); cdecl;
  TGLTexCoord3i = procedure(s, t, r: GLint); cdecl;
  TGLTexCoord3iv = procedure(const v: PGLint); cdecl;
  TGLTexCoord3s = procedure(s, t, r: GLshort); cdecl;
  TGLTexCoord3sv = procedure(const v: PGLshort); cdecl;
  TGLTexCoord4d = procedure(s, t, r, q: GLdouble); cdecl;
  TGLTexCoord4dv = procedure(const v: PGLdouble); cdecl;
  TGLTexCoord4f = procedure(s, t, r, q: GLfloat); cdecl;
  TGLTexCoord4fv = procedure(const v: PGLfloat); cdecl;
  TGLTexCoord4i = procedure(s, t, r, q: GLint); cdecl;
  TGLTexCoord4iv = procedure(const v: PGLint); cdecl;
  TGLTexCoord4s = procedure(s, t, r, q: GLshort); cdecl;
  TGLTexCoord4sv = procedure(const v: PGLshort); cdecl;
  TGLTexCoordPointer = procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); cdecl;
  TGLTexEnvf = procedure(target: GLenum; pname: GLenum; param: GLfloat); cdecl;
  TGLTexEnvfv = procedure(target: GLenum; pname: GLenum; const params: PGLfloat); cdecl;
  TGLTexEnvi = procedure(target: GLenum; pname: GLenum; param: GLint); cdecl;
  TGLTexEnviv = procedure(target: GLenum; pname: GLenum; const params: PGLint); cdecl;
  TGLTexGend = procedure(coord: GLenum; pname: GLenum; param: GLdouble); cdecl;
  TGLTexGendv = procedure(coord: GLenum; pname: GLenum; const params: PGLdouble); cdecl;
  TGLTexGenf = procedure(coord: GLenum; pname: GLenum; param: GLfloat); cdecl;
  TGLTexGenfv = procedure(coord: GLenum; pname: GLenum; const params: PGLfloat); cdecl;
  TGLTexGeni = procedure(coord: GLenum; pname: GLenum; param: GLint); cdecl;
  TGLTexGeniv = procedure(coord: GLenum; pname: GLenum; const params: PGLint); cdecl;
  TGLTexImage1D = procedure(target: GLenum; level: GLInt; internalformat: GLEnum; Width: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer); cdecl;
  TGLTexImage2D = procedure(target: GLenum; level: GLInt; internalformat: GLEnum; Width, Height: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer); cdecl;
  TGLTexParameterf = procedure(target: GLenum; pname: GLenum; param: GLfloat); cdecl;
  TGLTexParameterfv = procedure(target: GLenum; pname: GLenum; const params: PGLfloat); cdecl;
  TGLTexParameteri = procedure(target: GLenum; pname: GLenum; param: GLint); cdecl;
  TGLTexParameteriv = procedure(target: GLenum; pname: GLenum; const params: PGLint); cdecl;
  TGLTexSubImage1D = procedure(target: GLenum; level, xoffset: GLint; Width: GLsizei; format, atype: GLenum; const pixels: Pointer); cdecl;
  TGLTexSubImage2D = procedure(target: GLenum; level, xoffset, yoffset: GLint; Width, Height: GLsizei; format, atype: GLenum; const pixels: Pointer); cdecl;
  TGLTranslated = procedure(x, y, z: GLdouble); cdecl;
  TGLTranslatef = procedure(x, y, z: GLfloat); cdecl;
  TGLVertex2d = procedure(x, y: GLdouble); cdecl;
  TGLVertex2dv = procedure(const v: PGLdouble); cdecl;
  TGLVertex2f = procedure(x, y: GLfloat); cdecl;
  TGLVertex2fv = procedure(const v: PGLfloat); cdecl;
  TGLVertex2i = procedure(x, y: GLint); cdecl;
  TGLVertex2iv = procedure(const v: PGLint); cdecl;
  TGLVertex2s = procedure(x, y: GLshort); cdecl;
  TGLVertex2sv = procedure(const v: PGLshort); cdecl;
  TGLVertex3d = procedure(x, y, z: GLdouble); cdecl;
  TGLVertex3dv = procedure(const v: PGLdouble); cdecl;
  TGLVertex3f = procedure(x, y, z: GLfloat); cdecl;
  TGLVertex3fv = procedure(const v: PGLfloat); cdecl;
  TGLVertex3i = procedure(x, y, z: GLint); cdecl;
  TGLVertex3iv = procedure(const v: PGLint); cdecl;
  TGLVertex3s = procedure(x, y, z: GLshort); cdecl;
  TGLVertex3sv = procedure(const v: PGLshort); cdecl;
  TGLVertex4d = procedure(x, y, z, w: GLdouble); cdecl;
  TGLVertex4dv = procedure(const v: PGLdouble); cdecl;
  TGLVertex4f = procedure(x, y, z, w: GLfloat); cdecl;
  TGLVertex4fv = procedure(const v: PGLfloat); cdecl;
  TGLVertex4i = procedure(x, y, z, w: GLint); cdecl;
  TGLVertex4iv = procedure(const v: PGLint); cdecl;
  TGLVertex4s = procedure(x, y, z, w: GLshort); cdecl;
  TGLVertex4sv = procedure(const v: PGLshort); cdecl;
  TGLVertexPointer = procedure(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer); cdecl;
  TGLViewport = procedure(x, y: GLint; Width, Height: GLsizei); cdecl;

type
  { TGLLibrary }

  TGLLibrary = class(TMangagedLibrary)
  private
    FGLAccum: TGLAccum;
    FGLAlphaFunc: TGLAlphaFunc;
    FGLAreTexturesResident: TGLAreTexturesResident;
    FGLArrayElement: TGLArrayElement;
    FGLBegin: TGLBegin;
    FGLBindTexture: TGLBindTexture;
    FGLBitmap: TGLBitmap;
    FGLBlendFunc: TGLBlendFunc;
    FGLCallList: TGLCallList;
    FGLCallLists: TGLCallLists;
    FGLClear: TGLClear;
    FGLClearAccum: TGLClearAccum;
    FGLClearColor: TGLClearColor;
    FGLClearDepth: TGLClearDepth;
    FGLClearIndex: TGLClearIndex;
    FGLClearStencil: TGLClearStencil;
    FGLClipPlane: TGLClipPlane;
    FGLColor3b: TGLColor3b;
    FGLColor3bv: TGLColor3bv;
    FGLColor3d: TGLColor3d;
    FGLColor3dv: TGLColor3dv;
    FGLColor3f: TGLColor3f;
    FGLColor3fv: TGLColor3fv;
    FGLColor3i: TGLColor3i;
    FGLColor3iv: TGLColor3iv;
    FGLColor3s: TGLColor3s;
    FGLColor3sv: TGLColor3sv;
    FGLColor3ub: TGLColor3ub;
    FGLColor3ubv: TGLColor3ubv;
    FGLColor3ui: TGLColor3ui;
    FGLColor3uiv: TGLColor3uiv;
    FGLColor3us: TGLColor3us;
    FGLColor3usv: TGLColor3usv;
    FGLColor4b: TGLColor4b;
    FGLColor4bv: TGLColor4bv;
    FGLColor4d: TGLColor4d;
    FGLColor4dv: TGLColor4dv;
    FGLColor4f: TGLColor4f;
    FGLColor4fv: TGLColor4fv;
    FGLColor4i: TGLColor4i;
    FGLColor4iv: TGLColor4iv;
    FGLColor4s: TGLColor4s;
    FGLColor4sv: TGLColor4sv;
    FGLColor4ub: TGLColor4ub;
    FGLColor4ubv: TGLColor4ubv;
    FGLColor4ui: TGLColor4ui;
    FGLColor4uiv: TGLColor4uiv;
    FGLColor4us: TGLColor4us;
    FGLColor4usv: TGLColor4usv;
    FGLColorMask: TGLColorMask;
    FGLColorMaterial: TGLColorMaterial;
    FGLColorPointer: TGLColorPointer;
    FGLCopyPixels: TGLCopyPixels;
    FGLCopyTexImage1D: TGLCopyTexImage1D;
    FGLCopyTexImage2D: TGLCopyTexImage2D;
    FGLCopyTexSubImage1D: TGLCopyTexSubImage1D;
    FGLCopyTexSubImage2D: TGLCopyTexSubImage2D;
    FGLCullFace: TGLCullFace;
    FGLDeleteLists: TGLDeleteLists;
    FGLDeleteTextures: TGLDeleteTextures;
    FGLDepthFunc: TGLDepthFunc;
    FGLDepthMask: TGLDepthMask;
    FGLDepthRange: TGLDepthRange;
    FGLDisable: TGLDisable;
    FGLDisableClientState: TGLDisableClientState;
    FGLDrawArrays: TGLDrawArrays;
    FGLDrawBuffer: TGLDrawBuffer;
    FGLDrawElements: TGLDrawElements;
    FGLDrawPixels: TGLDrawPixels;
    FGLEdgeFlag: TGLEdgeFlag;
    FGLEdgeFlagPointer: TGLEdgeFlagPointer;
    FGLEdgeFlagv: TGLEdgeFlagv;
    FGLEnable: TGLEnable;
    FGLEnableClientState: TGLEnableClientState;
    FGLEnd: TGLEnd;
    FGLEndList: TGLEndList;
    FGLEvalCoord1d: TGLEvalCoord1d;
    FGLEvalCoord1dv: TGLEvalCoord1dv;
    FGLEvalCoord1f: TGLEvalCoord1f;
    FGLEvalCoord1fv: TGLEvalCoord1fv;
    FGLEvalCoord2d: TGLEvalCoord2d;
    FGLEvalCoord2dv: TGLEvalCoord2dv;
    FGLEvalCoord2f: TGLEvalCoord2f;
    FGLEvalCoord2fv: TGLEvalCoord2fv;
    FGLEvalMesh1: TGLEvalMesh1;
    FGLEvalMesh2: TGLEvalMesh2;
    FGLEvalPoint1: TGLEvalPoint1;
    FGLEvalPoint2: TGLEvalPoint2;
    FGLFeedbackBuffer: TGLFeedbackBuffer;
    FGLFinish: TGLFinish;
    FGLFlush: TGLFlush;
    FGLFogf: TGLFogf;
    FGLFogfv: TGLFogfv;
    FGLFogi: TGLFogi;
    FGLFogiv: TGLFogiv;
    FGLFrontFace: TGLFrontFace;
    FGLFrustum: TGLFrustum;
    FGLGenLists: TGLGenLists;
    FGLGenTextures: TGLGenTextures;
    FGLGetBooleanv: TGLGetBooleanv;
    FGLGetClipPlane: TGLGetClipPlane;
    FGLGetDoublev: TGLGetDoublev;
    FGLGetError: TGLGetError;
    FGLGetFloatv: TGLGetFloatv;
    FGLGetIntegerv: TGLGetIntegerv;
    FGLGetLightfv: TGLGetLightfv;
    FGLGetLightiv: TGLGetLightiv;
    FGLGetMapdv: TGLGetMapdv;
    FGLGetMapfv: TGLGetMapfv;
    FGLGetMapiv: TGLGetMapiv;
    FGLGetMaterialfv: TGLGetMaterialfv;
    FGLGetMaterialiv: TGLGetMaterialiv;
    FGLGetPixelMapfv: TGLGetPixelMapfv;
    FGLGetPixelMapuiv: TGLGetPixelMapuiv;
    FGLGetPixelMapusv: TGLGetPixelMapusv;
    FGLGetPointerv: TGLGetPointerv;
    FGLGetPolygonStipple: TGLGetPolygonStipple;
    FGLGetString: TGLGetString;
    FGLGetTexEnvfv: TGLGetTexEnvfv;
    FGLGetTexEnviv: TGLGetTexEnviv;
    FGLGetTexGendv: TGLGetTexGendv;
    FGLGetTexGenfv: TGLGetTexGenfv;
    FGLGetTexGeniv: TGLGetTexGeniv;
    FGLGetTexImage: TGLGetTexImage;
    FGLGetTexLevelParameterfv: TGLGetTexLevelParameterfv;
    FGLGetTexLevelParameteriv: TGLGetTexLevelParameteriv;
    FGLGetTexParameterfv: TGLGetTexParameterfv;
    FGLGetTexParameteriv: TGLGetTexParameteriv;
    FGLHint: TGLHint;
    FGLIndexMask: TGLIndexMask;
    FGLIndexPointer: TGLIndexPointer;
    FGLIndexd: TGLIndexd;
    FGLIndexdv: TGLIndexdv;
    FGLIndexf: TGLIndexf;
    FGLIndexfv: TGLIndexfv;
    FGLIndexi: TGLIndexi;
    FGLIndexiv: TGLIndexiv;
    FGLIndexs: TGLIndexs;
    FGLIndexsv: TGLIndexsv;
    FGLIndexub: TGLIndexub;
    FGLIndexubv: TGLIndexubv;
    FGLInitNames: TGLInitNames;
    FGLInterleavedArrays: TGLInterleavedArrays;
    FGLIsEnabled: TGLIsEnabled;
    FGLIsList: TGLIsList;
    FGLIsTexture: TGLIsTexture;
    FGLLightModelf: TGLLightModelf;
    FGLLightModelfv: TGLLightModelfv;
    FGLLightModeli: TGLLightModeli;
    FGLLightModeliv: TGLLightModeliv;
    FGLLightf: TGLLightf;
    FGLLightfv: TGLLightfv;
    FGLLighti: TGLLighti;
    FGLLightiv: TGLLightiv;
    FGLLineStipple: TGLLineStipple;
    FGLLineWidth: TGLLineWidth;
    FGLListBase: TGLListBase;
    FGLLoadIdentity: TGLLoadIdentity;
    FGLLoadMatrixd: TGLLoadMatrixd;
    FGLLoadMatrixf: TGLLoadMatrixf;
    FGLLoadName: TGLLoadName;
    FGLLogicOp: TGLLogicOp;
    FGLMap1d: TGLMap1d;
    FGLMap1f: TGLMap1f;
    FGLMap2d: TGLMap2d;
    FGLMap2f: TGLMap2f;
    FGLMapGrid1d: TGLMapGrid1d;
    FGLMapGrid1f: TGLMapGrid1f;
    FGLMapGrid2d: TGLMapGrid2d;
    FGLMapGrid2f: TGLMapGrid2f;
    FGLMaterialf: TGLMaterialf;
    FGLMaterialfv: TGLMaterialfv;
    FGLMateriali: TGLMateriali;
    FGLMaterialiv: TGLMaterialiv;
    FGLMatrixMode: TGLMatrixMode;
    FGLMultMatrixd: TGLMultMatrixd;
    FGLMultMatrixf: TGLMultMatrixf;
    FGLNewList: TGLNewList;
    FGLNormal3b: TGLNormal3b;
    FGLNormal3bv: TGLNormal3bv;
    FGLNormal3d: TGLNormal3d;
    FGLNormal3dv: TGLNormal3dv;
    FGLNormal3f: TGLNormal3f;
    FGLNormal3fv: TGLNormal3fv;
    FGLNormal3i: TGLNormal3i;
    FGLNormal3iv: TGLNormal3iv;
    FGLNormal3s: TGLNormal3s;
    FGLNormal3sv: TGLNormal3sv;
    FGLNormalPointer: TGLNormalPointer;
    FGLOrtho: TGLOrtho;
    FGLPassThrough: TGLPassThrough;
    FGLPixelMapfv: TGLPixelMapfv;
    FGLPixelMapuiv: TGLPixelMapuiv;
    FGLPixelMapusv: TGLPixelMapusv;
    FGLPixelStoref: TGLPixelStoref;
    FGLPixelStorei: TGLPixelStorei;
    FGLPixelTransferf: TGLPixelTransferf;
    FGLPixelTransferi: TGLPixelTransferi;
    FGLPixelZoom: TGLPixelZoom;
    FGLPointSize: TGLPointSize;
    FGLPolygonMode: TGLPolygonMode;
    FGLPolygonOffset: TGLPolygonOffset;
    FGLPolygonStipple: TGLPolygonStipple;
    FGLPopAttrib: TGLPopAttrib;
    FGLPopClientAttrib: TGLPopClientAttrib;
    FGLPopMatrix: TGLPopMatrix;
    FGLPopName: TGLPopName;
    FGLPrioritizeTextures: TGLPrioritizeTextures;
    FGLPushAttrib: TGLPushAttrib;
    FGLPushClientAttrib: TGLPushClientAttrib;
    FGLPushMatrix: TGLPushMatrix;
    FGLPushName: TGLPushName;
    FGLRasterPos2d: TGLRasterPos2d;
    FGLRasterPos2dv: TGLRasterPos2dv;
    FGLRasterPos2f: TGLRasterPos2f;
    FGLRasterPos2fv: TGLRasterPos2fv;
    FGLRasterPos2i: TGLRasterPos2i;
    FGLRasterPos2iv: TGLRasterPos2iv;
    FGLRasterPos2s: TGLRasterPos2s;
    FGLRasterPos2sv: TGLRasterPos2sv;
    FGLRasterPos3d: TGLRasterPos3d;
    FGLRasterPos3dv: TGLRasterPos3dv;
    FGLRasterPos3f: TGLRasterPos3f;
    FGLRasterPos3fv: TGLRasterPos3fv;
    FGLRasterPos3i: TGLRasterPos3i;
    FGLRasterPos3iv: TGLRasterPos3iv;
    FGLRasterPos3s: TGLRasterPos3s;
    FGLRasterPos3sv: TGLRasterPos3sv;
    FGLRasterPos4d: TGLRasterPos4d;
    FGLRasterPos4dv: TGLRasterPos4dv;
    FGLRasterPos4f: TGLRasterPos4f;
    FGLRasterPos4fv: TGLRasterPos4fv;
    FGLRasterPos4i: TGLRasterPos4i;
    FGLRasterPos4iv: TGLRasterPos4iv;
    FGLRasterPos4s: TGLRasterPos4s;
    FGLRasterPos4sv: TGLRasterPos4sv;
    FGLReadBuffer: TGLReadBuffer;
    FGLReadPixels: TGLReadPixels;
    FGLRectd: TGLRectd;
    FGLRectdv: TGLRectdv;
    FGLRectf: TGLRectf;
    FGLRectfv: TGLRectfv;
    FGLRecti: TGLRecti;
    FGLRectiv: TGLRectiv;
    FGLRects: TGLRects;
    FGLRectsv: TGLRectsv;
    FGLRenderMode: TGLRenderMode;
    FGLRotated: TGLRotated;
    FGLRotatef: TGLRotatef;
    FGLScaled: TGLScaled;
    FGLScalef: TGLScalef;
    FGLScissor: TGLScissor;
    FGLSelectBuffer: TGLSelectBuffer;
    FGLShadeModel: TGLShadeModel;
    FGLStencilFunc: TGLStencilFunc;
    FGLStencilMask: TGLStencilMask;
    FGLStencilOp: TGLStencilOp;
    FGLTexCoord1d: TGLTexCoord1d;
    FGLTexCoord1dv: TGLTexCoord1dv;
    FGLTexCoord1f: TGLTexCoord1f;
    FGLTexCoord1fv: TGLTexCoord1fv;
    FGLTexCoord1i: TGLTexCoord1i;
    FGLTexCoord1iv: TGLTexCoord1iv;
    FGLTexCoord1s: TGLTexCoord1s;
    FGLTexCoord1sv: TGLTexCoord1sv;
    FGLTexCoord2d: TGLTexCoord2d;
    FGLTexCoord2dv: TGLTexCoord2dv;
    FGLTexCoord2f: TGLTexCoord2f;
    FGLTexCoord2fv: TGLTexCoord2fv;
    FGLTexCoord2i: TGLTexCoord2i;
    FGLTexCoord2iv: TGLTexCoord2iv;
    FGLTexCoord2s: TGLTexCoord2s;
    FGLTexCoord2sv: TGLTexCoord2sv;
    FGLTexCoord3d: TGLTexCoord3d;
    FGLTexCoord3dv: TGLTexCoord3dv;
    FGLTexCoord3f: TGLTexCoord3f;
    FGLTexCoord3fv: TGLTexCoord3fv;
    FGLTexCoord3i: TGLTexCoord3i;
    FGLTexCoord3iv: TGLTexCoord3iv;
    FGLTexCoord3s: TGLTexCoord3s;
    FGLTexCoord3sv: TGLTexCoord3sv;
    FGLTexCoord4d: TGLTexCoord4d;
    FGLTexCoord4dv: TGLTexCoord4dv;
    FGLTexCoord4f: TGLTexCoord4f;
    FGLTexCoord4fv: TGLTexCoord4fv;
    FGLTexCoord4i: TGLTexCoord4i;
    FGLTexCoord4iv: TGLTexCoord4iv;
    FGLTexCoord4s: TGLTexCoord4s;
    FGLTexCoord4sv: TGLTexCoord4sv;
    FGLTexCoordPointer: TGLTexCoordPointer;
    FGLTexEnvf: TGLTexEnvf;
    FGLTexEnvfv: TGLTexEnvfv;
    FGLTexEnvi: TGLTexEnvi;
    FGLTexEnviv: TGLTexEnviv;
    FGLTexGend: TGLTexGend;
    FGLTexGendv: TGLTexGendv;
    FGLTexGenf: TGLTexGenf;
    FGLTexGenfv: TGLTexGenfv;
    FGLTexGeni: TGLTexGeni;
    FGLTexGeniv: TGLTexGeniv;
    FGLTexImage1D: TGLTexImage1D;
    FGLTexImage2D: TGLTexImage2D;
    FGLTexParameterf: TGLTexParameterf;
    FGLTexParameterfv: TGLTexParameterfv;
    FGLTexParameteri: TGLTexParameteri;
    FGLTexParameteriv: TGLTexParameteriv;
    FGLTexSubImage1D: TGLTexSubImage1D;
    FGLTexSubImage2D: TGLTexSubImage2D;
    FGLTranslated: TGLTranslated;
    FGLTranslatef: TGLTranslatef;
    FGLVertex2d: TGLVertex2d;
    FGLVertex2dv: TGLVertex2dv;
    FGLVertex2f: TGLVertex2f;
    FGLVertex2fv: TGLVertex2fv;
    FGLVertex2i: TGLVertex2i;
    FGLVertex2iv: TGLVertex2iv;
    FGLVertex2s: TGLVertex2s;
    FGLVertex2sv: TGLVertex2sv;
    FGLVertex3d: TGLVertex3d;
    FGLVertex3dv: TGLVertex3dv;
    FGLVertex3f: TGLVertex3f;
    FGLVertex3fv: TGLVertex3fv;
    FGLVertex3i: TGLVertex3i;
    FGLVertex3iv: TGLVertex3iv;
    FGLVertex3s: TGLVertex3s;
    FGLVertex3sv: TGLVertex3sv;
    FGLVertex4d: TGLVertex4d;
    FGLVertex4dv: TGLVertex4dv;
    FGLVertex4f: TGLVertex4f;
    FGLVertex4fv: TGLVertex4fv;
    FGLVertex4i: TGLVertex4i;
    FGLVertex4iv: TGLVertex4iv;
    FGLVertex4s: TGLVertex4s;
    FGLVertex4sv: TGLVertex4sv;
    FGLVertexPointer: TGLVertexPointer;
    FGLViewport: TGLViewport;
  public
    constructor Create; reintroduce;
    procedure bindEntries; override;
  public
    procedure glAccum(op: GLenum; Value: GLfloat);
    procedure glAlphaFunc(func: GLenum; ref: GLclampf);
    function glAreTexturesResident(n: GLsizei; const textures: PGLuint; residences: PGLboolean): GLboolean;
    procedure glArrayElement(i: GLint);
    procedure glBegin(mode: GLenum);
    procedure glBindTexture(target: GLenum; texture: GLuint);
    procedure glBitmap(Width, Height: GLsizei; xorig, yorig: GLfloat; xmove, ymove: GLfloat; const bitmap: PGLubyte);
    procedure glBlendFunc(sfactor, dfactor: GLenum);
    procedure glCallList(list: GLuint);
    procedure glCallLists(n: GLsizei; atype: GLenum; const lists: Pointer);
    procedure glClear(mask: GLbitfield);
    procedure glClearAccum(red, green, blue, alpha: GLfloat);
    procedure glClearColor(red, green, blue, alpha: GLclampf);
    procedure glClearDepth(depth: GLclampd);
    procedure glClearIndex(c: GLfloat);
    procedure glClearStencil(s: GLint);
    procedure glClipPlane(plane: GLenum; const equation: PGLdouble);
    procedure glColor3b(red, green, blue: GLbyte);
    procedure glColor3bv(const v: PGLbyte);
    procedure glColor3d(red, green, blue: GLdouble);
    procedure glColor3dv(const v: PGLdouble);
    procedure glColor3f(red, green, blue: GLfloat);
    procedure glColor3fv(const v: PGLfloat);
    procedure glColor3i(red, green, blue: GLint);
    procedure glColor3iv(const v: PGLint);
    procedure glColor3s(red, green, blue: GLshort);
    procedure glColor3sv(const v: PGLshort);
    procedure glColor3ub(red, green, blue: GLubyte);
    procedure glColor3ubv(const v: PGLubyte);
    procedure glColor3ui(red, green, blue: GLuint);
    procedure glColor3uiv(const v: PGLuint);
    procedure glColor3us(red, green, blue: GLushort);
    procedure glColor3usv(const v: PGLushort);
    procedure glColor4b(red, green, blue, alpha: GLbyte);
    procedure glColor4bv(const v: PGLbyte);
    procedure glColor4d(red, green, blue, alpha: GLdouble);
    procedure glColor4dv(const v: PGLdouble);
    procedure glColor4f(red, green, blue, alpha: GLfloat);
    procedure glColor4fv(const v: PGLfloat);
    procedure glColor4i(red, green, blue, alpha: GLint);
    procedure glColor4iv(const v: PGLint);
    procedure glColor4s(red, green, blue, alpha: GLshort);
    procedure glColor4sv(const v: PGLshort);
    procedure glColor4ub(red, green, blue, alpha: GLubyte);
    procedure glColor4ubv(const v: PGLubyte);
    procedure glColor4ui(red, green, blue, alpha: GLuint);
    procedure glColor4uiv(const v: PGLuint);
    procedure glColor4us(red, green, blue, alpha: GLushort);
    procedure glColor4usv(const v: PGLushort);
    procedure glColorMask(red, green, blue, alpha: GLboolean);
    procedure glColorMaterial(face, mode: GLenum);
    procedure glColorPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer);
    procedure glCopyPixels(x, y: GLint; Width, Height: GLsizei; atype: GLenum);
    procedure glCopyTexImage1D(target: GLenum; level: GLint; internalFormat: GLenum; x, y: GLint; Width: GLsizei; border: GLint);
    procedure glCopyTexImage2D(target: GLenum; level: GLint; internalFormat: GLenum; x, y: GLint; Width, Height: GLsizei; border: GLint);
    procedure glCopyTexSubImage1D(target: GLenum; level, xoffset, x, y: GLint; Width: GLsizei);
    procedure glCopyTexSubImage2D(target: GLenum; level, xoffset, yoffset, x, y: GLint; Width, Height: GLsizei);
    procedure glCullFace(mode: GLenum);
    procedure glDeleteLists(list: GLuint; range: GLsizei);
    procedure glDeleteTextures(n: GLsizei; const textures: PGLuint);
    procedure glDepthFunc(func: GLenum);
    procedure glDepthMask(flag: GLboolean);
    procedure glDepthRange(zNear, zFar: GLclampd);
    procedure glDisable(cap: GLenum);
    procedure glDisableClientState(aarray: GLenum);
    procedure glDrawArrays(mode: GLenum; First: GLint; Count: GLsizei);
    procedure glDrawBuffer(mode: GLenum);
    procedure glDrawElements(mode: GLenum; Count: GLsizei; atype: GLenum; const indices: Pointer);
    procedure glDrawPixels(Width, Height: GLsizei; format, atype: GLenum; const pixels: Pointer);
    procedure glEdgeFlag(flag: GLboolean);
    procedure glEdgeFlagPointer(stride: GLsizei; const pointer: Pointer);
    procedure glEdgeFlagv(const flag: PGLboolean);
    procedure glEnable(cap: GLenum);
    procedure glEnableClientState(aarray: GLenum);
    procedure glEnd;
    procedure glEndList;
    procedure glEvalCoord1d(u: GLdouble);
    procedure glEvalCoord1dv(const u: PGLdouble);
    procedure glEvalCoord1f(u: GLfloat);
    procedure glEvalCoord1fv(const u: PGLfloat);
    procedure glEvalCoord2d(u, v: GLdouble);
    procedure glEvalCoord2dv(const u: PGLdouble);
    procedure glEvalCoord2f(u, v: GLfloat);
    procedure glEvalCoord2fv(const u: PGLfloat);
    procedure glEvalMesh1(mode: GLenum; i1, i2: GLint);
    procedure glEvalMesh2(mode: GLenum; i1, i2, j1, j2: GLint);
    procedure glEvalPoint1(i: GLint);
    procedure glEvalPoint2(i, j: GLint);
    procedure glFeedbackBuffer(size: GLsizei; atype: GLenum; buffer: PGLfloat);
    procedure glFinish;
    procedure glFlush;
    procedure glFogf(pname: GLenum; param: GLfloat);
    procedure glFogfv(pname: GLenum; const params: PGLfloat);
    procedure glFogi(pname: GLenum; param: GLint);
    procedure glFogiv(pname: GLenum; const params: PGLint);
    procedure glFrontFace(mode: GLenum);
    procedure glFrustum(left, right, bottom, top, zNear, zFar: GLdouble);
    function glGenLists(range: GLsizei): GLuint;
    procedure glGenTextures(n: GLsizei; textures: PGLuint);
    procedure glGetBooleanv(pname: GLenum; params: PGLboolean);
    procedure glGetClipPlane(plane: GLenum; equation: PGLdouble);
    procedure glGetDoublev(pname: GLenum; params: PGLdouble);
    function glGetError: GLenum;
    procedure glGetFloatv(pname: GLenum; params: PGLfloat);
    procedure glGetIntegerv(pname: GLenum; params: PGLint);
    procedure glGetLightfv(light, pname: GLenum; params: PGLfloat);
    procedure glGetLightiv(light, pname: GLenum; params: PGLint);
    procedure glGetMapdv(target, query: GLenum; v: PGLdouble);
    procedure glGetMapfv(target, query: GLenum; v: PGLfloat);
    procedure glGetMapiv(target, query: GLenum; v: PGLint);
    procedure glGetMaterialfv(face, pname: GLenum; params: PGLfloat);
    procedure glGetMaterialiv(face, pname: GLenum; params: PGLint);
    procedure glGetPixelMapfv(map: GLenum; values: PGLfloat);
    procedure glGetPixelMapuiv(map: GLenum; values: PGLuint);
    procedure glGetPixelMapusv(map: GLenum; values: PGLushort);
    procedure glGetPointerv(pname: GLenum; params: Pointer);
    procedure glGetPolygonStipple(mask: PGLubyte);
    function glGetString(Name: GLenum): pansichar;
    procedure glGetTexEnvfv(target, pname: GLenum; params: PGLfloat);
    procedure glGetTexEnviv(target, pname: GLenum; params: PGLint);
    procedure glGetTexGendv(coord, pname: GLenum; params: PGLdouble);
    procedure glGetTexGenfv(coord, pname: GLenum; params: PGLfloat);
    procedure glGetTexGeniv(coord, pname: GLenum; params: PGLint);
    procedure glGetTexImage(target: GLenum; level: GLint; format: GLenum; atype: GLenum; pixels: Pointer);
    procedure glGetTexLevelParameterfv(target: GLenum; level: GLint; pname: GLenum; params: Pointer);
    procedure glGetTexLevelParameteriv(target: GLenum; level: GLint; pname: GLenum; params: PGLint);
    procedure glGetTexParameterfv(target, pname: GLenum; params: PGLfloat);
    procedure glGetTexParameteriv(target, pname: GLenum; params: PGLint);
    procedure glHint(target, mode: GLenum);
    procedure glIndexMask(mask: GLuint);
    procedure glIndexPointer(atype: GLenum; stride: GLsizei; const pointer: Pointer);
    procedure glIndexd(c: GLdouble);
    procedure glIndexdv(const c: PGLdouble);
    procedure glIndexf(c: GLfloat);
    procedure glIndexfv(const c: PGLfloat);
    procedure glIndexi(c: GLint);
    procedure glIndexiv(const c: PGLint);
    procedure glIndexs(c: GLshort);
    procedure glIndexsv(const c: PGLshort);
    procedure glIndexub(c: GLubyte);
    procedure glIndexubv(const c: PGLubyte);
    procedure glInitNames;
    procedure glInterleavedArrays(format: GLenum; stride: GLsizei; const pointer: Pointer);
    function glIsEnabled(cap: GLenum): GLboolean;
    function glIsList(list: GLuint): GLboolean;
    function glIsTexture(texture: GLuint): GLboolean;
    procedure glLightModelf(pname: GLenum; param: GLfloat);
    procedure glLightModelfv(pname: GLenum; const params: PGLfloat);
    procedure glLightModeli(pname: GLenum; param: GLint);
    procedure glLightModeliv(pname: GLenum; const params: PGLint);
    procedure glLightf(light, pname: GLenum; param: GLfloat);
    procedure glLightfv(light, pname: GLenum; const params: PGLfloat);
    procedure glLighti(light, pname: GLenum; param: GLint);
    procedure glLightiv(light, pname: GLenum; const params: PGLint);
    procedure glLineStipple(factor: GLint; pattern: GLushort);
    procedure glLineWidth(Width: GLfloat);
    procedure glListBase(base: GLuint);
    procedure glLoadIdentity;
    procedure glLoadMatrixd(const m: PGLdouble);
    procedure glLoadMatrixf(const m: PGLfloat);
    procedure glLoadName(Name: GLuint);
    procedure glLogicOp(opcode: GLenum);
    procedure glMap1d(target: GLenum; u1, u2: GLdouble; stride, order: GLint; const points: PGLdouble);
    procedure glMap1f(target: GLenum; u1, u2: GLfloat; stride, order: GLint; const points: PGLfloat);
    procedure glMap2d(target: GLenum; u1, u2: GLdouble; ustride, uorder: GLint; v1, v2: GLdouble; vstride, vorder: GLint; const points: PGLdouble);
    procedure glMap2f(target: GLenum; u1, u2: GLfloat; ustride, uorder: GLint; v1, v2: GLfloat; vstride, vorder: GLint; const points: PGLfloat);
    procedure glMapGrid1d(un: GLint; u1, u2: GLdouble);
    procedure glMapGrid1f(un: GLint; u1, u2: GLfloat);
    procedure glMapGrid2d(un: GLint; u1, u2: GLdouble; vn: GLint; v1, v2: GLdouble);
    procedure glMapGrid2f(un: GLint; u1, u2: GLfloat; vn: GLint; v1, v2: GLfloat);
    procedure glMaterialf(face, pname: GLenum; param: GLfloat);
    procedure glMaterialfv(face, pname: GLenum; const params: PGLfloat);
    procedure glMateriali(face, pname: GLenum; param: GLint);
    procedure glMaterialiv(face, pname: GLenum; const params: PGLint);
    procedure glMatrixMode(mode: GLenum);
    procedure glMultMatrixd(const m: PGLdouble);
    procedure glMultMatrixf(const m: PGLfloat);
    procedure glNewList(list: GLuint; mode: GLenum);
    procedure glNormal3b(nx, ny, nz: GLbyte);
    procedure glNormal3bv(const v: PGLbyte);
    procedure glNormal3d(nx, ny, nz: GLdouble);
    procedure glNormal3dv(const v: PGLdouble);
    procedure glNormal3f(nx, ny, nz: GLfloat);
    procedure glNormal3fv(const v: PGLfloat);
    procedure glNormal3i(nx, ny, nz: GLint);
    procedure glNormal3iv(const v: PGLint);
    procedure glNormal3s(nx, ny, nz: GLshort);
    procedure glNormal3sv(const v: PGLshort);
    procedure glNormalPointer(atype: GLenum; stride: GLsizei; const pointer: Pointer);
    procedure glOrtho(left, right, bottom, top, zNear, zFar: GLdouble);
    procedure glPassThrough(token: GLfloat);
    procedure glPixelMapfv(map: GLenum; mapsize: GLint; const values: PGLfloat);
    procedure glPixelMapuiv(map: GLenum; mapsize: GLint; const values: PGLuint);
    procedure glPixelMapusv(map: GLenum; mapsize: GLint; const values: PGLushort);
    procedure glPixelStoref(pname: GLenum; param: GLfloat);
    procedure glPixelStorei(pname: GLenum; param: GLint);
    procedure glPixelTransferf(pname: GLenum; param: GLfloat);
    procedure glPixelTransferi(pname: GLenum; param: GLint);
    procedure glPixelZoom(xfactor, yfactor: GLfloat);
    procedure glPointSize(size: GLfloat);
    procedure glPolygonMode(face, mode: GLenum);
    procedure glPolygonOffset(factor, units: GLfloat);
    procedure glPolygonStipple(const mask: PGLubyte);
    procedure glPopAttrib;
    procedure glPopClientAttrib;
    procedure glPopMatrix;
    procedure glPopName;
    procedure glPrioritizeTextures(n: GLsizei; const textures: PGLuint; const priorities: PGLclampf);
    procedure glPushAttrib(mask: GLbitfield);
    procedure glPushClientAttrib(mask: GLbitfield);
    procedure glPushMatrix;
    procedure glPushName(Name: GLuint);
    procedure glRasterPos2d(x, y: GLdouble);
    procedure glRasterPos2dv(const v: PGLdouble);
    procedure glRasterPos2f(x, y: GLfloat);
    procedure glRasterPos2fv(const v: PGLfloat);
    procedure glRasterPos2i(x, y: GLint);
    procedure glRasterPos2iv(const v: PGLint);
    procedure glRasterPos2s(x, y: GLshort);
    procedure glRasterPos2sv(const v: PGLshort);
    procedure glRasterPos3d(x, y, z: GLdouble);
    procedure glRasterPos3dv(const v: PGLdouble);
    procedure glRasterPos3f(x, y, z: GLfloat);
    procedure glRasterPos3fv(const v: PGLfloat);
    procedure glRasterPos3i(x, y, z: GLint);
    procedure glRasterPos3iv(const v: PGLint);
    procedure glRasterPos3s(x, y, z: GLshort);
    procedure glRasterPos3sv(const v: PGLshort);
    procedure glRasterPos4d(x, y, z, w: GLdouble);
    procedure glRasterPos4dv(const v: PGLdouble);
    procedure glRasterPos4f(x, y, z, w: GLfloat);
    procedure glRasterPos4fv(const v: PGLfloat);
    procedure glRasterPos4i(x, y, z, w: GLint);
    procedure glRasterPos4iv(const v: PGLint);
    procedure glRasterPos4s(x, y, z, w: GLshort);
    procedure glRasterPos4sv(const v: PGLshort);
    procedure glReadBuffer(mode: GLenum);
    procedure glReadPixels(x, y: GLint; Width, Height: GLsizei; format, atype: GLenum; pixels: Pointer);
    procedure glRectd(x1, y1, x2, y2: GLdouble);
    procedure glRectdv(const v1: PGLdouble; const v2: PGLdouble);
    procedure glRectf(x1, y1, x2, y2: GLfloat);
    procedure glRectfv(const v1: PGLfloat; const v2: PGLfloat);
    procedure glRecti(x1, y1, x2, y2: GLint);
    procedure glRectiv(const v1: PGLint; const v2: PGLint);
    procedure glRects(x1, y1, x2, y2: GLshort);
    procedure glRectsv(const v1: PGLshort; const v2: PGLshort);
    function glRenderMode(mode: GLint): GLint;
    procedure glRotated(angle, x, y, z: GLdouble);
    procedure glRotatef(angle, x, y, z: GLfloat);
    procedure glScaled(x, y, z: GLdouble);
    procedure glScalef(x, y, z: GLfloat);
    procedure glScissor(x, y: GLint; Width, Height: GLsizei);
    procedure glSelectBuffer(size: GLsizei; buffer: PGLuint);
    procedure glShadeModel(mode: GLenum);
    procedure glStencilFunc(func: GLenum; ref: GLint; mask: GLuint);
    procedure glStencilMask(mask: GLuint);
    procedure glStencilOp(fail, zfail, zpass: GLenum);
    procedure glTexCoord1d(s: GLdouble);
    procedure glTexCoord1dv(const v: PGLdouble);
    procedure glTexCoord1f(s: GLfloat);
    procedure glTexCoord1fv(const v: PGLfloat);
    procedure glTexCoord1i(s: GLint);
    procedure glTexCoord1iv(const v: PGLint);
    procedure glTexCoord1s(s: GLshort);
    procedure glTexCoord1sv(const v: PGLshort);
    procedure glTexCoord2d(s, t: GLdouble);
    procedure glTexCoord2dv(const v: PGLdouble);
    procedure glTexCoord2f(s, t: GLfloat);
    procedure glTexCoord2fv(const v: PGLfloat);
    procedure glTexCoord2i(s, t: GLint);
    procedure glTexCoord2iv(const v: PGLint);
    procedure glTexCoord2s(s, t: GLshort);
    procedure glTexCoord2sv(const v: PGLshort);
    procedure glTexCoord3d(s, t, r: GLdouble);
    procedure glTexCoord3dv(const v: PGLdouble);
    procedure glTexCoord3f(s, t, r: GLfloat);
    procedure glTexCoord3fv(const v: PGLfloat);
    procedure glTexCoord3i(s, t, r: GLint);
    procedure glTexCoord3iv(const v: PGLint);
    procedure glTexCoord3s(s, t, r: GLshort);
    procedure glTexCoord3sv(const v: PGLshort);
    procedure glTexCoord4d(s, t, r, q: GLdouble);
    procedure glTexCoord4dv(const v: PGLdouble);
    procedure glTexCoord4f(s, t, r, q: GLfloat);
    procedure glTexCoord4fv(const v: PGLfloat);
    procedure glTexCoord4i(s, t, r, q: GLint);
    procedure glTexCoord4iv(const v: PGLint);
    procedure glTexCoord4s(s, t, r, q: GLshort);
    procedure glTexCoord4sv(const v: PGLshort);
    procedure glTexCoordPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer);
    procedure glTexEnvf(target: GLenum; pname: GLenum; param: GLfloat);
    procedure glTexEnvfv(target: GLenum; pname: GLenum; const params: PGLfloat);
    procedure glTexEnvi(target: GLenum; pname: GLenum; param: GLint);
    procedure glTexEnviv(target: GLenum; pname: GLenum; const params: PGLint);
    procedure glTexGend(coord: GLenum; pname: GLenum; param: GLdouble);
    procedure glTexGendv(coord: GLenum; pname: GLenum; const params: PGLdouble);
    procedure glTexGenf(coord: GLenum; pname: GLenum; param: GLfloat);
    procedure glTexGenfv(coord: GLenum; pname: GLenum; const params: PGLfloat);
    procedure glTexGeni(coord: GLenum; pname: GLenum; param: GLint);
    procedure glTexGeniv(coord: GLenum; pname: GLenum; const params: PGLint);
    procedure glTexImage1D(target: GLenum; level: GLInt; internalformat: GLEnum; Width: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer);
    procedure glTexImage2D(target: GLenum; level: GLInt; internalformat: GLEnum; Width, Height: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer);
    procedure glTexParameterf(target: GLenum; pname: GLenum; param: GLfloat);
    procedure glTexParameterfv(target: GLenum; pname: GLenum; const params: PGLfloat);
    procedure glTexParameteri(target: GLenum; pname: GLenum; param: GLint);
    procedure glTexParameteriv(target: GLenum; pname: GLenum; const params: PGLint);
    procedure glTexSubImage1D(target: GLenum; level, xoffset: GLint; Width: GLsizei; format, atype: GLenum; const pixels: Pointer);
    procedure glTexSubImage2D(target: GLenum; level, xoffset, yoffset: GLint; Width, Height: GLsizei; format, atype: GLenum; const pixels: Pointer);
    procedure glTranslated(x, y, z: GLdouble);
    procedure glTranslatef(x, y, z: GLfloat);
    procedure glVertex2d(x, y: GLdouble);
    procedure glVertex2dv(const v: PGLdouble);
    procedure glVertex2f(x, y: GLfloat);
    procedure glVertex2fv(const v: PGLfloat);
    procedure glVertex2i(x, y: GLint);
    procedure glVertex2iv(const v: PGLint);
    procedure glVertex2s(x, y: GLshort);
    procedure glVertex2sv(const v: PGLshort);
    procedure glVertex3d(x, y, z: GLdouble);
    procedure glVertex3dv(const v: PGLdouble);
    procedure glVertex3f(x, y, z: GLfloat);
    procedure glVertex3fv(const v: PGLfloat);
    procedure glVertex3i(x, y, z: GLint);
    procedure glVertex3iv(const v: PGLint);
    procedure glVertex3s(x, y, z: GLshort);
    procedure glVertex3sv(const v: PGLshort);
    procedure glVertex4d(x, y, z, w: GLdouble);
    procedure glVertex4dv(const v: PGLdouble);
    procedure glVertex4f(x, y, z, w: GLfloat);
    procedure glVertex4fv(const v: PGLfloat);
    procedure glVertex4i(x, y, z, w: GLint);
    procedure glVertex4iv(const v: PGLint);
    procedure glVertex4s(x, y, z, w: GLshort);
    procedure glVertex4sv(const v: PGLshort);
    procedure glVertexPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer);
    procedure glViewport(x, y: GLint; Width, Height: GLsizei);
  end;

  TGLMouse = class

  end;


var
  GL: TGLLibrary;

implementation

{ TGLLibrary }

constructor TGLLibrary.Create;
begin
  inherited Create;
  FLibraryName := libGL;
end;

procedure TGLLibrary.bindEntries;
begin
  FGLAccum := TGLAccum(GetProcAddress('glAccum'));
  FGLAlphaFunc := TGLAlphaFunc(GetProcAddress('glAlphaFunc'));
  FGLAreTexturesResident := TGLAreTexturesResident(GetProcAddress('glAreTexturesResident'));
  FGLArrayElement := TGLArrayElement(GetProcAddress('glArrayElement'));
  FGLBegin := TGLBegin(GetProcAddress('glBegin'));
  FGLBindTexture := TGLBindTexture(GetProcAddress('glBindTexture'));
  FGLBitmap := TGLBitmap(GetProcAddress('glBitmap'));
  FGLBlendFunc := TGLBlendFunc(GetProcAddress('glBlendFunc'));
  FGLCallList := TGLCallList(GetProcAddress('glCallList'));
  FGLCallLists := TGLCallLists(GetProcAddress('glCallLists'));
  FGLClear := TGLClear(GetProcAddress('glClear'));
  FGLClearAccum := TGLClearAccum(GetProcAddress('glClearAccum'));
  FGLClearColor := TGLClearColor(GetProcAddress('glClearColor'));
  FGLClearDepth := TGLClearDepth(GetProcAddress('glClearDepth'));
  FGLClearIndex := TGLClearIndex(GetProcAddress('glClearIndex'));
  FGLClearStencil := TGLClearStencil(GetProcAddress('glClearStencil'));
  FGLClipPlane := TGLClipPlane(GetProcAddress('glClipPlane'));
  FGLColor3b := TGLColor3b(GetProcAddress('glColor3b'));
  FGLColor3bv := TGLColor3bv(GetProcAddress('glColor3bv'));
  FGLColor3d := TGLColor3d(GetProcAddress('glColor3d'));
  FGLColor3dv := TGLColor3dv(GetProcAddress('glColor3dv'));
  FGLColor3f := TGLColor3f(GetProcAddress('glColor3f'));
  FGLColor3fv := TGLColor3fv(GetProcAddress('glColor3fv'));
  FGLColor3i := TGLColor3i(GetProcAddress('glColor3i'));
  FGLColor3iv := TGLColor3iv(GetProcAddress('glColor3iv'));
  FGLColor3s := TGLColor3s(GetProcAddress('glColor3s'));
  FGLColor3sv := TGLColor3sv(GetProcAddress('glColor3sv'));
  FGLColor3ub := TGLColor3ub(GetProcAddress('glColor3ub'));
  FGLColor3ubv := TGLColor3ubv(GetProcAddress('glColor3ubv'));
  FGLColor3ui := TGLColor3ui(GetProcAddress('glColor3ui'));
  FGLColor3uiv := TGLColor3uiv(GetProcAddress('glColor3uiv'));
  FGLColor3us := TGLColor3us(GetProcAddress('glColor3us'));
  FGLColor3usv := TGLColor3usv(GetProcAddress('glColor3usv'));
  FGLColor4b := TGLColor4b(GetProcAddress('glColor4b'));
  FGLColor4bv := TGLColor4bv(GetProcAddress('glColor4bv'));
  FGLColor4d := TGLColor4d(GetProcAddress('glColor4d'));
  FGLColor4dv := TGLColor4dv(GetProcAddress('glColor4dv'));
  FGLColor4f := TGLColor4f(GetProcAddress('glColor4f'));
  FGLColor4fv := TGLColor4fv(GetProcAddress('glColor4fv'));
  FGLColor4i := TGLColor4i(GetProcAddress('glColor4i'));
  FGLColor4iv := TGLColor4iv(GetProcAddress('glColor4iv'));
  FGLColor4s := TGLColor4s(GetProcAddress('glColor4s'));
  FGLColor4sv := TGLColor4sv(GetProcAddress('glColor4sv'));
  FGLColor4ub := TGLColor4ub(GetProcAddress('glColor4ub'));
  FGLColor4ubv := TGLColor4ubv(GetProcAddress('glColor4ubv'));
  FGLColor4ui := TGLColor4ui(GetProcAddress('glColor4ui'));
  FGLColor4uiv := TGLColor4uiv(GetProcAddress('glColor4uiv'));
  FGLColor4us := TGLColor4us(GetProcAddress('glColor4us'));
  FGLColor4usv := TGLColor4usv(GetProcAddress('glColor4usv'));
  FGLColorMask := TGLColorMask(GetProcAddress('glColorMask'));
  FGLColorMaterial := TGLColorMaterial(GetProcAddress('glColorMaterial'));
  FGLColorPointer := TGLColorPointer(GetProcAddress('glColorPointer'));
  FGLCopyPixels := TGLCopyPixels(GetProcAddress('glCopyPixels'));
  FGLCopyTexImage1D := TGLCopyTexImage1D(GetProcAddress('glCopyTexImage1D'));
  FGLCopyTexImage2D := TGLCopyTexImage2D(GetProcAddress('glCopyTexImage2D'));
  FGLCopyTexSubImage1D := TGLCopyTexSubImage1D(GetProcAddress('glCopyTexSubImage1D'));
  FGLCopyTexSubImage2D := TGLCopyTexSubImage2D(GetProcAddress('glCopyTexSubImage2D'));
  FGLCullFace := TGLCullFace(GetProcAddress('glCullFace'));
  FGLDeleteLists := TGLDeleteLists(GetProcAddress('glDeleteLists'));
  FGLDeleteTextures := TGLDeleteTextures(GetProcAddress('glDeleteTextures'));
  FGLDepthFunc := TGLDepthFunc(GetProcAddress('glDepthFunc'));
  FGLDepthMask := TGLDepthMask(GetProcAddress('glDepthMask'));
  FGLDepthRange := TGLDepthRange(GetProcAddress('glDepthRange'));
  FGLDisable := TGLDisable(GetProcAddress('glDisable'));
  FGLDisableClientState := TGLDisableClientState(GetProcAddress('glDisableClientState'));
  FGLDrawArrays := TGLDrawArrays(GetProcAddress('glDrawArrays'));
  FGLDrawBuffer := TGLDrawBuffer(GetProcAddress('glDrawBuffer'));
  FGLDrawElements := TGLDrawElements(GetProcAddress('glDrawElements'));
  FGLDrawPixels := TGLDrawPixels(GetProcAddress('glDrawPixels'));
  FGLEdgeFlag := TGLEdgeFlag(GetProcAddress('glEdgeFlag'));
  FGLEdgeFlagPointer := TGLEdgeFlagPointer(GetProcAddress('glEdgeFlagPointer'));
  FGLEdgeFlagv := TGLEdgeFlagv(GetProcAddress('glEdgeFlagv'));
  FGLEnable := TGLEnable(GetProcAddress('glEnable'));
  FGLEnableClientState := TGLEnableClientState(GetProcAddress('glEnableClientState'));
  FGLEnd := TGLEnd(GetProcAddress('glEnd'));
  FGLEndList := TGLEndList(GetProcAddress('glEndList'));
  FGLEvalCoord1d := TGLEvalCoord1d(GetProcAddress('glEvalCoord1d'));
  FGLEvalCoord1dv := TGLEvalCoord1dv(GetProcAddress('glEvalCoord1dv'));
  FGLEvalCoord1f := TGLEvalCoord1f(GetProcAddress('glEvalCoord1f'));
  FGLEvalCoord1fv := TGLEvalCoord1fv(GetProcAddress('glEvalCoord1fv'));
  FGLEvalCoord2d := TGLEvalCoord2d(GetProcAddress('glEvalCoord2d'));
  FGLEvalCoord2dv := TGLEvalCoord2dv(GetProcAddress('glEvalCoord2dv'));
  FGLEvalCoord2f := TGLEvalCoord2f(GetProcAddress('glEvalCoord2f'));
  FGLEvalCoord2fv := TGLEvalCoord2fv(GetProcAddress('glEvalCoord2fv'));
  FGLEvalMesh1 := TGLEvalMesh1(GetProcAddress('glEvalMesh1'));
  FGLEvalMesh2 := TGLEvalMesh2(GetProcAddress('glEvalMesh2'));
  FGLEvalPoint1 := TGLEvalPoint1(GetProcAddress('glEvalPoint1'));
  FGLEvalPoint2 := TGLEvalPoint2(GetProcAddress('glEvalPoint2'));
  FGLFeedbackBuffer := TGLFeedbackBuffer(GetProcAddress('glFeedbackBuffer'));
  FGLFinish := TGLFinish(GetProcAddress('glFinish'));
  FGLFlush := TGLFlush(GetProcAddress('glFlush'));
  FGLFogf := TGLFogf(GetProcAddress('glFogf'));
  FGLFogfv := TGLFogfv(GetProcAddress('glFogfv'));
  FGLFogi := TGLFogi(GetProcAddress('glFogi'));
  FGLFogiv := TGLFogiv(GetProcAddress('glFogiv'));
  FGLFrontFace := TGLFrontFace(GetProcAddress('glFrontFace'));
  FGLFrustum := TGLFrustum(GetProcAddress('glFrustum'));
  FGLGenLists := TGLGenLists(GetProcAddress('glGenLists'));
  FGLGenTextures := TGLGenTextures(GetProcAddress('glGenTextures'));
  FGLGetBooleanv := TGLGetBooleanv(GetProcAddress('glGetBooleanv'));
  FGLGetClipPlane := TGLGetClipPlane(GetProcAddress('glGetClipPlane'));
  FGLGetDoublev := TGLGetDoublev(GetProcAddress('glGetDoublev'));
  FGLGetError := TGLGetError(GetProcAddress('glGetError'));
  FGLGetFloatv := TGLGetFloatv(GetProcAddress('glGetFloatv'));
  FGLGetIntegerv := TGLGetIntegerv(GetProcAddress('glGetIntegerv'));
  FGLGetLightfv := TGLGetLightfv(GetProcAddress('glGetLightfv'));
  FGLGetLightiv := TGLGetLightiv(GetProcAddress('glGetLightiv'));
  FGLGetMapdv := TGLGetMapdv(GetProcAddress('glGetMapdv'));
  FGLGetMapfv := TGLGetMapfv(GetProcAddress('glGetMapfv'));
  FGLGetMapiv := TGLGetMapiv(GetProcAddress('glGetMapiv'));
  FGLGetMaterialfv := TGLGetMaterialfv(GetProcAddress('glGetMaterialfv'));
  FGLGetMaterialiv := TGLGetMaterialiv(GetProcAddress('glGetMaterialiv'));
  FGLGetPixelMapfv := TGLGetPixelMapfv(GetProcAddress('glGetPixelMapfv'));
  FGLGetPixelMapuiv := TGLGetPixelMapuiv(GetProcAddress('glGetPixelMapuiv'));
  FGLGetPixelMapusv := TGLGetPixelMapusv(GetProcAddress('glGetPixelMapusv'));
  FGLGetPointerv := TGLGetPointerv(GetProcAddress('glGetPointerv'));
  FGLGetPolygonStipple := TGLGetPolygonStipple(GetProcAddress('glGetPolygonStipple'));
  FGLGetString := TGLGetString(GetProcAddress('glGetString'));
  FGLGetTexEnvfv := TGLGetTexEnvfv(GetProcAddress('glGetTexEnvfv'));
  FGLGetTexEnviv := TGLGetTexEnviv(GetProcAddress('glGetTexEnviv'));
  FGLGetTexGendv := TGLGetTexGendv(GetProcAddress('glGetTexGendv'));
  FGLGetTexGenfv := TGLGetTexGenfv(GetProcAddress('glGetTexGenfv'));
  FGLGetTexGeniv := TGLGetTexGeniv(GetProcAddress('glGetTexGeniv'));
  FGLGetTexImage := TGLGetTexImage(GetProcAddress('glGetTexImage'));
  FGLGetTexLevelParameterfv := TGLGetTexLevelParameterfv(GetProcAddress('glGetTexLevelParameterfv'));
  FGLGetTexLevelParameteriv := TGLGetTexLevelParameteriv(GetProcAddress('glGetTexLevelParameteriv'));
  FGLGetTexParameterfv := TGLGetTexParameterfv(GetProcAddress('glGetTexParameterfv'));
  FGLGetTexParameteriv := TGLGetTexParameteriv(GetProcAddress('glGetTexParameteriv'));
  FGLHint := TGLHint(GetProcAddress('glHint'));
  FGLIndexMask := TGLIndexMask(GetProcAddress('glIndexMask'));
  FGLIndexPointer := TGLIndexPointer(GetProcAddress('glIndexPointer'));
  FGLIndexd := TGLIndexd(GetProcAddress('glIndexd'));
  FGLIndexdv := TGLIndexdv(GetProcAddress('glIndexdv'));
  FGLIndexf := TGLIndexf(GetProcAddress('glIndexf'));
  FGLIndexfv := TGLIndexfv(GetProcAddress('glIndexfv'));
  FGLIndexi := TGLIndexi(GetProcAddress('glIndexi'));
  FGLIndexiv := TGLIndexiv(GetProcAddress('glIndexiv'));
  FGLIndexs := TGLIndexs(GetProcAddress('glIndexs'));
  FGLIndexsv := TGLIndexsv(GetProcAddress('glIndexsv'));
  FGLIndexub := TGLIndexub(GetProcAddress('glIndexub'));
  FGLIndexubv := TGLIndexubv(GetProcAddress('glIndexubv'));
  FGLInitNames := TGLInitNames(GetProcAddress('glInitNames'));
  FGLInterleavedArrays := TGLInterleavedArrays(GetProcAddress('glInterleavedArrays'));
  FGLIsEnabled := TGLIsEnabled(GetProcAddress('glIsEnabled'));
  FGLIsList := TGLIsList(GetProcAddress('glIsList'));
  FGLIsTexture := TGLIsTexture(GetProcAddress('glIsTexture'));
  FGLLightModelf := TGLLightModelf(GetProcAddress('glLightModelf'));
  FGLLightModelfv := TGLLightModelfv(GetProcAddress('glLightModelfv'));
  FGLLightModeli := TGLLightModeli(GetProcAddress('glLightModeli'));
  FGLLightModeliv := TGLLightModeliv(GetProcAddress('glLightModeliv'));
  FGLLightf := TGLLightf(GetProcAddress('glLightf'));
  FGLLightfv := TGLLightfv(GetProcAddress('glLightfv'));
  FGLLighti := TGLLighti(GetProcAddress('glLighti'));
  FGLLightiv := TGLLightiv(GetProcAddress('glLightiv'));
  FGLLineStipple := TGLLineStipple(GetProcAddress('glLineStipple'));
  FGLLineWidth := TGLLineWidth(GetProcAddress('glLineWidth'));
  FGLListBase := TGLListBase(GetProcAddress('glListBase'));
  FGLLoadIdentity := TGLLoadIdentity(GetProcAddress('glLoadIdentity'));
  FGLLoadMatrixd := TGLLoadMatrixd(GetProcAddress('glLoadMatrixd'));
  FGLLoadMatrixf := TGLLoadMatrixf(GetProcAddress('glLoadMatrixf'));
  FGLLoadName := TGLLoadName(GetProcAddress('glLoadName'));
  FGLLogicOp := TGLLogicOp(GetProcAddress('glLogicOp'));
  FGLMap1d := TGLMap1d(GetProcAddress('glMap1d'));
  FGLMap1f := TGLMap1f(GetProcAddress('glMap1f'));
  FGLMap2d := TGLMap2d(GetProcAddress('glMap2d'));
  FGLMap2f := TGLMap2f(GetProcAddress('glMap2f'));
  FGLMapGrid1d := TGLMapGrid1d(GetProcAddress('glMapGrid1d'));
  FGLMapGrid1f := TGLMapGrid1f(GetProcAddress('glMapGrid1f'));
  FGLMapGrid2d := TGLMapGrid2d(GetProcAddress('glMapGrid2d'));
  FGLMapGrid2f := TGLMapGrid2f(GetProcAddress('glMapGrid2f'));
  FGLMaterialf := TGLMaterialf(GetProcAddress('glMaterialf'));
  FGLMaterialfv := TGLMaterialfv(GetProcAddress('glMaterialfv'));
  FGLMateriali := TGLMateriali(GetProcAddress('glMateriali'));
  FGLMaterialiv := TGLMaterialiv(GetProcAddress('glMaterialiv'));
  FGLMatrixMode := TGLMatrixMode(GetProcAddress('glMatrixMode'));
  FGLMultMatrixd := TGLMultMatrixd(GetProcAddress('glMultMatrixd'));
  FGLMultMatrixf := TGLMultMatrixf(GetProcAddress('glMultMatrixf'));
  FGLNewList := TGLNewList(GetProcAddress('glNewList'));
  FGLNormal3b := TGLNormal3b(GetProcAddress('glNormal3b'));
  FGLNormal3bv := TGLNormal3bv(GetProcAddress('glNormal3bv'));
  FGLNormal3d := TGLNormal3d(GetProcAddress('glNormal3d'));
  FGLNormal3dv := TGLNormal3dv(GetProcAddress('glNormal3dv'));
  FGLNormal3f := TGLNormal3f(GetProcAddress('glNormal3f'));
  FGLNormal3fv := TGLNormal3fv(GetProcAddress('glNormal3fv'));
  FGLNormal3i := TGLNormal3i(GetProcAddress('glNormal3i'));
  FGLNormal3iv := TGLNormal3iv(GetProcAddress('glNormal3iv'));
  FGLNormal3s := TGLNormal3s(GetProcAddress('glNormal3s'));
  FGLNormal3sv := TGLNormal3sv(GetProcAddress('glNormal3sv'));
  FGLNormalPointer := TGLNormalPointer(GetProcAddress('glNormalPointer'));
  FGLOrtho := TGLOrtho(GetProcAddress('glOrtho'));
  FGLPassThrough := TGLPassThrough(GetProcAddress('glPassThrough'));
  FGLPixelMapfv := TGLPixelMapfv(GetProcAddress('glPixelMapfv'));
  FGLPixelMapuiv := TGLPixelMapuiv(GetProcAddress('glPixelMapuiv'));
  FGLPixelMapusv := TGLPixelMapusv(GetProcAddress('glPixelMapusv'));
  FGLPixelStoref := TGLPixelStoref(GetProcAddress('glPixelStoref'));
  FGLPixelStorei := TGLPixelStorei(GetProcAddress('glPixelStorei'));
  FGLPixelTransferf := TGLPixelTransferf(GetProcAddress('glPixelTransferf'));
  FGLPixelTransferi := TGLPixelTransferi(GetProcAddress('glPixelTransferi'));
  FGLPixelZoom := TGLPixelZoom(GetProcAddress('glPixelZoom'));
  FGLPointSize := TGLPointSize(GetProcAddress('glPointSize'));
  FGLPolygonMode := TGLPolygonMode(GetProcAddress('glPolygonMode'));
  FGLPolygonOffset := TGLPolygonOffset(GetProcAddress('glPolygonOffset'));
  FGLPolygonStipple := TGLPolygonStipple(GetProcAddress('glPolygonStipple'));
  FGLPopAttrib := TGLPopAttrib(GetProcAddress('glPopAttrib'));
  FGLPopClientAttrib := TGLPopClientAttrib(GetProcAddress('glPopClientAttrib'));
  FGLPopMatrix := TGLPopMatrix(GetProcAddress('glPopMatrix'));
  FGLPopName := TGLPopName(GetProcAddress('glPopName'));
  FGLPrioritizeTextures := TGLPrioritizeTextures(GetProcAddress('glPrioritizeTextures'));
  FGLPushAttrib := TGLPushAttrib(GetProcAddress('glPushAttrib'));
  FGLPushClientAttrib := TGLPushClientAttrib(GetProcAddress('glPushClientAttrib'));
  FGLPushMatrix := TGLPushMatrix(GetProcAddress('glPushMatrix'));
  FGLPushName := TGLPushName(GetProcAddress('glPushName'));
  FGLRasterPos2d := TGLRasterPos2d(GetProcAddress('glRasterPos2d'));
  FGLRasterPos2dv := TGLRasterPos2dv(GetProcAddress('glRasterPos2dv'));
  FGLRasterPos2f := TGLRasterPos2f(GetProcAddress('glRasterPos2f'));
  FGLRasterPos2fv := TGLRasterPos2fv(GetProcAddress('glRasterPos2fv'));
  FGLRasterPos2i := TGLRasterPos2i(GetProcAddress('glRasterPos2i'));
  FGLRasterPos2iv := TGLRasterPos2iv(GetProcAddress('glRasterPos2iv'));
  FGLRasterPos2s := TGLRasterPos2s(GetProcAddress('glRasterPos2s'));
  FGLRasterPos2sv := TGLRasterPos2sv(GetProcAddress('glRasterPos2sv'));
  FGLRasterPos3d := TGLRasterPos3d(GetProcAddress('glRasterPos3d'));
  FGLRasterPos3dv := TGLRasterPos3dv(GetProcAddress('glRasterPos3dv'));
  FGLRasterPos3f := TGLRasterPos3f(GetProcAddress('glRasterPos3f'));
  FGLRasterPos3fv := TGLRasterPos3fv(GetProcAddress('glRasterPos3fv'));
  FGLRasterPos3i := TGLRasterPos3i(GetProcAddress('glRasterPos3i'));
  FGLRasterPos3iv := TGLRasterPos3iv(GetProcAddress('glRasterPos3iv'));
  FGLRasterPos3s := TGLRasterPos3s(GetProcAddress('glRasterPos3s'));
  FGLRasterPos3sv := TGLRasterPos3sv(GetProcAddress('glRasterPos3sv'));
  FGLRasterPos4d := TGLRasterPos4d(GetProcAddress('glRasterPos4d'));
  FGLRasterPos4dv := TGLRasterPos4dv(GetProcAddress('glRasterPos4dv'));
  FGLRasterPos4f := TGLRasterPos4f(GetProcAddress('glRasterPos4f'));
  FGLRasterPos4fv := TGLRasterPos4fv(GetProcAddress('glRasterPos4fv'));
  FGLRasterPos4i := TGLRasterPos4i(GetProcAddress('glRasterPos4i'));
  FGLRasterPos4iv := TGLRasterPos4iv(GetProcAddress('glRasterPos4iv'));
  FGLRasterPos4s := TGLRasterPos4s(GetProcAddress('glRasterPos4s'));
  FGLRasterPos4sv := TGLRasterPos4sv(GetProcAddress('glRasterPos4sv'));
  FGLReadBuffer := TGLReadBuffer(GetProcAddress('glReadBuffer'));
  FGLReadPixels := TGLReadPixels(GetProcAddress('glReadPixels'));
  FGLRectd := TGLRectd(GetProcAddress('glRectd'));
  FGLRectdv := TGLRectdv(GetProcAddress('glRectdv'));
  FGLRectf := TGLRectf(GetProcAddress('glRectf'));
  FGLRectfv := TGLRectfv(GetProcAddress('glRectfv'));
  FGLRecti := TGLRecti(GetProcAddress('glRecti'));
  FGLRectiv := TGLRectiv(GetProcAddress('glRectiv'));
  FGLRects := TGLRects(GetProcAddress('glRects'));
  FGLRectsv := TGLRectsv(GetProcAddress('glRectsv'));
  FGLRenderMode := TGLRenderMode(GetProcAddress('glRenderMode'));
  FGLRotated := TGLRotated(GetProcAddress('glRotated'));
  FGLRotatef := TGLRotatef(GetProcAddress('glRotatef'));
  FGLScaled := TGLScaled(GetProcAddress('glScaled'));
  FGLScalef := TGLScalef(GetProcAddress('glScalef'));
  FGLScissor := TGLScissor(GetProcAddress('glScissor'));
  FGLSelectBuffer := TGLSelectBuffer(GetProcAddress('glSelectBuffer'));
  FGLShadeModel := TGLShadeModel(GetProcAddress('glShadeModel'));
  FGLStencilFunc := TGLStencilFunc(GetProcAddress('glStencilFunc'));
  FGLStencilMask := TGLStencilMask(GetProcAddress('glStencilMask'));
  FGLStencilOp := TGLStencilOp(GetProcAddress('glStencilOp'));
  FGLTexCoord1d := TGLTexCoord1d(GetProcAddress('glTexCoord1d'));
  FGLTexCoord1dv := TGLTexCoord1dv(GetProcAddress('glTexCoord1dv'));
  FGLTexCoord1f := TGLTexCoord1f(GetProcAddress('glTexCoord1f'));
  FGLTexCoord1fv := TGLTexCoord1fv(GetProcAddress('glTexCoord1fv'));
  FGLTexCoord1i := TGLTexCoord1i(GetProcAddress('glTexCoord1i'));
  FGLTexCoord1iv := TGLTexCoord1iv(GetProcAddress('glTexCoord1iv'));
  FGLTexCoord1s := TGLTexCoord1s(GetProcAddress('glTexCoord1s'));
  FGLTexCoord1sv := TGLTexCoord1sv(GetProcAddress('glTexCoord1sv'));
  FGLTexCoord2d := TGLTexCoord2d(GetProcAddress('glTexCoord2d'));
  FGLTexCoord2dv := TGLTexCoord2dv(GetProcAddress('glTexCoord2dv'));
  FGLTexCoord2f := TGLTexCoord2f(GetProcAddress('glTexCoord2f'));
  FGLTexCoord2fv := TGLTexCoord2fv(GetProcAddress('glTexCoord2fv'));
  FGLTexCoord2i := TGLTexCoord2i(GetProcAddress('glTexCoord2i'));
  FGLTexCoord2iv := TGLTexCoord2iv(GetProcAddress('glTexCoord2iv'));
  FGLTexCoord2s := TGLTexCoord2s(GetProcAddress('glTexCoord2s'));
  FGLTexCoord2sv := TGLTexCoord2sv(GetProcAddress('glTexCoord2sv'));
  FGLTexCoord3d := TGLTexCoord3d(GetProcAddress('glTexCoord3d'));
  FGLTexCoord3dv := TGLTexCoord3dv(GetProcAddress('glTexCoord3dv'));
  FGLTexCoord3f := TGLTexCoord3f(GetProcAddress('glTexCoord3f'));
  FGLTexCoord3fv := TGLTexCoord3fv(GetProcAddress('glTexCoord3fv'));
  FGLTexCoord3i := TGLTexCoord3i(GetProcAddress('glTexCoord3i'));
  FGLTexCoord3iv := TGLTexCoord3iv(GetProcAddress('glTexCoord3iv'));
  FGLTexCoord3s := TGLTexCoord3s(GetProcAddress('glTexCoord3s'));
  FGLTexCoord3sv := TGLTexCoord3sv(GetProcAddress('glTexCoord3sv'));
  FGLTexCoord4d := TGLTexCoord4d(GetProcAddress('glTexCoord4d'));
  FGLTexCoord4dv := TGLTexCoord4dv(GetProcAddress('glTexCoord4dv'));
  FGLTexCoord4f := TGLTexCoord4f(GetProcAddress('glTexCoord4f'));
  FGLTexCoord4fv := TGLTexCoord4fv(GetProcAddress('glTexCoord4fv'));
  FGLTexCoord4i := TGLTexCoord4i(GetProcAddress('glTexCoord4i'));
  FGLTexCoord4iv := TGLTexCoord4iv(GetProcAddress('glTexCoord4iv'));
  FGLTexCoord4s := TGLTexCoord4s(GetProcAddress('glTexCoord4s'));
  FGLTexCoord4sv := TGLTexCoord4sv(GetProcAddress('glTexCoord4sv'));
  FGLTexCoordPointer := TGLTexCoordPointer(GetProcAddress('glTexCoordPointer'));
  FGLTexEnvf := TGLTexEnvf(GetProcAddress('glTexEnvf'));
  FGLTexEnvfv := TGLTexEnvfv(GetProcAddress('glTexEnvfv'));
  FGLTexEnvi := TGLTexEnvi(GetProcAddress('glTexEnvi'));
  FGLTexEnviv := TGLTexEnviv(GetProcAddress('glTexEnviv'));
  FGLTexGend := TGLTexGend(GetProcAddress('glTexGend'));
  FGLTexGendv := TGLTexGendv(GetProcAddress('glTexGendv'));
  FGLTexGenf := TGLTexGenf(GetProcAddress('glTexGenf'));
  FGLTexGenfv := TGLTexGenfv(GetProcAddress('glTexGenfv'));
  FGLTexGeni := TGLTexGeni(GetProcAddress('glTexGeni'));
  FGLTexGeniv := TGLTexGeniv(GetProcAddress('glTexGeniv'));
  FGLTexImage1D := TGLTexImage1D(GetProcAddress('glTexImage1D'));
  FGLTexImage2D := TGLTexImage2D(GetProcAddress('glTexImage2D'));
  FGLTexParameterf := TGLTexParameterf(GetProcAddress('glTexParameterf'));
  FGLTexParameterfv := TGLTexParameterfv(GetProcAddress('glTexParameterfv'));
  FGLTexParameteri := TGLTexParameteri(GetProcAddress('glTexParameteri'));
  FGLTexParameteriv := TGLTexParameteriv(GetProcAddress('glTexParameteriv'));
  FGLTexSubImage1D := TGLTexSubImage1D(GetProcAddress('glTexSubImage1D'));
  FGLTexSubImage2D := TGLTexSubImage2D(GetProcAddress('glTexSubImage2D'));
  FGLTranslated := TGLTranslated(GetProcAddress('glTranslated'));
  FGLTranslatef := TGLTranslatef(GetProcAddress('glTranslatef'));
  FGLVertex2d := TGLVertex2d(GetProcAddress('glVertex2d'));
  FGLVertex2dv := TGLVertex2dv(GetProcAddress('glVertex2dv'));
  FGLVertex2f := TGLVertex2f(GetProcAddress('glVertex2f'));
  FGLVertex2fv := TGLVertex2fv(GetProcAddress('glVertex2fv'));
  FGLVertex2i := TGLVertex2i(GetProcAddress('glVertex2i'));
  FGLVertex2iv := TGLVertex2iv(GetProcAddress('glVertex2iv'));
  FGLVertex2s := TGLVertex2s(GetProcAddress('glVertex2s'));
  FGLVertex2sv := TGLVertex2sv(GetProcAddress('glVertex2sv'));
  FGLVertex3d := TGLVertex3d(GetProcAddress('glVertex3d'));
  FGLVertex3dv := TGLVertex3dv(GetProcAddress('glVertex3dv'));
  FGLVertex3f := TGLVertex3f(GetProcAddress('glVertex3f'));
  FGLVertex3fv := TGLVertex3fv(GetProcAddress('glVertex3fv'));
  FGLVertex3i := TGLVertex3i(GetProcAddress('glVertex3i'));
  FGLVertex3iv := TGLVertex3iv(GetProcAddress('glVertex3iv'));
  FGLVertex3s := TGLVertex3s(GetProcAddress('glVertex3s'));
  FGLVertex3sv := TGLVertex3sv(GetProcAddress('glVertex3sv'));
  FGLVertex4d := TGLVertex4d(GetProcAddress('glVertex4d'));
  FGLVertex4dv := TGLVertex4dv(GetProcAddress('glVertex4dv'));
  FGLVertex4f := TGLVertex4f(GetProcAddress('glVertex4f'));
  FGLVertex4fv := TGLVertex4fv(GetProcAddress('glVertex4fv'));
  FGLVertex4i := TGLVertex4i(GetProcAddress('glVertex4i'));
  FGLVertex4iv := TGLVertex4iv(GetProcAddress('glVertex4iv'));
  FGLVertex4s := TGLVertex4s(GetProcAddress('glVertex4s'));
  FGLVertex4sv := TGLVertex4sv(GetProcAddress('glVertex4sv'));
  FGLVertexPointer := TGLVertexPointer(GetProcAddress('glVertexPointer'));
  FGLViewport := TGLViewport(GetProcAddress('glViewport'));
end;

procedure TGLLibrary.glAccum(op: GLenum; Value: GLfloat);
begin
  FGLAccum(op, Value);
end;

procedure TGLLibrary.glAlphaFunc(func: GLenum; ref: GLclampf);
begin
  FGLAlphaFunc(func, ref);
end;

function TGLLibrary.glAreTexturesResident(n: GLsizei; const textures: PGLuint; residences: PGLboolean): GLboolean;
begin
  Result := FGLAreTexturesResident(n, textures, residences);
end;

procedure TGLLibrary.glArrayElement(i: GLint);
begin
  FGLArrayElement(i);
end;

procedure TGLLibrary.glBegin(mode: GLenum);
begin
  FGLBegin(mode);
end;

procedure TGLLibrary.glBindTexture(target: GLenum; texture: GLuint);
begin
  FGLBindTexture(target, texture);
end;

procedure TGLLibrary.glBitmap(Width, Height: GLsizei; xorig, yorig: GLfloat; xmove, ymove: GLfloat; const bitmap: PGLubyte);
begin
  FGLBitmap(Width, Height, xorig, yorig, xmove, ymove, bitmap);
end;

procedure TGLLibrary.glBlendFunc(sfactor, dfactor: GLenum);
begin
  FGLBlendFunc(sfactor, dfactor);
end;

procedure TGLLibrary.glCallList(list: GLuint);
begin
  FGLCallList(list);
end;

procedure TGLLibrary.glCallLists(n: GLsizei; atype: GLenum; const lists: Pointer);
begin
  FGLCallLists(n, atype, lists);
end;

procedure TGLLibrary.glClear(mask: GLbitfield);
begin
  FGLClear(mask);
end;

procedure TGLLibrary.glClearAccum(red, green, blue, alpha: GLfloat);
begin
  FGLClearAccum(red, green, blue, alpha);
end;

procedure TGLLibrary.glClearColor(red, green, blue, alpha: GLclampf);
begin
  FGLClearColor(red, green, blue, alpha);
end;

procedure TGLLibrary.glClearDepth(depth: GLclampd);
begin
  FGLClearDepth(depth);
end;

procedure TGLLibrary.glClearIndex(c: GLfloat);
begin
  FGLClearIndex(c);
end;

procedure TGLLibrary.glClearStencil(s: GLint);
begin
  FGLClearStencil(s);
end;

procedure TGLLibrary.glClipPlane(plane: GLenum; const equation: PGLdouble);
begin
  FglClipPlane(plane, equation);
end;

procedure TGLLibrary.glColor3b(red, green, blue: GLbyte);
begin
  FGLColor3b(red, green, blue);
end;

procedure TGLLibrary.glColor3bv(const v: PGLbyte);
begin
  FGLColor3bv(v);
end;

procedure TGLLibrary.glColor3d(red, green, blue: GLdouble);
begin
  FGLColor3d(red, green, blue);
end;

procedure TGLLibrary.glColor3dv(const v: PGLdouble);
begin
  FGLColor3dv(v);
end;

procedure TGLLibrary.glColor3f(red, green, blue: GLfloat);
begin
  FGLColor3f(red, green, blue);
end;

procedure TGLLibrary.glColor3fv(const v: PGLfloat);
begin
  FGLColor3fv(v);
end;

procedure TGLLibrary.glColor3i(red, green, blue: GLint);
begin
  FGLColor3i(red, green, blue);
end;

procedure TGLLibrary.glColor3iv(const v: PGLint);
begin
  FGLColor3iv(v);
end;

procedure TGLLibrary.glColor3s(red, green, blue: GLshort);
begin
  FGLColor3s(red, green, blue);
end;

procedure TGLLibrary.glColor3sv(const v: PGLshort);
begin
  FGLColor3sv(v);
end;

procedure TGLLibrary.glColor3ub(red, green, blue: GLubyte);
begin
  FGLColor3ub(red, green, blue);
end;

procedure TGLLibrary.glColor3ubv(const v: PGLubyte);
begin
  FGLColor3ubv(v);
end;

procedure TGLLibrary.glColor3ui(red, green, blue: GLuint);
begin
  FGLColor3ui(red, green, blue);
end;

procedure TGLLibrary.glColor3uiv(const v: PGLuint);
begin
  FGLColor3uiv(v);
end;

procedure TGLLibrary.glColor3us(red, green, blue: GLushort);
begin
  FGLColor3us(red, green, blue);
end;

procedure TGLLibrary.glColor3usv(const v: PGLushort);
begin
  FGLColor3usv(v);
end;

procedure TGLLibrary.glColor4b(red, green, blue, alpha: GLbyte);
begin
  FGLColor4b(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4bv(const v: PGLbyte);
begin
  FGLColor4bv(v);
end;

procedure TGLLibrary.glColor4d(red, green, blue, alpha: GLdouble);
begin
  FGLColor4d(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4dv(const v: PGLdouble);
begin
  FGLColor4dv(v);
end;

procedure TGLLibrary.glColor4f(red, green, blue, alpha: GLfloat);
begin
  FGLColor4f(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4fv(const v: PGLfloat);
begin
  FGLColor4fv(v);
end;

procedure TGLLibrary.glColor4i(red, green, blue, alpha: GLint);
begin
  FGLColor4i(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4iv(const v: PGLint);
begin
  FGLColor4iv(v);
end;

procedure TGLLibrary.glColor4s(red, green, blue, alpha: GLshort);
begin
  FGLColor4s(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4sv(const v: PGLshort);
begin
  FGLColor4sv(v);
end;

procedure TGLLibrary.glColor4ub(red, green, blue, alpha: GLubyte);
begin
  FGLColor4ub(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4ubv(const v: PGLubyte);
begin
  FGLColor4ubv(v);
end;

procedure TGLLibrary.glColor4ui(red, green, blue, alpha: GLuint);
begin
  FGLColor4ui(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4uiv(const v: PGLuint);
begin
  FGLColor4uiv(v);
end;

procedure TGLLibrary.glColor4us(red, green, blue, alpha: GLushort);
begin
  FGLColor4us(red, green, blue, alpha);
end;

procedure TGLLibrary.glColor4usv(const v: PGLushort);
begin
  FGLColor4usv(v);
end;

procedure TGLLibrary.glColorMask(red, green, blue, alpha: GLboolean);
begin
  FGLColorMask(red, green, blue, alpha);
end;

procedure TGLLibrary.glColorMaterial(face, mode: GLenum);
begin
  FGLColorMaterial(face, mode);
end;

procedure TGLLibrary.glColorPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer);
begin
  FGLColorPointer(size, atype, stride, pointer);
end;

procedure TGLLibrary.glCopyPixels(x, y: GLint; Width, Height: GLsizei; atype: GLenum);
begin
  FGLCopyPixels(x, y, Width, Height, atype);
end;

procedure TGLLibrary.glCopyTexImage1D(target: GLenum; level: GLint; internalFormat: GLenum; x, y: GLint; Width: GLsizei; border: GLint);
begin
  FGLCopyTexImage1D(target, level, internalFormat, x, y, Width, border);
end;

procedure TGLLibrary.glCopyTexImage2D(target: GLenum; level: GLint; internalFormat: GLenum; x, y: GLint; Width, Height: GLsizei; border: GLint);
begin
  FGLCopyTexImage2D(target, level, internalFormat, x, y, Width, Height, border);
end;

procedure TGLLibrary.glCopyTexSubImage1D(target: GLenum; level, xoffset, x, y: GLint; Width: GLsizei);
begin
  FGLCopyTexSubImage1D(target, level, xoffset, x, y, Width);
end;

procedure TGLLibrary.glCopyTexSubImage2D(target: GLenum; level, xoffset, yoffset, x, y: GLint; Width, Height: GLsizei);
begin
  FGLCopyTexSubImage2D(target, level, xoffset, yoffset, x, y, Width, Height);
end;

procedure TGLLibrary.glCullFace(mode: GLenum);
begin
  FGLCullFace(mode);
end;

procedure TGLLibrary.glDeleteLists(list: GLuint; range: GLsizei);
begin
  FGLDeleteLists(list, range);
end;

procedure TGLLibrary.glDeleteTextures(n: GLsizei; const textures: PGLuint);
begin
  FGLDeleteTextures(n, textures);
end;

procedure TGLLibrary.glDepthFunc(func: GLenum);
begin
  FGLDepthFunc(func);
end;

procedure TGLLibrary.glDepthMask(flag: GLboolean);
begin
  FGLDepthMask(flag);
end;

procedure TGLLibrary.glDepthRange(zNear, zFar: GLclampd);
begin
  FGLDepthRange(zNear, zFar);
end;

procedure TGLLibrary.glDisable(cap: GLenum);
begin
  FGLDisable(cap);
end;

procedure TGLLibrary.glDisableClientState(aarray: GLenum);
begin
  FGLDisableClientState(aarray);
end;

procedure TGLLibrary.glDrawArrays(mode: GLenum; First: GLint; Count: GLsizei);
begin
  FGLDrawArrays(mode, First, Count);
end;

procedure TGLLibrary.glDrawBuffer(mode: GLenum);
begin
  FGLDrawBuffer(mode);
end;

procedure TGLLibrary.glDrawElements(mode: GLenum; Count: GLsizei; atype: GLenum; const indices: Pointer);
begin
  FGLDrawElements(mode, Count, atype, indices);
end;

procedure TGLLibrary.glDrawPixels(Width, Height: GLsizei; format, atype: GLenum; const pixels: Pointer);
begin
  FGLDrawPixels(Width, Height, format, atype, pixels);
end;

procedure TGLLibrary.glEdgeFlag(flag: GLboolean);
begin
  FGLEdgeFlag(flag);
end;

procedure TGLLibrary.glEdgeFlagPointer(stride: GLsizei; const pointer: Pointer);
begin
  FGLEdgeFlagPointer(stride, pointer);
end;

procedure TGLLibrary.glEdgeFlagv(const flag: PGLboolean);
begin
  FGLEdgeFlagv(flag);
end;

procedure TGLLibrary.glEnable(cap: GLenum);
begin
  FGLEnable(cap);
end;

procedure TGLLibrary.glEnableClientState(aarray: GLenum);
begin
  FGLEnableClientState(aarray);
end;

procedure TGLLibrary.glEnd;
begin
  FGLEnd();
end;

procedure TGLLibrary.glEndList;
begin
  FGLEndList();
end;

procedure TGLLibrary.glEvalCoord1d(u: GLdouble);
begin
  FGLEvalCoord1d(u);
end;

procedure TGLLibrary.glEvalCoord1dv(const u: PGLdouble);
begin
  FGLEvalCoord1dv(u);
end;

procedure TGLLibrary.glEvalCoord1f(u: GLfloat);
begin
  FGLEvalCoord1f(u);
end;

procedure TGLLibrary.glEvalCoord1fv(const u: PGLfloat);
begin
  FGLEvalCoord1fv(u);
end;

procedure TGLLibrary.glEvalCoord2d(u, v: GLdouble);
begin
  FGLEvalCoord2d(u, v);
end;

procedure TGLLibrary.glEvalCoord2dv(const u: PGLdouble);
begin
  FGLEvalCoord2dv(u);
end;

procedure TGLLibrary.glEvalCoord2f(u, v: GLfloat);
begin
  FGLEvalCoord2f(u, v);
end;

procedure TGLLibrary.glEvalCoord2fv(const u: PGLfloat);
begin
  FGLEvalCoord2fv(u);
end;

procedure TGLLibrary.glEvalMesh1(mode: GLenum; i1, i2: GLint);
begin
  FGLEvalMesh1(mode, i1, i2);
end;

procedure TGLLibrary.glEvalMesh2(mode: GLenum; i1, i2, j1, j2: GLint);
begin
  FGLEvalMesh2(mode, i1, i2, j1, j2);
end;

procedure TGLLibrary.glEvalPoint1(i: GLint);
begin
  FGLEvalPoint1(i);
end;

procedure TGLLibrary.glEvalPoint2(i, j: GLint);
begin
  FGLEvalPoint2(i, j);
end;

procedure TGLLibrary.glFeedbackBuffer(size: GLsizei; atype: GLenum; buffer: PGLfloat);
begin
  FGLFeedbackBuffer(size, atype, buffer);
end;

procedure TGLLibrary.glFinish;
begin
  FGLFinish();
end;

procedure TGLLibrary.glFlush;
begin
  FGLFlush();
end;

procedure TGLLibrary.glFogf(pname: GLenum; param: GLfloat);
begin
  FGLFogf(pname, param);
end;

procedure TGLLibrary.glFogfv(pname: GLenum; const params: PGLfloat);
begin
  FGLFogfv(pname, params);
end;

procedure TGLLibrary.glFogi(pname: GLenum; param: GLint);
begin
  FGLFogi(pname, param);
end;

procedure TGLLibrary.glFogiv(pname: GLenum; const params: PGLint);
begin
  FGLFogiv(pname, params);
end;

procedure TGLLibrary.glFrontFace(mode: GLenum);
begin
  FGLFrontFace(mode);
end;

procedure TGLLibrary.glFrustum(left, right, bottom, top, zNear, zFar: GLdouble);
begin
  FGLFrustum(left, right, bottom, top, zNear, zFar);
end;

function TGLLibrary.glGenLists(range: GLsizei): GLuint;
begin
  FGLGenLists(range);
end;

procedure TGLLibrary.glGenTextures(n: GLsizei; textures: PGLuint);
begin
  FGLGenTextures(n, textures);
end;

procedure TGLLibrary.glGetBooleanv(pname: GLenum; params: PGLboolean);
begin
  FGLGetBooleanv(pname, params);
end;

procedure TGLLibrary.glGetClipPlane(plane: GLenum; equation: PGLdouble);
begin
  FGLClipPlane(plane, equation);
end;

procedure TGLLibrary.glGetDoublev(pname: GLenum; params: PGLdouble);
begin
  FGLGetDoublev(pname, params);
end;

function TGLLibrary.glGetError: GLenum;
begin
  Result := FGLGetError();
end;

procedure TGLLibrary.glGetFloatv(pname: GLenum; params: PGLfloat);
begin
  FGLGetFloatv(pname, params);
end;

procedure TGLLibrary.glGetIntegerv(pname: GLenum; params: PGLint);
begin
  FGLGetIntegerv(pname, params);
end;

procedure TGLLibrary.glGetLightfv(light, pname: GLenum; params: PGLfloat);
begin
  FGLGetLightfv(light, pname, params);
end;

procedure TGLLibrary.glGetLightiv(light, pname: GLenum; params: PGLint);
begin
  FGLGetLightiv(light, pname, params);
end;

procedure TGLLibrary.glGetMapdv(target, query: GLenum; v: PGLdouble);
begin
  FGLGetMapdv(target, query, v);
end;

procedure TGLLibrary.glGetMapfv(target, query: GLenum; v: PGLfloat);
begin
  FGLGetMapfv(target, query, v);
end;

procedure TGLLibrary.glGetMapiv(target, query: GLenum; v: PGLint);
begin
  FGLGetMapiv(target, query, v);
end;

procedure TGLLibrary.glGetMaterialfv(face, pname: GLenum; params: PGLfloat);
begin
  FGLGetMaterialfv(face, pname, params);
end;

procedure TGLLibrary.glGetMaterialiv(face, pname: GLenum; params: PGLint);
begin
  FGLGetMaterialiv(face, pname, params);
end;

procedure TGLLibrary.glGetPixelMapfv(map: GLenum; values: PGLfloat);
begin
  FGLGetPixelMapfv(map, values);
end;

procedure TGLLibrary.glGetPixelMapuiv(map: GLenum; values: PGLuint);
begin
  FGLGetPixelMapuiv(map, values);
end;

procedure TGLLibrary.glGetPixelMapusv(map: GLenum; values: PGLushort);
begin
  FGLGetPixelMapusv(map, values);
end;

procedure TGLLibrary.glGetPointerv(pname: GLenum; params: Pointer);
begin
  FGLGetPixelMapfv(pname, params);
end;

procedure TGLLibrary.glGetPolygonStipple(mask: PGLubyte);
begin
  FGLGetPolygonStipple(mask);
end;

function TGLLibrary.glGetString(Name: GLenum): pansichar;
begin
  FGLGetString(Name);
end;

procedure TGLLibrary.glGetTexEnvfv(target, pname: GLenum; params: PGLfloat);
begin
  FGLGetTexEnvfv(target, pname, params);
end;

procedure TGLLibrary.glGetTexEnviv(target, pname: GLenum; params: PGLint);
begin
  FGLGetTexEnviv(target, pname, params);
end;

procedure TGLLibrary.glGetTexGendv(coord, pname: GLenum; params: PGLdouble);
begin
  FGLGetTexGendv(coord, pname, params);
end;

procedure TGLLibrary.glGetTexGenfv(coord, pname: GLenum; params: PGLfloat);
begin
  FGLGetTexGenfv(coord, pname, params);
end;

procedure TGLLibrary.glGetTexGeniv(coord, pname: GLenum; params: PGLint);
begin
  FGLGetTexGeniv(coord, pname, params);
end;

procedure TGLLibrary.glGetTexImage(target: GLenum; level: GLint; format: GLenum; atype: GLenum; pixels: Pointer);
begin
  FGLGetTexImage(target, level, format, atype, pixels);
end;

procedure TGLLibrary.glGetTexLevelParameterfv(target: GLenum; level: GLint; pname: GLenum; params: Pointer);
begin
  FGLGetTexLevelParameterfv(target, level, pname, params);
end;

procedure TGLLibrary.glGetTexLevelParameteriv(target: GLenum; level: GLint; pname: GLenum; params: PGLint);
begin
  FGLGetTexLevelParameteriv(target, level, pname, params);
end;

procedure TGLLibrary.glGetTexParameterfv(target, pname: GLenum; params: PGLfloat);
begin
  FGLGetTexParameterfv(target, pname, params);
end;

procedure TGLLibrary.glGetTexParameteriv(target, pname: GLenum; params: PGLint);
begin
  FGLGetTexParameteriv(target, pname, params);
end;

procedure TGLLibrary.glHint(target, mode: GLenum);
begin
  FGLHint(target, mode);
end;

procedure TGLLibrary.glIndexMask(mask: GLuint);
begin
  FGLIndexMask(mask);
end;

procedure TGLLibrary.glIndexPointer(atype: GLenum; stride: GLsizei; const pointer: Pointer);
begin
  FGLIndexPointer(atype, stride, pointer);
end;

procedure TGLLibrary.glIndexd(c: GLdouble);
begin
  FGLIndexd(c);
end;

procedure TGLLibrary.glIndexdv(const c: PGLdouble);
begin
  FGLIndexdv(c);
end;

procedure TGLLibrary.glIndexf(c: GLfloat);
begin
  FGLIndexf(c);
end;

procedure TGLLibrary.glIndexfv(const c: PGLfloat);
begin
  FGLIndexfv(c);
end;

procedure TGLLibrary.glIndexi(c: GLint);
begin
  FGLIndexi(c);
end;

procedure TGLLibrary.glIndexiv(const c: PGLint);
begin
  FGLIndexiv(c);
end;

procedure TGLLibrary.glIndexs(c: GLshort);
begin
  FGLIndexs(c);
end;

procedure TGLLibrary.glIndexsv(const c: PGLshort);
begin
  FGLIndexsv(c);
end;

procedure TGLLibrary.glIndexub(c: GLubyte);
begin
  FGLIndexub(c);
end;

procedure TGLLibrary.glIndexubv(const c: PGLubyte);
begin
  FGLIndexubv(c);
end;

procedure TGLLibrary.glInitNames;
begin
  FGLInitNames();
end;

procedure TGLLibrary.glInterleavedArrays(format: GLenum; stride: GLsizei; const pointer: Pointer);
begin
  FGLInterleavedArrays(format, stride, pointer);
end;

function TGLLibrary.glIsEnabled(cap: GLenum): GLboolean;
begin
  FGLIsEnabled(cap);
end;

function TGLLibrary.glIsList(list: GLuint): GLboolean;
begin
  FGLIsList(list);
end;

function TGLLibrary.glIsTexture(texture: GLuint): GLboolean;
begin
  FGLIsTexture(texture);
end;

procedure TGLLibrary.glLightModelf(pname: GLenum; param: GLfloat);
begin
  FGLLightModelf(pname, param);
end;

procedure TGLLibrary.glLightModelfv(pname: GLenum; const params: PGLfloat);
begin
  FGLLightModelfv(pname, params);
end;

procedure TGLLibrary.glLightModeli(pname: GLenum; param: GLint);
begin
  FGLLightModeli(pname, param);
end;

procedure TGLLibrary.glLightModeliv(pname: GLenum; const params: PGLint);
begin
  FGLLightModeliv(pname, params);
end;

procedure TGLLibrary.glLightf(light, pname: GLenum; param: GLfloat);
begin
  FGLLightf(light, pname, param);
end;

procedure TGLLibrary.glLightfv(light, pname: GLenum; const params: PGLfloat);
begin
  FGLLightfv(light, pname, params);
end;

procedure TGLLibrary.glLighti(light, pname: GLenum; param: GLint);
begin
  FGLLighti(light, pname, param);
end;

procedure TGLLibrary.glLightiv(light, pname: GLenum; const params: PGLint);
begin
  FGLLightiv(light, pname, params);
end;

procedure TGLLibrary.glLineStipple(factor: GLint; pattern: GLushort);
begin
  FGLLineStipple(factor, pattern);
end;

procedure TGLLibrary.glLineWidth(Width: GLfloat);
begin
  FGLLineWidth(Width);
end;

procedure TGLLibrary.glListBase(base: GLuint);
begin
  FGLListBase(base);
end;

procedure TGLLibrary.glLoadIdentity;
begin
  FGLLoadIdentity();
end;

procedure TGLLibrary.glLoadMatrixd(const m: PGLdouble);
begin
  FGLLoadMatrixd(m);
end;

procedure TGLLibrary.glLoadMatrixf(const m: PGLfloat);
begin
  FGLLoadMatrixf(m);
end;

procedure TGLLibrary.glLoadName(Name: GLuint);
begin
  FGLLoadName(Name);
end;

procedure TGLLibrary.glLogicOp(opcode: GLenum);
begin
  FGLLogicOp(opcode);
end;

procedure TGLLibrary.glMap1d(target: GLenum; u1, u2: GLdouble; stride, order: GLint; const points: PGLdouble);
begin
  FGLMap1d(target, u1, u2, stride, order, points);
end;

procedure TGLLibrary.glMap1f(target: GLenum; u1, u2: GLfloat; stride, order: GLint; const points: PGLfloat);
begin
  FGLMap1f(target, u1, u2, stride, order, points);
end;

procedure TGLLibrary.glMap2d(target: GLenum; u1, u2: GLdouble; ustride, uorder: GLint; v1, v2: GLdouble; vstride, vorder: GLint; const points: PGLdouble);
begin
  FGLMap2d(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points);
end;

procedure TGLLibrary.glMap2f(target: GLenum; u1, u2: GLfloat; ustride, uorder: GLint; v1, v2: GLfloat; vstride, vorder: GLint; const points: PGLfloat);
begin
  FGLMap2f(target, u1, u2, ustride, uorder, v1, v2, vstride, vorder, points);
end;

procedure TGLLibrary.glMapGrid1d(un: GLint; u1, u2: GLdouble);
begin
  FGLMapGrid1d(un, u1, u2);
end;

procedure TGLLibrary.glMapGrid1f(un: GLint; u1, u2: GLfloat);
begin
  FGLMapGrid1f(un, u1, u2);
end;

procedure TGLLibrary.glMapGrid2d(un: GLint; u1, u2: GLdouble; vn: GLint; v1, v2: GLdouble);
begin
  FGLMapGrid2d(un, u1, u2, vn, v1, v2);
end;

procedure TGLLibrary.glMapGrid2f(un: GLint; u1, u2: GLfloat; vn: GLint; v1, v2: GLfloat);
begin
  FGLMapGrid2f(un, u1, u2, vn, v1, v2);
end;

procedure TGLLibrary.glMaterialf(face, pname: GLenum; param: GLfloat);
begin
  FGLMaterialf(face, pname, param);
end;

procedure TGLLibrary.glMaterialfv(face, pname: GLenum; const params: PGLfloat);
begin
  FGLMaterialfv(face, pname, params);
end;

procedure TGLLibrary.glMateriali(face, pname: GLenum; param: GLint);
begin
  FGLMateriali(face, pname, param);
end;

procedure TGLLibrary.glMaterialiv(face, pname: GLenum; const params: PGLint);
begin
  FGLMaterialiv(face, pname, params);
end;

procedure TGLLibrary.glMatrixMode(mode: GLenum);
begin
  FGLMatrixMode(mode);
end;

procedure TGLLibrary.glMultMatrixd(const m: PGLdouble);
begin
  FGLMultMatrixd(m);
end;

procedure TGLLibrary.glMultMatrixf(const m: PGLfloat);
begin
  FGLMultMatrixf(m);
end;

procedure TGLLibrary.glNewList(list: GLuint; mode: GLenum);
begin
  FGLNewList(list, mode);
end;

procedure TGLLibrary.glNormal3b(nx, ny, nz: GLbyte);
begin
  FGLNormal3b(nx, ny, nz);
end;

procedure TGLLibrary.glNormal3bv(const v: PGLbyte);
begin
  FGLNormal3bv(v);
end;

procedure TGLLibrary.glNormal3d(nx, ny, nz: GLdouble);
begin
  FGLNormal3d(nx, ny, nz);
end;

procedure TGLLibrary.glNormal3dv(const v: PGLdouble);
begin
  FGLNormal3dv(v);
end;

procedure TGLLibrary.glNormal3f(nx, ny, nz: GLfloat);
begin
  FGLNormal3f(nx, ny, nz);
end;

procedure TGLLibrary.glNormal3fv(const v: PGLfloat);
begin
  FGLNormal3fv(v);
end;

procedure TGLLibrary.glNormal3i(nx, ny, nz: GLint);
begin
  FGLNormal3i(nx, ny, nz);
end;

procedure TGLLibrary.glNormal3iv(const v: PGLint);
begin
  FGLNormal3iv(v);
end;

procedure TGLLibrary.glNormal3s(nx, ny, nz: GLshort);
begin
  FGLNormal3s(nx, ny, nz);
end;

procedure TGLLibrary.glNormal3sv(const v: PGLshort);
begin
  FGLNormal3sv(v);
end;

procedure TGLLibrary.glNormalPointer(atype: GLenum; stride: GLsizei; const pointer: Pointer);
begin
  FGLNormalPointer(atype, stride, pointer);
end;

procedure TGLLibrary.glOrtho(left, right, bottom, top, zNear, zFar: GLdouble);
begin
  FGLOrtho(left, right, bottom, top, zNear, zFar);
end;

procedure TGLLibrary.glPassThrough(token: GLfloat);
begin
  FGLPassThrough(token);
end;

procedure TGLLibrary.glPixelMapfv(map: GLenum; mapsize: GLint; const values: PGLfloat);
begin
  FGLPixelMapfv(map, mapsize, values);
end;

procedure TGLLibrary.glPixelMapuiv(map: GLenum; mapsize: GLint; const values: PGLuint);
begin
  FGLPixelMapuiv(map, mapsize, values);
end;

procedure TGLLibrary.glPixelMapusv(map: GLenum; mapsize: GLint; const values: PGLushort);
begin
  FGLPixelMapusv(map, mapsize, values);
end;

procedure TGLLibrary.glPixelStoref(pname: GLenum; param: GLfloat);
begin
  FGLPixelStoref(pname, param);
end;

procedure TGLLibrary.glPixelStorei(pname: GLenum; param: GLint);
begin
  FGLPixelStorei(pname, param);
end;

procedure TGLLibrary.glPixelTransferf(pname: GLenum; param: GLfloat);
begin
  FGLPixelTransferf(pname, param);
end;

procedure TGLLibrary.glPixelTransferi(pname: GLenum; param: GLint);
begin
  FGLPixelTransferi(pname, param);
end;

procedure TGLLibrary.glPixelZoom(xfactor, yfactor: GLfloat);
begin
  FGLPixelZoom(xfactor, yfactor);
end;

procedure TGLLibrary.glPointSize(size: GLfloat);
begin
  FGLPointSize(size);
end;

procedure TGLLibrary.glPolygonMode(face, mode: GLenum);
begin
  FGLPolygonMode(face, mode);
end;

procedure TGLLibrary.glPolygonOffset(factor, units: GLfloat);
begin
  FGLPolygonOffset(factor, units);
end;

procedure TGLLibrary.glPolygonStipple(const mask: PGLubyte);
begin
  FGLPolygonStipple(mask);
end;

procedure TGLLibrary.glPopAttrib;
begin
  FGLPopAttrib();
end;

procedure TGLLibrary.glPopClientAttrib;
begin
  FGLPopClientAttrib();
end;

procedure TGLLibrary.glPopMatrix;
begin
  FGLPopMatrix();
end;

procedure TGLLibrary.glPopName;
begin
  FGLPopName();
end;

procedure TGLLibrary.glPrioritizeTextures(n: GLsizei; const textures: PGLuint; const priorities: PGLclampf);
begin
  FGLPrioritizeTextures(n, textures, priorities);
end;

procedure TGLLibrary.glPushAttrib(mask: GLbitfield);
begin
  FGLPushAttrib(mask);
end;

procedure TGLLibrary.glPushClientAttrib(mask: GLbitfield);
begin
  FGLPushClientAttrib(mask);
end;

procedure TGLLibrary.glPushMatrix;
begin
  FGLPushMatrix();
end;

procedure TGLLibrary.glPushName(Name: GLuint);
begin
  FGLPushName(Name);
end;

procedure TGLLibrary.glRasterPos2d(x, y: GLdouble);
begin
  FGLRasterPos2d(x, y);
end;

procedure TGLLibrary.glRasterPos2dv(const v: PGLdouble);
begin
  FGLRasterPos2dv(v);
end;

procedure TGLLibrary.glRasterPos2f(x, y: GLfloat);
begin
  FGLRasterPos2f(x, y);
end;

procedure TGLLibrary.glRasterPos2fv(const v: PGLfloat);
begin
  FGLRasterPos2fv(v);
end;

procedure TGLLibrary.glRasterPos2i(x, y: GLint);
begin
  FGLRasterPos2i(x, y);
end;

procedure TGLLibrary.glRasterPos2iv(const v: PGLint);
begin
  FGLRasterPos2iv(v);
end;

procedure TGLLibrary.glRasterPos2s(x, y: GLshort);
begin
  FGLRasterPos2s(x, y);
end;

procedure TGLLibrary.glRasterPos2sv(const v: PGLshort);
begin
  FGLRasterPos2sv(v);
end;

procedure TGLLibrary.glRasterPos3d(x, y, z: GLdouble);
begin
  FGLRasterPos3d(x, y, y);
end;

procedure TGLLibrary.glRasterPos3dv(const v: PGLdouble);
begin
  FGLRasterPos2dv(v);
end;

procedure TGLLibrary.glRasterPos3f(x, y, z: GLfloat);
begin
  FGLRasterPos3f(x, y, z);
end;

procedure TGLLibrary.glRasterPos3fv(const v: PGLfloat);
begin
  FGLRasterPos3fv(v);
end;

procedure TGLLibrary.glRasterPos3i(x, y, z: GLint);
begin
  FGLRasterPos3i(x, y, z);
end;

procedure TGLLibrary.glRasterPos3iv(const v: PGLint);
begin
  FGLRasterPos3iv(v);
end;

procedure TGLLibrary.glRasterPos3s(x, y, z: GLshort);
begin
  FGLRasterPos3s(x, y, z);
end;

procedure TGLLibrary.glRasterPos3sv(const v: PGLshort);
begin
  FGLRasterPos3sv(v);
end;

procedure TGLLibrary.glRasterPos4d(x, y, z, w: GLdouble);
begin
  FGLRasterPos4d(x, y, z, w);
end;

procedure TGLLibrary.glRasterPos4dv(const v: PGLdouble);
begin
  FGLRasterPos4dv(v);
end;

procedure TGLLibrary.glRasterPos4f(x, y, z, w: GLfloat);
begin
  FGLRasterPos4f(x, y, z, w);
end;

procedure TGLLibrary.glRasterPos4fv(const v: PGLfloat);
begin
  FGLRasterPos4fv(v);
end;

procedure TGLLibrary.glRasterPos4i(x, y, z, w: GLint);
begin
  FGLRasterPos4i(x, y, z, w);
end;

procedure TGLLibrary.glRasterPos4iv(const v: PGLint);
begin
  FGLRasterPos4iv(v);
end;

procedure TGLLibrary.glRasterPos4s(x, y, z, w: GLshort);
begin
  FGLRasterPos4s(x, y, z, w);
end;

procedure TGLLibrary.glRasterPos4sv(const v: PGLshort);
begin
  FGLRasterPos4sv(v);
end;

procedure TGLLibrary.glReadBuffer(mode: GLenum);
begin
  FGLReadBuffer(mode);
end;

procedure TGLLibrary.glReadPixels(x, y: GLint; Width, Height: GLsizei; format, atype: GLenum; pixels: Pointer);
begin
  FGLReadPixels(x, y, Width, Height, format, atype, pixels);
end;

procedure TGLLibrary.glRectd(x1, y1, x2, y2: GLdouble);
begin
  FGLRectd(x1, y1, x2, y2);
end;

procedure TGLLibrary.glRectdv(const v1: PGLdouble; const v2: PGLdouble);
begin
  FGLRectdv(v1, v2);
end;

procedure TGLLibrary.glRectf(x1, y1, x2, y2: GLfloat);
begin
  FGLRectf(x1, y1, x2, y2);
end;

procedure TGLLibrary.glRectfv(const v1: PGLfloat; const v2: PGLfloat);
begin
  FGLRectfv(v1, v2);
end;

procedure TGLLibrary.glRecti(x1, y1, x2, y2: GLint);
begin
  FGLRecti(x1, y1, x2, y2);
end;

procedure TGLLibrary.glRectiv(const v1: PGLint; const v2: PGLint);
begin
  FGLRectiv(v1, v2);
end;

procedure TGLLibrary.glRects(x1, y1, x2, y2: GLshort);
begin
  FGLRects(x1, y1, x2, y2);
end;

procedure TGLLibrary.glRectsv(const v1: PGLshort; const v2: PGLshort);
begin
  FGLRectsv(v1, v2);
end;

function TGLLibrary.glRenderMode(mode: GLint): GLint;
begin
  FGLRenderMode(mode);
end;

procedure TGLLibrary.glRotated(angle, x, y, z: GLdouble);
begin
  FGLRotated(angle, x, y, z);
end;

procedure TGLLibrary.glRotatef(angle, x, y, z: GLfloat);
begin
  FGLRotatef(angle, x, y, z);
end;

procedure TGLLibrary.glScaled(x, y, z: GLdouble);
begin
  FGLScaled(x, y, z);
end;

procedure TGLLibrary.glScalef(x, y, z: GLfloat);
begin
  FGLScalef(x, y, z);
end;

procedure TGLLibrary.glScissor(x, y: GLint; Width, Height: GLsizei);
begin
  FGLScissor(x, y, Width, Height);
end;

procedure TGLLibrary.glSelectBuffer(size: GLsizei; buffer: PGLuint);
begin
  FGLSelectBuffer(size, buffer);
end;

procedure TGLLibrary.glShadeModel(mode: GLenum);
begin
  FGLShadeModel(mode);
end;

procedure TGLLibrary.glStencilFunc(func: GLenum; ref: GLint; mask: GLuint);
begin
  FGLStencilFunc(func, ref, mask);
end;

procedure TGLLibrary.glStencilMask(mask: GLuint);
begin
  FGLStencilMask(mask);
end;

procedure TGLLibrary.glStencilOp(fail, zfail, zpass: GLenum);
begin
  FGLStencilOp(fail, zfail, zpass);
end;

procedure TGLLibrary.glTexCoord1d(s: GLdouble);
begin
  FGLTexCoord1d(s);
end;

procedure TGLLibrary.glTexCoord1dv(const v: PGLdouble);
begin
  FGLTexCoord1dv(v);
end;

procedure TGLLibrary.glTexCoord1f(s: GLfloat);
begin
  FGLTexCoord1d(s);
end;

procedure TGLLibrary.glTexCoord1fv(const v: PGLfloat);
begin
  FGLTexCoord1fv(v);
end;

procedure TGLLibrary.glTexCoord1i(s: GLint);
begin
  FGLTexCoord1i(s);
end;

procedure TGLLibrary.glTexCoord1iv(const v: PGLint);
begin
  FGLTexCoord1iv(v);
end;

procedure TGLLibrary.glTexCoord1s(s: GLshort);
begin
  FGLTexCoord1s(s);
end;

procedure TGLLibrary.glTexCoord1sv(const v: PGLshort);
begin
  FGLTexCoord1sv(v);
end;

procedure TGLLibrary.glTexCoord2d(s, t: GLdouble);
begin
  FGLTexCoord2d(s, t);
end;

procedure TGLLibrary.glTexCoord2dv(const v: PGLdouble);
begin
  FGLTexCoord2dv(v);
end;

procedure TGLLibrary.glTexCoord2f(s, t: GLfloat);
begin
  FGLTexCoord2f(s, t);
end;

procedure TGLLibrary.glTexCoord2fv(const v: PGLfloat);
begin
  FGLTexCoord2fv(v);
end;

procedure TGLLibrary.glTexCoord2i(s, t: GLint);
begin
  FGLTexCoord2i(s, t);
end;

procedure TGLLibrary.glTexCoord2iv(const v: PGLint);
begin
  FGLTexCoord2iv(v);
end;

procedure TGLLibrary.glTexCoord2s(s, t: GLshort);
begin
  FGLTexCoord2s(s, t);
end;

procedure TGLLibrary.glTexCoord2sv(const v: PGLshort);
begin
  FGLTexCoord2sv(v);
end;

procedure TGLLibrary.glTexCoord3d(s, t, r: GLdouble);
begin
  FGLTexCoord3d(s, t, r);
end;

procedure TGLLibrary.glTexCoord3dv(const v: PGLdouble);
begin
  FGLTexCoord3dv(v);
end;

procedure TGLLibrary.glTexCoord3f(s, t, r: GLfloat);
begin
  FGLTexCoord3f(s, t, r);
end;

procedure TGLLibrary.glTexCoord3fv(const v: PGLfloat);
begin
  FGLTexCoord3fv(v);
end;

procedure TGLLibrary.glTexCoord3i(s, t, r: GLint);
begin
  FGLTexCoord3i(s, t, r);
end;

procedure TGLLibrary.glTexCoord3iv(const v: PGLint);
begin
  FGLTexCoord3iv(v);
end;

procedure TGLLibrary.glTexCoord3s(s, t, r: GLshort);
begin
  FGLTexCoord3s(s, t, r);
end;

procedure TGLLibrary.glTexCoord3sv(const v: PGLshort);
begin
  FGLTexCoord3sv(v);
end;

procedure TGLLibrary.glTexCoord4d(s, t, r, q: GLdouble);
begin
  FGLTexCoord4d(s, t, r, q);
end;

procedure TGLLibrary.glTexCoord4dv(const v: PGLdouble);
begin
  FGLTexCoord4dv(v);
end;

procedure TGLLibrary.glTexCoord4f(s, t, r, q: GLfloat);
begin
  FGLTexCoord4f(s, t, r, q);
end;

procedure TGLLibrary.glTexCoord4fv(const v: PGLfloat);
begin
  FGLTexCoord4fv(v);
end;

procedure TGLLibrary.glTexCoord4i(s, t, r, q: GLint);
begin
  FGLTexCoord4i(s, t, r, q);
end;

procedure TGLLibrary.glTexCoord4iv(const v: PGLint);
begin
  FGLTexCoord4iv(v);
end;

procedure TGLLibrary.glTexCoord4s(s, t, r, q: GLshort);
begin
  FGLTexCoord4s(s, t, r, q);
end;

procedure TGLLibrary.glTexCoord4sv(const v: PGLshort);
begin
  FGLTexCoord4sv(v);
end;

procedure TGLLibrary.glTexCoordPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer);
begin
  FGLTexCoordPointer(size, atype, stride, pointer);
end;

procedure TGLLibrary.glTexEnvf(target: GLenum; pname: GLenum; param: GLfloat);
begin
  FGLTexEnvf(target, pname, param);
end;

procedure TGLLibrary.glTexEnvfv(target: GLenum; pname: GLenum; const params: PGLfloat);
begin
  FGLTexEnvfv(target, pname, params);
end;

procedure TGLLibrary.glTexEnvi(target: GLenum; pname: GLenum; param: GLint);
begin
  FGLTexEnvi(target, pname, param);
end;

procedure TGLLibrary.glTexEnviv(target: GLenum; pname: GLenum; const params: PGLint);
begin
  FGLTexEnviv(target, pname, params);
end;

procedure TGLLibrary.glTexGend(coord: GLenum; pname: GLenum; param: GLdouble);
begin
  FGlTexGend(coord, pname, param);
end;

procedure TGLLibrary.glTexGendv(coord: GLenum; pname: GLenum; const params: PGLdouble);
begin
  FGlTexGendv(coord, pname, params);
end;

procedure TGLLibrary.glTexGenf(coord: GLenum; pname: GLenum; param: GLfloat);
begin
  FGlTexGenf(coord, pname, param);
end;

procedure TGLLibrary.glTexGenfv(coord: GLenum; pname: GLenum; const params: PGLfloat);
begin
  FGlTexGenfv(coord, pname, params);
end;

procedure TGLLibrary.glTexGeni(coord: GLenum; pname: GLenum; param: GLint);
begin
  FGlTexGeni(coord, pname, param);
end;

procedure TGLLibrary.glTexGeniv(coord: GLenum; pname: GLenum; const params: PGLint);
begin
  FGlTexGeniv(coord, pname, params);
end;

procedure TGLLibrary.glTexImage1D(target: GLenum; level: GLInt; internalformat: GLEnum; Width: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer);
begin
  FGLTexImage1D(target, level, internalformat, Width, border, format, atype, pixels);
end;

procedure TGLLibrary.glTexImage2D(target: GLenum; level: GLInt; internalformat: GLEnum; Width, Height: GLsizei; border: GLint; format, atype: GLenum; const pixels: Pointer);
begin
  FGLTexImage2D(target, level, internalformat, Width, Height, border, format, atype, pixels);
end;

procedure TGLLibrary.glTexParameterf(target: GLenum; pname: GLenum; param: GLfloat);
begin
  FglTexParameterf(target, pname, param);
end;

procedure TGLLibrary.glTexParameterfv(target: GLenum; pname: GLenum; const params: PGLfloat);
begin
  FglTexParameterfv(target, pname, params);
end;

procedure TGLLibrary.glTexParameteri(target: GLenum; pname: GLenum; param: GLint);
begin
  FGLTexParameteri(target, pname, param);
end;

procedure TGLLibrary.glTexParameteriv(target: GLenum; pname: GLenum; const params: PGLint);
begin
  FGLTexParameteriv(target, pname, params);
end;

procedure TGLLibrary.glTexSubImage1D(target: GLenum; level, xoffset: GLint; Width: GLsizei; format, atype: GLenum; const pixels: Pointer);
begin
  FGLTexSubImage1D(target, level, xoffset, Width, format, atype, pixels);
end;

procedure TGLLibrary.glTexSubImage2D(target: GLenum; level, xoffset, yoffset: GLint; Width, Height: GLsizei; format, atype: GLenum; const pixels: Pointer);
begin
  FGLTexSubImage2D(target, level, xoffset, yoffset, Width, Height, format, atype, pixels);
end;

procedure TGLLibrary.glTranslated(x, y, z: GLdouble);
begin
  FGLTranslated(x, y, z);
end;

procedure TGLLibrary.glTranslatef(x, y, z: GLfloat);
begin
  FGLTranslatef(x, y, z);
end;

procedure TGLLibrary.glVertex2d(x, y: GLdouble);
begin
  FGLVertex2d(x, y);
end;

procedure TGLLibrary.glVertex2dv(const v: PGLdouble);
begin
  FGLVertex2dv(v);
end;

procedure TGLLibrary.glVertex2f(x, y: GLfloat);
begin
  FGLVertex2f(x, y);
end;

procedure TGLLibrary.glVertex2fv(const v: PGLfloat);
begin
  FGLVertex2fv(v);
end;

procedure TGLLibrary.glVertex2i(x, y: GLint);
begin
  FGLVertex2i(x, y);
end;

procedure TGLLibrary.glVertex2iv(const v: PGLint);
begin
  FGLVertex2iv(v);
end;

procedure TGLLibrary.glVertex2s(x, y: GLshort);
begin
  FGLVertex2s(x, y);
end;

procedure TGLLibrary.glVertex2sv(const v: PGLshort);
begin
  FGLVertex2sv(v);
end;

procedure TGLLibrary.glVertex3d(x, y, z: GLdouble);
begin
  FGLVertex3d(x, y, z);
end;

procedure TGLLibrary.glVertex3dv(const v: PGLdouble);
begin
  FGLVertex3dv(v);
end;

procedure TGLLibrary.glVertex3f(x, y, z: GLfloat);
begin
  FGLVertex3f(x, y, z);
end;

procedure TGLLibrary.glVertex3fv(const v: PGLfloat);
begin
  FGLVertex3fv(v);
end;

procedure TGLLibrary.glVertex3i(x, y, z: GLint);
begin
  FGLVertex3i(x, y, z);
end;

procedure TGLLibrary.glVertex3iv(const v: PGLint);
begin
  FGLVertex3iv(v);
end;

procedure TGLLibrary.glVertex3s(x, y, z: GLshort);
begin
  FGLVertex3s(x, y, z);
end;

procedure TGLLibrary.glVertex3sv(const v: PGLshort);
begin
  FGLVertex3sv(v);
end;

procedure TGLLibrary.glVertex4d(x, y, z, w: GLdouble);
begin
  FGLVertex4d(x, y, w, w);
end;

procedure TGLLibrary.glVertex4dv(const v: PGLdouble);
begin
  FGLVertex4dv(v);
end;

procedure TGLLibrary.glVertex4f(x, y, z, w: GLfloat);
begin
  FGLVertex4f(x, y, w, w);
end;

procedure TGLLibrary.glVertex4fv(const v: PGLfloat);
begin
  FGLVertex4fv(v);
end;

procedure TGLLibrary.glVertex4i(x, y, z, w: GLint);
begin
  FGLVertex4i(x, y, w, w);
end;

procedure TGLLibrary.glVertex4iv(const v: PGLint);
begin
  FGLVertex4iv(v);
end;

procedure TGLLibrary.glVertex4s(x, y, z, w: GLshort);
begin
  FGLVertex4s(x, y, w, w);
end;

procedure TGLLibrary.glVertex4sv(const v: PGLshort);
begin
  FGLVertex4sv(v);
end;

procedure TGLLibrary.glVertexPointer(size: GLint; atype: GLenum; stride: GLsizei; const pointer: Pointer);
begin
  FGLVertexPointer(size, atype, stride, pointer);
end;

procedure TGLLibrary.glViewport(x, y: GLint; Width, Height: GLsizei);
begin
  FGLViewport(x, y, Width, Height);
end;


initialization

  GL := TGLLibrary.Create;

finalization

  GL.Free;
end.
