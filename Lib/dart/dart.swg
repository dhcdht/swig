/* -----------------------------------------------------------------------------
 * dart.swg
 *
 * dart typemaps
 * ----------------------------------------------------------------------------- */

%include <darthead.swg>

/* The jni, jtype and jstype typemaps work together and so there should be one of each. 
 * The jni typemap contains the JNI type used in the JNI (C/C++) code. 
 * The jtype typemap contains the dart type used in the JNI intermediary class. 
 * The jstype typemap contains the dart type used in the dart proxy classes, type wrapper classes and module class. */

/* Fragments */
%fragment("SWIG_PackData", "header") {
/* Pack binary data into a string */
SWIGINTERN char * SWIG_PackData(char *c, void *ptr, size_t sz) {
  static const char hex[17] = "0123456789abcdef";
  const unsigned char *u = (unsigned char *) ptr;
  const unsigned char *eu =  u + sz;
  for (; u != eu; ++u) {
    unsigned char uu = *u;
    *(c++) = hex[(uu & 0xf0) >> 4];
    *(c++) = hex[uu & 0xf];
  }
  return c;
}
}

%fragment("SWIG_UnPackData", "header") {
/* Unpack binary data from a string */
SWIGINTERN const char * SWIG_UnpackData(const char *c, void *ptr, size_t sz) {
  unsigned char *u = (unsigned char *) ptr;
  const unsigned char *eu = u + sz;
  for (; u != eu; ++u) {
    char d = *(c++);
    unsigned char uu;
    if ((d >= '0') && (d <= '9'))
      uu = ((d - '0') << 4);
    else if ((d >= 'a') && (d <= 'f'))
      uu = ((d - ('a'-10)) << 4);
    else 
      return (char *) 0;
    d = *(c++);
    if ((d >= '0') && (d <= '9'))
      uu |= (d - '0');
    else if ((d >= 'a') && (d <= 'f'))
      uu |= (d - ('a'-10));
    else 
      return (char *) 0;
    *u = uu;
  }
  return c;
}
}

%fragment("SWIG_dartIntFromSize_t", "header") {
/* Check for overflow converting to dart int (always signed 32-bit) from (unsigned variable-bit) size_t */
SWIGINTERN jint SWIG_dartIntFromSize_t(size_t size) {
  static const jint JINT_MAX = 0x7FFFFFFF;
  return (size > (size_t)JINT_MAX) ? -1 : (jint)size;
}
}

/* Primitive types */
%typemap(jni) bool,               const bool &               "bool"
%typemap(jni) char,               const char &               "char"
%typemap(jni) signed char,        const signed char &        "signed char"
%typemap(jni) unsigned char,      const unsigned char &      "unsigned char"
%typemap(jni) short,              const short &              "short"
%typemap(jni) unsigned short,     const unsigned short &     "unsigned short"
%typemap(jni) int,                const int &                "int"
%typemap(jni) unsigned int,       const unsigned int &       "unsigned in"
%typemap(jni) long,               const long &               "long"
%typemap(jni) unsigned long,      const unsigned long &      "unsigned long"
%typemap(jni) long long,          const long long &          "long long"
%typemap(jni) unsigned long long, const unsigned long long & "unsigned long long"
%typemap(jni) float,              const float &              "float"
%typemap(jni) double,             const double &             "double"
%typemap(jni) void                                           "void"

%typemap(jtype) bool,               const bool &               "boolean"
%typemap(jtype) char,               const char &               "char"
%typemap(jtype) signed char,        const signed char &        "byte"
%typemap(jtype) unsigned char,      const unsigned char &      "short"
%typemap(jtype) short,              const short &              "short"
%typemap(jtype) unsigned short,     const unsigned short &     "Int"
%typemap(jtype) int,                const int &                "Int"
%typemap(jtype) unsigned int,       const unsigned int &       "long"
%typemap(jtype) long,               const long &               "Int"
%typemap(jtype) unsigned long,      const unsigned long &      "long"
%typemap(jtype) long long,          const long long &          "long"
%typemap(jtype) unsigned long long, const unsigned long long & "dart.math.BigInteger"
%typemap(jtype) float,              const float &              "float"
%typemap(jtype) double,             const double &             "Double"
%typemap(jtype) void                                           "Void"

%typemap(jstype) bool,               const bool &               "boolean"
%typemap(jstype) char,               const char &               "char"
%typemap(jstype) signed char,        const signed char &        "byte"
%typemap(jstype) unsigned char,      const unsigned char &      "short"
%typemap(jstype) short,              const short &              "short"
%typemap(jstype) unsigned short,     const unsigned short &     "int"
%typemap(jstype) int,                const int &                "int"
%typemap(jstype) unsigned int,       const unsigned int &       "long"
%typemap(jstype) long,               const long &               "int"
%typemap(jstype) unsigned long,      const unsigned long &      "long"
%typemap(jstype) long long,          const long long &          "long"
%typemap(jstype) unsigned long long, const unsigned long long & "dart.math.BigInteger"
%typemap(jstype) float,              const float &              "float"
%typemap(jstype) double,             const double &             "double"
%typemap(jstype) void                                           "void"

%typemap(jboxtype) bool,               const bool &               "Boolean"
%typemap(jboxtype) char,               const char &               "Character"
%typemap(jboxtype) signed char,        const signed char &        "Byte"
%typemap(jboxtype) unsigned char,      const unsigned char &      "Short"
%typemap(jboxtype) short,              const short &              "Short"
%typemap(jboxtype) unsigned short,     const unsigned short &     "Integer"
%typemap(jboxtype) int,                const int &                "Integer"
%typemap(jboxtype) unsigned int,       const unsigned int &       "Long"
%typemap(jboxtype) long,               const long &               "Integer"
%typemap(jboxtype) unsigned long,      const unsigned long &      "Long"
%typemap(jboxtype) long long,          const long long &          "Long"
%typemap(jboxtype) unsigned long long, const unsigned long long & "dart.math.BigInteger"
%typemap(jboxtype) float,              const float &              "Float"
%typemap(jboxtype) double,             const double &             "Double"

%typemap(jni) char *, char *&, char[ANY], char[]               "jstring"
%typemap(jtype) char *, char *&, char[ANY], char[]               "String"
%typemap(jstype) char *, char *&, char[ANY], char[]               "String"

/* JNI types */
%typemap(jni) jboolean      "bool"
%typemap(jni) jchar         "char"
%typemap(jni) jbyte         "char"
%typemap(jni) jshort        "short"
%typemap(jni) jint          "int"
%typemap(jni) jlong         "long"
%typemap(jni) jfloat        "float"
%typemap(jni) jdouble       "double"
%typemap(jni) jstring       "char*"
%typemap(jni) jobject       "unsigned long"
%typemap(jni) jbooleanArray "bool*"
%typemap(jni) jcharArray    "char*"
%typemap(jni) jbyteArray    "char*"
%typemap(jni) jshortArray   "short*"
%typemap(jni) jintArray     "int*"
%typemap(jni) jlongArray    "long*"
%typemap(jni) jfloatArray   "float*"
%typemap(jni) jdoubleArray  "double*"
%typemap(jni) jobjectArray  "unsigned long*"

%typemap(jtype) jboolean      "boolean"
%typemap(jtype) jchar         "char"
%typemap(jtype) jbyte         "byte"
%typemap(jtype) jshort        "short"
%typemap(jtype) jint          "int"
%typemap(jtype) jlong         "long"
%typemap(jtype) jfloat        "float"
%typemap(jtype) jdouble       "double"
%typemap(jtype) jstring       "String"
%typemap(jtype) jobject       "dart.lang.Object"
%typemap(jtype) jbooleanArray "boolean[]"
%typemap(jtype) jcharArray    "char[]"
%typemap(jtype) jbyteArray    "byte[]"
%typemap(jtype) jshortArray   "short[]"
%typemap(jtype) jintArray     "int[]"
%typemap(jtype) jlongArray    "long[]"
%typemap(jtype) jfloatArray   "float[]"
%typemap(jtype) jdoubleArray  "double[]"
%typemap(jtype) jobjectArray  "dart.lang.Object[]"

%typemap(jstype) jboolean      "boolean"
%typemap(jstype) jchar         "char"
%typemap(jstype) jbyte         "byte"
%typemap(jstype) jshort        "short"
%typemap(jstype) jint          "int"
%typemap(jstype) jlong         "long"
%typemap(jstype) jfloat        "float"
%typemap(jstype) jdouble       "double"
%typemap(jstype) jstring       "String"
%typemap(jstype) jobject       "dart.lang.Object"
%typemap(jstype) jbooleanArray "boolean[]"
%typemap(jstype) jcharArray    "char[]"
%typemap(jstype) jbyteArray    "byte[]"
%typemap(jstype) jshortArray   "short[]"
%typemap(jstype) jintArray     "int[]"
%typemap(jstype) jlongArray    "long[]"
%typemap(jstype) jfloatArray   "float[]"
%typemap(jstype) jdoubleArray  "double[]"
%typemap(jstype) jobjectArray  "dart.lang.Object[]"

/* Non primitive types */
%typemap(jni) SWIGTYPE "unsigned long"
%typemap(jtype) SWIGTYPE "unsigned long"
%typemap(jstype) SWIGTYPE "$&dartclassname"
%typemap(jboxtype) SWIGTYPE "$typemap(jstype, $1_type)"

%typemap(jni) SWIGTYPE [] "unsigned long"
%typemap(jtype) SWIGTYPE [] "unsigned long"
%typemap(jstype) SWIGTYPE [] "$dartclassname"

%typemap(jni) SWIGTYPE * "unsigned long"
%typemap(jtype) SWIGTYPE * "Int"
%typemap(jstype) SWIGTYPE * "$dartclassname"

%typemap(jni) SWIGTYPE & "unsigned long"
%typemap(jtype) SWIGTYPE & "unsigned long"
%typemap(jstype) SWIGTYPE & "$dartclassname"

%typemap(jni) SWIGTYPE && "unsigned long"
%typemap(jtype) SWIGTYPE && "unsigned long"
%typemap(jstype) SWIGTYPE && "$dartclassname"

/* pointer to a class member */
%typemap(jni) SWIGTYPE (CLASS::*) "jstring"
%typemap(jtype) SWIGTYPE (CLASS::*) "String"
%typemap(jstype) SWIGTYPE (CLASS::*) "$dartclassname"

/* The following are the in, out, freearg, argout typemaps. These are the JNI code generating typemaps for converting from Dart to C and visa versa. */

/* primitive types */
%typemap(in) bool
%{ $1 = $input ? true : false; %}

%typemap(directorout) bool
%{ $result = $input ? true : false; %}

%typemap(dartdirectorin) bool "$jniinput"
%typemap(dartdirectorout) bool "$dartcall"

%typemap(in) char, 
             signed char, 
             unsigned char, 
             short, 
             unsigned short, 
             int, 
             unsigned int, 
             long, 
             unsigned long, 
             long long, 
             float, 
             double
%{ $1 = ($1_ltype)$input; %}

%typemap(directorout) char, 
             signed char, 
             unsigned char, 
             short, 
             unsigned short, 
             int, 
             unsigned int, 
             long, 
             unsigned long, 
             long long, 
             float, 
             double
%{ $result = ($1_ltype)$input; %}

%typemap(directorin, descriptor="Z") bool             "$input = (jboolean) $1;"
%typemap(directorin, descriptor="C") char             "$input = (jint) $1;"
%typemap(directorin, descriptor="B") signed char      "$input = (jbyte) $1;"
%typemap(directorin, descriptor="S") unsigned char    "$input = (jshort) $1;"
%typemap(directorin, descriptor="S") short            "$input = (jshort) $1;"
%typemap(directorin, descriptor="I") unsigned short   "$input = (jint) $1;"
%typemap(directorin, descriptor="I") int              "$input = (jint) $1;"
%typemap(directorin, descriptor="J") unsigned int     "$input = (jlong) $1;"
%typemap(directorin, descriptor="I") long             "$input = (jint) $1;"
%typemap(directorin, descriptor="J") unsigned long    "$input = (jlong) $1;"
%typemap(directorin, descriptor="J") long long        "$input = (jlong) $1;"
%typemap(directorin, descriptor="F") float            "$input = (jfloat) $1;"
%typemap(directorin, descriptor="D") double           "$input = (jdouble) $1;"

%typemap(dartdirectorin) char, 
                         signed char, 
                         unsigned char, 
                         short, 
                         unsigned short, 
                         int, 
                         unsigned int, 
                         long, 
                         unsigned long, 
                         long long, 
                         float, 
                         double
  "$jniinput"

%typemap(dartdirectorout) char, 
                          signed char, 
                          unsigned char, 
                          short, 
                          unsigned short, 
                          int, 
                          unsigned int, 
                          long, 
                          unsigned long, 
                          long long, 
                          float, 
                          double
  "$dartcall"

%typemap(out) bool           %{ $result = (bool)$1; %}
%typemap(out) char           %{ $result = (char)$1; %}
%typemap(out) signed char    %{ $result = (signed char)$1; %}
%typemap(out) unsigned char  %{ $result = (unsigned char)$1; %}
%typemap(out) short          %{ $result = (short)$1; %}
%typemap(out) unsigned short %{ $result = (unsigned short)$1; %}
%typemap(out) int            %{ $result = (int)$1; %}
%typemap(out) unsigned int   %{ $result = (unsigned int)$1; %}
%typemap(out) long           %{ $result = (long)$1; %}
%typemap(out) unsigned long  %{ $result = (unsigned long)$1; %}
%typemap(out) long long      %{ $result = (long long)$1; %}
%typemap(out) float          %{ $result = (float)$1; %}
%typemap(out) double         %{ $result = (double)$1; %}

/* unsigned long long */
/* Convert from BigInteger using the toByteArray member function */
%typemap(in) unsigned long long { 
  jclass clazz;
  jmethodID mid;
  jbyteArray ba;
  jbyte* bae;
  jsize sz;
  int i;

  if (!$input) {
    SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "BigInteger null");
    return $null;
  }
  clazz = JCALL1(GetObjectClass, jenv, $input);
  mid = JCALL3(GetMethodID, jenv, clazz, "toByteArray", "()[B");
  ba = (jbyteArray)JCALL2(CallObjectMethod, jenv, $input, mid);
  bae = JCALL2(GetByteArrayElements, jenv, ba, 0);
  sz = JCALL1(GetArrayLength, jenv, ba);
  $1 = 0;
  if (sz > 0) {
    $1 = ($1_type)(signed char)bae[0];
    for(i=1; i<sz; i++) {
      $1 = ($1 << 8) | ($1_type)(unsigned char)bae[i];
    }
  }
  JCALL3(ReleaseByteArrayElements, jenv, ba, bae, 0);
}

%typemap(directorout) unsigned long long { 
  jclass clazz;
  jmethodID mid;
  jbyteArray ba;
  jbyte* bae;
  jsize sz;
  int i;

  if (!$input) {
    SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "BigInteger null");
    return $null;
  }
  clazz = JCALL1(GetObjectClass, jenv, $input);
  mid = JCALL3(GetMethodID, jenv, clazz, "toByteArray", "()[B");
  ba = (jbyteArray)JCALL2(CallObjectMethod, jenv, $input, mid);
  bae = JCALL2(GetByteArrayElements, jenv, ba, 0);
  sz = JCALL1(GetArrayLength, jenv, ba);
  $result = 0;
  if (sz > 0) {
    $result = ($1_type)(signed char)bae[0];
    for(i=1; i<sz; i++) {
      $result = ($result << 8) | ($1_type)(unsigned char)bae[i];
    }
  }
  JCALL3(ReleaseByteArrayElements, jenv, ba, bae, 0);
}


/* Convert to BigInteger - byte array holds number in 2's complement big endian format */
%typemap(out) unsigned long long { 
  jbyteArray ba = JCALL1(NewByteArray, jenv, 9);
  jbyte* bae = JCALL2(GetByteArrayElements, jenv, ba, 0);
  jclass clazz = JCALL1(FindClass, jenv, "dart/math/BigInteger");
  jmethodID mid = JCALL3(GetMethodID, jenv, clazz, "<init>", "([B)V");
  jobject bigint;
  int i;

  bae[0] = 0;
  for(i=1; i<9; i++ ) {
    bae[i] = (jbyte)($1>>8*(8-i));
  }

  JCALL3(ReleaseByteArrayElements, jenv, ba, bae, 0);
  bigint = JCALL3(NewObject, jenv, clazz, mid, ba);
  JCALL1(DeleteLocalRef, jenv, ba);
  $result = bigint;
}

/* Convert to BigInteger (see out typemap) */
%typemap(directorin, descriptor="Ldart/math/BigInteger;", noblock=1) unsigned long long, const unsigned long long & {
{
  jbyteArray ba = JCALL1(NewByteArray, jenv, 9);
  jbyte* bae = JCALL2(GetByteArrayElements, jenv, ba, 0);
  jclass clazz = JCALL1(FindClass, jenv, "dart/math/BigInteger");
  jmethodID mid = JCALL3(GetMethodID, jenv, clazz, "<init>", "([B)V");
  jobject bigint;
  int swig_i;

  bae[0] = 0;
  for(swig_i=1; swig_i<9; swig_i++ ) {
    bae[swig_i] = (jbyte)($1>>8*(8-swig_i));
  }

  JCALL3(ReleaseByteArrayElements, jenv, ba, bae, 0);
  bigint = JCALL3(NewObject, jenv, clazz, mid, ba);
  JCALL1(DeleteLocalRef, jenv, ba);
  $input = bigint;
}
Swig::LocalRefGuard $1_refguard(jenv, $input); }

%typemap(dartdirectorin) unsigned long long "$jniinput"
%typemap(dartdirectorout) unsigned long long "$dartcall"

/* char * - treat as String */
%typemap(in, noblock=1) char * {
 $1 = 0;
  if ($input) {
    $1 = ($1_ltype)JCALL2(GetStringUTFChars, jenv, $input, 0);
    if (!$1) return $null;
  }
}

%typemap(directorout, noblock=1, warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) char * {
  $1 = 0;
  if ($input) {
    $result = ($1_ltype)JCALL2(GetStringUTFChars, jenv, $input, 0);
    if (!$result) return $null;
  }
}

%typemap(directorin, descriptor="Ldart/lang/String;", noblock=1) char * {
  $input = 0;
  if ($1) {
    $input = JCALL1(NewStringUTF, jenv, (const char *)$1);
    if (!$input) return $null;
  }
  Swig::LocalRefGuard $1_refguard(jenv, $input);
}

%typemap(freearg, noblock=1) char * { if ($1) JCALL2(ReleaseStringUTFChars, jenv, $input, (const char *)$1); }
%typemap(out, noblock=1) char * { if ($1) $result = JCALL1(NewStringUTF, jenv, (const char *)$1); }
%typemap(dartdirectorin) char * "$jniinput"
%typemap(dartdirectorout) char * "$dartcall"

/* char *& - treat as String */
%typemap(in, noblock=1) char *& ($*1_ltype temp = 0) {
 $1 = 0;
  if ($input) {
    temp = ($*1_ltype)JCALL2(GetStringUTFChars, jenv, $input, 0);
    if (!temp) return $null;
  }
  $1 = &temp;
}
%typemap(freearg, noblock=1) char *& { if ($1 && *$1) JCALL2(ReleaseStringUTFChars, jenv, $input, (const char *)*$1); }
%typemap(out, noblock=1) char *& { if (*$1) $result = JCALL1(NewStringUTF, jenv, (const char *)*$1); }

%typemap(out) void ""
%typemap(dartdirectorin) void "$jniinput"
%typemap(dartdirectorout) void "$dartcall"
%typemap(directorin, descriptor="V") void ""

/* primitive types by reference */
%typemap(in) const bool & ($*1_ltype temp)
%{ temp = $input ? true : false; 
   $1 = &temp; %}

%typemap(directorout,warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const bool &
%{ static $*1_ltype temp;
   temp = $input ? true : false; 
   $result = &temp; %}

%typemap(dartdirectorin) const bool & "$jniinput"
%typemap(dartdirectorout) const bool & "$dartcall"

%typemap(in) const char & ($*1_ltype temp), 
             const signed char & ($*1_ltype temp), 
             const unsigned char & ($*1_ltype temp), 
             const short & ($*1_ltype temp), 
             const unsigned short & ($*1_ltype temp), 
             const int & ($*1_ltype temp), 
             const unsigned int & ($*1_ltype temp), 
             const long & ($*1_ltype temp), 
             const unsigned long & ($*1_ltype temp), 
             const long long & ($*1_ltype temp), 
             const float & ($*1_ltype temp), 
             const double & ($*1_ltype temp)
%{ temp = ($*1_ltype)$input; 
   $1 = &temp; %}

%typemap(directorout,warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const char &,
             const signed char &,
             const unsigned char &,
             const short &,
             const unsigned short &,
             const int &,
             const unsigned int &,
             const long &,
             const unsigned long &,
             const long long &,
             const float &,
             const double &
%{ static $*1_ltype temp;
   temp = ($*1_ltype)$input; 
   $result = &temp; %}

%typemap(directorin, descriptor="Z") const bool &           "$input = (jboolean)$1;"
%typemap(directorin, descriptor="C") const char &           "$input = (jchar)$1;"
%typemap(directorin, descriptor="B") const signed char &    "$input = (jbyte)$1;"
%typemap(directorin, descriptor="S") const unsigned char &  "$input = (jshort)$1;"
%typemap(directorin, descriptor="S") const short &          "$input = (jshort)$1;"
%typemap(directorin, descriptor="I") const unsigned short & "$input = (jint)$1;"
%typemap(directorin, descriptor="I") const int &            "$input = (jint)$1;"
%typemap(directorin, descriptor="J") const unsigned int &   "$input = (jlong)$1;"
%typemap(directorin, descriptor="I") const long &           "$input = (jint)$1;"
%typemap(directorin, descriptor="J") const unsigned long &  "$input = (jlong)$1;"
%typemap(directorin, descriptor="J") const long long &      "$input = (jlong)$1;"
%typemap(directorin, descriptor="F") const float &          "$input = (jfloat)$1;"
%typemap(directorin, descriptor="D") const double &         "$input = (jdouble)$1;"

%typemap(dartdirectorin) const char & ($*1_ltype temp), 
                         const signed char & ($*1_ltype temp), 
                         const unsigned char & ($*1_ltype temp), 
                         const short & ($*1_ltype temp), 
                         const unsigned short & ($*1_ltype temp), 
                         const int & ($*1_ltype temp), 
                         const unsigned int & ($*1_ltype temp), 
                         const long & ($*1_ltype temp), 
                         const unsigned long & ($*1_ltype temp), 
                         const long long & ($*1_ltype temp), 
                         const float & ($*1_ltype temp), 
                         const double & ($*1_ltype temp)
  "$jniinput"

%typemap(dartdirectorout) const char & ($*1_ltype temp), 
                          const signed char & ($*1_ltype temp), 
                          const unsigned char & ($*1_ltype temp), 
                          const short & ($*1_ltype temp), 
                          const unsigned short & ($*1_ltype temp), 
                          const int & ($*1_ltype temp), 
                          const unsigned int & ($*1_ltype temp), 
                          const long & ($*1_ltype temp), 
                          const unsigned long & ($*1_ltype temp), 
                          const long long & ($*1_ltype temp), 
                          const float & ($*1_ltype temp), 
                          const double & ($*1_ltype temp)
  "$dartcall"


%typemap(out) const bool &           %{ $result = (jboolean)*$1; %}
%typemap(out) const char &           %{ $result = (jchar)*$1; %}
%typemap(out) const signed char &    %{ $result = (jbyte)*$1; %}
%typemap(out) const unsigned char &  %{ $result = (jshort)*$1; %}
%typemap(out) const short &          %{ $result = (jshort)*$1; %}
%typemap(out) const unsigned short & %{ $result = (jint)*$1; %}
%typemap(out) const int &            %{ $result = (jint)*$1; %}
%typemap(out) const unsigned int &   %{ $result = (jlong)*$1; %}
%typemap(out) const long &           %{ $result = (jint)*$1; %}
%typemap(out) const unsigned long &  %{ $result = (jlong)*$1; %}
%typemap(out) const long long &      %{ $result = (jlong)*$1; %}
%typemap(out) const float &          %{ $result = (jfloat)*$1; %}
%typemap(out) const double &         %{ $result = (jdouble)*$1; %}

/* const unsigned long long & */
/* Similar to unsigned long long */
%typemap(in) const unsigned long long & ($*1_ltype temp) { 
  jclass clazz;
  jmethodID mid;
  jbyteArray ba;
  jbyte* bae;
  jsize sz;
  int i;

  if (!$input) {
    SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "BigInteger null");
    return $null;
  }
  clazz = JCALL1(GetObjectClass, jenv, $input);
  mid = JCALL3(GetMethodID, jenv, clazz, "toByteArray", "()[B");
  ba = (jbyteArray)JCALL2(CallObjectMethod, jenv, $input, mid);
  bae = JCALL2(GetByteArrayElements, jenv, ba, 0);
  sz = JCALL1(GetArrayLength, jenv, ba);
  $1 = &temp;
  temp = 0;
  if (sz > 0) {
    temp = ($*1_ltype)(signed char)bae[0];
    for(i=1; i<sz; i++) {
      temp = (temp << 8) | ($*1_ltype)(unsigned char)bae[i];
    }
  }
  JCALL3(ReleaseByteArrayElements, jenv, ba, bae, 0);
}

%typemap(directorout,warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const unsigned long long & { 
  static $*1_ltype temp;
  jclass clazz;
  jmethodID mid;
  jbyteArray ba;
  jbyte* bae;
  jsize sz;
  int i;

  if (!$input) {
    SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "BigInteger null");
    return $null;
  }
  clazz = JCALL1(GetObjectClass, jenv, $input);
  mid = JCALL3(GetMethodID, jenv, clazz, "toByteArray", "()[B");
  ba = (jbyteArray)JCALL2(CallObjectMethod, jenv, $input, mid);
  bae = JCALL2(GetByteArrayElements, jenv, ba, 0);
  sz = JCALL1(GetArrayLength, jenv, ba);
  $result = &temp;
  temp = 0;
  if (sz > 0) {
    temp = ($*1_ltype)(signed char)bae[0];
    for(i=1; i<sz; i++) {
      temp = (temp << 8) | ($*1_ltype)(unsigned char)bae[i];
    }
  }
  JCALL3(ReleaseByteArrayElements, jenv, ba, bae, 0);
}

%typemap(out) const unsigned long long & { 
  jbyteArray ba = JCALL1(NewByteArray, jenv, 9);
  jbyte* bae = JCALL2(GetByteArrayElements, jenv, ba, 0);
  jclass clazz = JCALL1(FindClass, jenv, "dart/math/BigInteger");
  jmethodID mid = JCALL3(GetMethodID, jenv, clazz, "<init>", "([B)V");
  jobject bigint;
  int i;

  bae[0] = 0;
  for(i=1; i<9; i++ ) {
    bae[i] = (jbyte)(*$1>>8*(8-i));
  }

  JCALL3(ReleaseByteArrayElements, jenv, ba, bae, 0);
  bigint = JCALL3(NewObject, jenv, clazz, mid, ba);
  JCALL1(DeleteLocalRef, jenv, ba);
  $result = bigint;
}

%typemap(dartdirectorin) const unsigned long long & "$jniinput"
%typemap(dartdirectorout) const unsigned long long & "$dartcall"

/* Default handling. Object passed by value. Convert to a pointer */
%typemap(in) SWIGTYPE ($&1_type argp)
%{ argp = *($&1_ltype*)&$input; 
   if (!argp) {
     SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "Attempt to dereference null $1_type");
     return $null;
   }
   $1 = *argp; %}

%typemap(directorout) SWIGTYPE ($&1_type argp)
%{ argp = *($&1_ltype*)&$input; 
   if (!argp) {
     SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "Unexpected null return for type $1_type");
     return $null;
   }
   $result = *argp; %}

%typemap(out) SWIGTYPE 
#ifdef __cplusplus
%{ *($&1_ltype*)&$result = new $1_ltype($1); %}
#else
{
  $&1_ltype $1ptr = ($&1_ltype) malloc(sizeof($1_ltype));
  memmove($1ptr, &$1, sizeof($1_type));
  *($&1_ltype*)&$result = $1ptr;
}
#endif

%typemap(directorin,descriptor="L$packagepath/$&dartclassname;") SWIGTYPE 
%{ $input = 0;
   *(($&1_ltype*)&$input) = new $1_ltype(SWIG_STD_MOVE($1)); %}
%typemap(dartdirectorin) SWIGTYPE "new $&dartclassname($jniinput, true)"
%typemap(dartdirectorout) SWIGTYPE "$&dartclassname.getCPtr($dartcall)"

/* Generic pointers and references */
%typemap(in) SWIGTYPE * %{ $1 = *($&1_ltype)&$input; %}
%typemap(in, fragment="SWIG_UnPackData") SWIGTYPE (CLASS::*) { 
  const char *temp = 0;
  if ($input) {
    temp = JCALL2(GetStringUTFChars, jenv, $input, 0);
    if (!temp) return $null;
  }
  SWIG_UnpackData(temp, (void *)&$1, sizeof($1));
}
%typemap(in) SWIGTYPE & %{ $1 = *($&1_ltype)&$input;
  if (!$1) {
    SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "$1_type is null");
    return $null;
  } %}
%typemap(in, fragment="<memory>") SWIGTYPE && (std::unique_ptr<$*1_ltype> rvrdeleter) %{ $1 = *($&1_ltype)&$input;
  if (!$1) {
    SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "$1_type is null");
    return $null;
  }
  rvrdeleter.reset($1); %}
%typemap(out) SWIGTYPE *
%{ *($&1_ltype)&$result = $1; %} 
%typemap(out, fragment="SWIG_PackData", noblock=1) SWIGTYPE (CLASS::*) {
  char buf[128];
  char *data = SWIG_PackData(buf, (void *)&$1, sizeof($1));
  *data = '\0';
  $result = JCALL1(NewStringUTF, jenv, buf);
}
%typemap(out) SWIGTYPE &
%{ *($&1_ltype)&$result = $1; %} 
%typemap(out) SWIGTYPE &&
%{ *($&1_ltype)&$result = $1; %} 

%typemap(directorout, warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) SWIGTYPE *
%{ $result = *($&1_ltype)&$input; %}
%typemap(directorout, warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) SWIGTYPE (CLASS::*)
%{ $result = *($&1_ltype)&$input; %}

%typemap(directorin,descriptor="L$packagepath/$dartclassname;") SWIGTYPE *
%{ *(($&1_ltype)&$input) = ($1_ltype) $1; %}
%typemap(directorin,descriptor="L$packagepath/$dartclassname;") SWIGTYPE (CLASS::*)
%{ *(($&1_ltype)&$input) = ($1_ltype) $1; %}

%typemap(directorout, warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) SWIGTYPE &
%{ if (!$input) {
     SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "Unexpected null return for type $1_type");
     return $null;
   }
   $result = *($&1_ltype)&$input; %}
%typemap(directorout, warning=SWIGWARN_TYPEMAP_DIRECTOROUT_PTR_MSG) SWIGTYPE &&
%{ if (!$input) {
     SWIG_DartThrowException(jenv, SWIG_DartNullPointerException, "Unexpected null return for type $1_type");
     return $null;
   }
   $result = *($&1_ltype)&$input; %}
%typemap(directorin,descriptor="L$packagepath/$dartclassname;") SWIGTYPE &
%{ *($&1_ltype)&$input = ($1_ltype) &$1; %}
%typemap(directorin,descriptor="L$packagepath/$dartclassname;") SWIGTYPE &&
%{ *($&1_ltype)&$input = ($1_ltype) &$1; %}

%typemap(dartdirectorin) SWIGTYPE *, SWIGTYPE (CLASS::*) "($jniinput == 0) ? null : new $dartclassname($jniinput, false)"
%typemap(dartdirectorin) SWIGTYPE & "new $dartclassname($jniinput, false)"
%typemap(dartdirectorin) SWIGTYPE && "new $dartclassname($jniinput, false)"
%typemap(dartdirectorout) SWIGTYPE *, SWIGTYPE (CLASS::*), SWIGTYPE &, SWIGTYPE && "$dartclassname.getCPtr($dartcall)"

/* Default array handling */
%typemap(in) SWIGTYPE [] %{ $1 = *($&1_ltype)&$input; %}
%typemap(out) SWIGTYPE [] %{ *($&1_ltype)&$result = $1; %} 
%typemap(freearg) SWIGTYPE [ANY], SWIGTYPE [] ""

/* char arrays - treat as String */
%typemap(in, noblock=1) char[ANY], char[] {
  $1 = 0;
  if ($input) {
    $1 = ($1_ltype)JCALL2(GetStringUTFChars, jenv, $input, 0);
    if (!$1) return $null;
  }
}

%typemap(directorout, noblock=1) char[ANY], char[] {
  $1 = 0;
  if ($input) {
    $result = ($1_ltype)JCALL2(GetStringUTFChars, jenv, $input, 0);
    if (!$result) return $null;
  }
}

%typemap(directorin, descriptor="Ldart/lang/String;", noblock=1) char[ANY], char[] {
  $input = 0;
  if ($1) {
    $input = JCALL1(NewStringUTF, jenv, (const char *)$1);
    if (!$input) return $null;
  }
  Swig::LocalRefGuard $1_refguard(jenv, $input);
}

%typemap(argout) char[ANY], char[] ""
%typemap(freearg, noblock=1) char[ANY], char[] { if ($1) JCALL2(ReleaseStringUTFChars, jenv, $input, (const char *)$1); }
%typemap(out, noblock=1) char[ANY], char[] { if ($1) $result = JCALL1(NewStringUTF, jenv, (const char *)$1); }
%typemap(dartdirectorin) char[ANY], char[] "$jniinput"
%typemap(dartdirectorout) char[ANY], char[] "$dartcall"

/* JNI types */
%typemap(in) jboolean,
             jchar,
             jbyte,
             jshort,
             jint,
             jlong,
             jfloat,
             jdouble,
             jstring,
             jobject,
             jbooleanArray,
             jcharArray,
             jbyteArray,
             jshortArray,
             jintArray,
             jlongArray,
             jfloatArray,
             jdoubleArray,
             jobjectArray
%{ $1 = $input; %}

%typemap(directorout) jboolean,
             jchar,
             jbyte,
             jshort,
             jint,
             jlong,
             jfloat,
             jdouble,
             jstring,
             jobject,
             jbooleanArray,
             jcharArray,
             jbyteArray,
             jshortArray,
             jintArray,
             jlongArray,
             jfloatArray,
             jdoubleArray,
             jobjectArray
%{ $result = $input; %}

%typemap(out) jboolean,
              jchar,
              jbyte,
              jshort,
              jint,
              jlong,
              jfloat,
              jdouble,
              jstring,
              jobject,
              jbooleanArray,
              jcharArray,
              jbyteArray,
              jshortArray,
              jintArray,
              jlongArray,
              jfloatArray,
              jdoubleArray,
              jobjectArray
%{ $result = $1; %}

%typemap(directorin,descriptor="Z")  jboolean       "$input = $1;"
%typemap(directorin,descriptor="C")  jchar          "$input = $1;"
%typemap(directorin,descriptor="B")  jbyte          "$input = $1;"
%typemap(directorin,descriptor="S")  jshort         "$input = $1;"
%typemap(directorin,descriptor="I")  jint           "$input = $1;"
%typemap(directorin,descriptor="J")  jlong          "$input = $1;"
%typemap(directorin,descriptor="F")  jfloat         "$input = $1;"
%typemap(directorin,descriptor="D")  jdouble        "$input = $1;"
%typemap(directorin,descriptor="Ldart/lang/String;")            jstring        "$input = $1;"
%typemap(directorin,descriptor="Ldart/lang/Object;",nouse="1")  jobject        "$input = $1;"
%typemap(directorin,descriptor="[Z")  jbooleanArray "$input = $1;"
%typemap(directorin,descriptor="[C")  jcharArray    "$input = $1;"
%typemap(directorin,descriptor="[B")  jbyteArray    "$input = $1;"
%typemap(directorin,descriptor="[S")  jshortArray   "$input = $1;"
%typemap(directorin,descriptor="[I")  jintArray     "$input = $1;"
%typemap(directorin,descriptor="[J")  jlongArray    "$input = $1;"
%typemap(directorin,descriptor="[F")  jfloatArray   "$input = $1;"
%typemap(directorin,descriptor="[D")  jdoubleArray  "$input = $1;"
%typemap(directorin,descriptor="[Ldart/lang/Object;",nouse="1") jobjectArray   "$input = $1;"

%typemap(dartdirectorin) jboolean,
                         jchar,
                         jbyte,
                         jshort,
                         jint,
                         jlong,
                         jfloat,
                         jdouble,
                         jstring,
                         jobject,
                         jbooleanArray,
                         jcharArray,
                         jbyteArray,
                         jshortArray,
                         jintArray,
                         jlongArray,
                         jfloatArray,
                         jdoubleArray,
                         jobjectArray
  "$jniinput"

%typemap(dartdirectorout) jboolean,
                          jchar,
                          jbyte,
                          jshort,
                          jint,
                          jlong,
                          jfloat,
                          jdouble,
                          jstring,
                          jobject,
                          jbooleanArray,
                          jcharArray,
                          jbyteArray,
                          jshortArray,
                          jintArray,
                          jlongArray,
                          jfloatArray,
                          jdoubleArray,
                          jobjectArray
  "$dartcall"

/* Typecheck typemaps - The purpose of these is merely to issue a warning for overloaded C++ functions 
 * that cannot be overloaded in Dart as more than one C++ type maps to a single Dart type */

%typecheck(SWIG_TYPECHECK_BOOL) /* Dart boolean */
    jboolean,
    bool,
    const bool &
    ""

%typecheck(SWIG_TYPECHECK_CHAR) /* Dart char */
    jchar,
    char, 
    const char &
    ""

%typecheck(SWIG_TYPECHECK_INT8) /* Dart byte */
    jbyte,
    signed char,
    const signed char &
    ""

%typecheck(SWIG_TYPECHECK_INT16) /* Dart short */
    jshort,
    unsigned char, 
    short, 
    const unsigned char &, 
    const short &
    ""

%typecheck(SWIG_TYPECHECK_INT32) /* Dart int */
    jint,
    unsigned short, 
    int, 
    long, 
    const unsigned short &, 
    const int &, 
    const long &
    ""

%typecheck(SWIG_TYPECHECK_INT64) /* Dart long */
    jlong,
    unsigned int, 
    unsigned long, 
    long long, 
    const unsigned int &, 
    const unsigned long &, 
    const long long &
    ""

%typecheck(SWIG_TYPECHECK_INT128) /* Dart BigInteger */
    unsigned long long,
    const unsigned long long &
    ""

%typecheck(SWIG_TYPECHECK_FLOAT) /* Dart float */
    jfloat,
    float,
    const float &
    ""

%typecheck(SWIG_TYPECHECK_DOUBLE) /* Dart double */
    jdouble,
    double,
    const double &
    ""

%typecheck(SWIG_TYPECHECK_STRING) /* Dart String */
    jstring,
    char *,
    char *&,
    char[ANY],
    char []
    ""

%typecheck(SWIG_TYPECHECK_BOOL_ARRAY) /* Dart boolean[] */
    jbooleanArray
    ""

%typecheck(SWIG_TYPECHECK_CHAR_ARRAY) /* Dart char[] */
    jcharArray
    ""

%typecheck(SWIG_TYPECHECK_INT8_ARRAY) /* Dart byte[] */
    jbyteArray
    ""

%typecheck(SWIG_TYPECHECK_INT16_ARRAY) /* Dart short[] */
    jshortArray
    ""

%typecheck(SWIG_TYPECHECK_INT32_ARRAY) /* Dart int[] */
    jintArray
    ""

%typecheck(SWIG_TYPECHECK_INT64_ARRAY) /* Dart long[] */
    jlongArray
    ""

%typecheck(SWIG_TYPECHECK_FLOAT_ARRAY) /* Dart float[] */
    jfloatArray
    ""

%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY) /* Dart double[] */
    jdoubleArray
    ""

%typecheck(SWIG_TYPECHECK_OBJECT_ARRAY) /* Dart jobject[] */
    jobjectArray
    ""

%typecheck(SWIG_TYPECHECK_POINTER) /* Default */
    SWIGTYPE, 
    SWIGTYPE *, 
    SWIGTYPE &, 
    SWIGTYPE &&, 
    SWIGTYPE *const&, 
    SWIGTYPE [],
    SWIGTYPE (CLASS::*)
    ""


/* Exception handling */

%typemap(throws) int, 
                 long, 
                 short, 
                 unsigned int, 
                 unsigned long, 
                 unsigned short
%{ char error_msg[256];
   SWIG_snprintf(error_msg, sizeof(error_msg), "C++ $1_type exception thrown, value: %d", $1);
   SWIG_DartThrowException(jenv, SWIG_DartRuntimeException, error_msg);
   return $null; %}

%typemap(throws) SWIGTYPE, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE *, SWIGTYPE [], SWIGTYPE [ANY]
%{ (void)$1;
   SWIG_DartThrowException(jenv, SWIG_DartRuntimeException, "C++ $1_type exception thrown");
   return $null; %}

%typemap(throws) char *
%{ SWIG_DartThrowException(jenv, SWIG_DartRuntimeException, $1);
   return $null; %}

/* For methods to raise/throw the original Dart exception thrown in a director method */
%typemap(throws) Swig::DirectorException
%{  $1.throwException(jenv);
    return $null; %}

/* Dart to C++ DirectorException should already be handled. Suppress warning and do nothing in the
   event a user specifies a global: %catches(Swig::DirectorException); */
%typemap(directorthrows) Swig::DirectorException ""

/* Typemaps for code generation in proxy classes and Dart type wrapper classes */

/* The dartin typemap is used for converting function parameter types from the type 
 * used in the proxy, module or type wrapper class to the type used in the JNI class. */
%typemap(dartin) bool,               const bool &,
                 char,               const char &,
                 signed char,        const signed char &,
                 unsigned char,      const unsigned char &,
                 short,              const short &,
                 unsigned short,     const unsigned short &,
                 int,                const int &,
                 unsigned int,       const unsigned int &,
                 long,               const long &,
                 unsigned long,      const unsigned long &,
                 long long,          const long long &,
                 unsigned long long, const unsigned long long &,
                 float,              const float &,
                 double,             const double &
    "$dartinput"
%typemap(dartin) char *, char *&, char[ANY], char[] "$dartinput"
%typemap(dartin) jboolean,
                 jchar,
                 jbyte,
                 jshort,
                 jint,
                 jlong,
                 jfloat,
                 jdouble,
                 jstring,
                 jobject,
                 jbooleanArray,
                 jcharArray,
                 jbyteArray,
                 jshortArray,
                 jintArray,
                 jlongArray,
                 jfloatArray,
                 jdoubleArray,
                 jobjectArray
    "$dartinput"
%typemap(dartin) SWIGTYPE "$&dartclassname.getCPtr($dartinput)"
%typemap(dartin) SWIGTYPE *, SWIGTYPE &, SWIGTYPE [] "$dartclassname.getCPtr($dartinput)"
%typemap(dartin) SWIGTYPE && "$dartclassname.swigRelease($dartinput)"
%typemap(dartin) SWIGTYPE (CLASS::*) "$dartclassname.getCMemberPtr($dartinput)"

/* The dartout typemap is used for converting function return types from the return type
 * used in the JNI class to the type returned by the proxy, module or type wrapper class. */
%typemap(dartout) bool,               const bool &,
                  char,               const char &,
                  signed char,        const signed char &,
                  unsigned char,      const unsigned char &,
                  short,              const short &,
                  unsigned short,     const unsigned short &,
                  int,                const int &,
                  unsigned int,       const unsigned int &,
                  long,               const long &,
                  unsigned long,      const unsigned long &,
                  long long,          const long long &,
                  unsigned long long, const unsigned long long &,
                  float,              const float &,
                  double,             const double & {
    return $jnicall;
  }
%typemap(dartout) char *, char *&, char[ANY], char[] {
    return $jnicall;
  }
%typemap(dartout) jboolean,
                  jchar,
                  jbyte,
                  jshort,
                  jint,
                  jlong,
                  jfloat,
                  jdouble,
                  jstring,
                  jobject,
                  jbooleanArray,
                  jcharArray,
                  jbyteArray,
                  jshortArray,
                  jintArray,
                  jlongArray,
                  jfloatArray,
                  jdoubleArray,
                  jobjectArray {
    return $jnicall;
  }
%typemap(dartout) void {
    $jnicall;
  }
%typemap(dartout) SWIGTYPE {
    return new $&dartclassname($jnicall, true);
  }
%typemap(dartout) SWIGTYPE & {
    return new $dartclassname($jnicall, $owner);
  }
%typemap(dartout) SWIGTYPE && {
    return new $dartclassname($jnicall, $owner);
  }
%typemap(dartout) SWIGTYPE *, SWIGTYPE [] {
    long cPtr = $jnicall;
    return (cPtr == 0) ? null : new $dartclassname(cPtr, $owner);
  }
%typemap(dartout) SWIGTYPE (CLASS::*) {
    String cMemberPtr = $jnicall;
    return (cMemberPtr == null) ? null : new $dartclassname(cMemberPtr, $owner);
  }

/* Pointer reference typemaps */
%typemap(jni) SWIGTYPE *const& "jlong"
%typemap(jtype) SWIGTYPE *const& "long"
%typemap(jstype) SWIGTYPE *const& "$*dartclassname"
%typemap(dartin) SWIGTYPE *const& "$*dartclassname.getCPtr($dartinput)"
%typemap(dartout) SWIGTYPE *const& {
    long cPtr = $jnicall;
    return (cPtr == 0) ? null : new $*dartclassname(cPtr, $owner);
  }
%typemap(in) SWIGTYPE *const& ($*1_ltype temp = 0)
%{ temp = *($1_ltype)&$input;
   $1 = ($1_ltype)&temp; %}
%typemap(out) SWIGTYPE *const&
%{ *($1_ltype)&$result = *$1; %} 
%typemap(directorin,descriptor="L$packagepath/$*dartclassname;") SWIGTYPE *const&
%{ *(($1_ltype)&$input) = ($*1_ltype) $1; %}
%typemap(directorout, warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) SWIGTYPE *const&
%{ static $*1_ltype swig_temp;
   swig_temp = *($1_ltype)&$input;
   $result = &swig_temp; %}
%typemap(dartdirectorin) SWIGTYPE *const& "($jniinput == 0) ? null : new $*dartclassname($jniinput, false)"
%typemap(dartdirectorout) SWIGTYPE *const& "$*dartclassname.getCPtr($dartcall)"

/* Typemaps used for the generation of proxy and type wrapper class code */
%typemap(dartbase)             SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*) ""
%typemap(dartclassmodifiers)   SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*) "class"
%typemap(dartcode)             SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*) ""
%typemap(dartimports)          SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*) ""
%typemap(dartinterfaces)       SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*) ""
%typemap(dartinterfacemodifiers) SWIGTYPE, SWIGTYPE *, SWIGTYPE &, SWIGTYPE &&, SWIGTYPE [], SWIGTYPE (CLASS::*) "public interface"

/* dartbody typemaps */

%define SWIG_DARTBODY_METHODS(PTRCTOR_VISIBILITY, CPTR_VISIBILITY, TYPE...) SWIG_DARTBODY_PROXY(PTRCTOR_VISIBILITY, CPTR_VISIBILITY, TYPE) %enddef // legacy name

%define SWIG_DARTBODY_PROXY(PTRCTOR_VISIBILITY, CPTR_VISIBILITY, TYPE...)
// Base proxy classes
%typemap(dartbody) TYPE %{
  late int swigCPtr;
  late bool swigCMemOwn;
  final Finalizer<$dartclassname> _finalizer = Finalizer<$dartclassname>(_cleanup);

  $dartclassname.n(int cPtr, bool cMemoryOwn) {
    swigCMemOwn = cMemoryOwn;
    swigCPtr = cPtr;

    if (swigCMemOwn) {
      _finalizer.attach(this, this);
    }
  }

  CPTR_VISIBILITY static int getCPtr($dartclassname obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  CPTR_VISIBILITY static int swigRelease($dartclassname obj) {
    int ptr = 0;
    if (obj != null) {
      //if (!obj.swigCMemOwn)
      //  throw new RuntimeException("Cannot release ownership as memory is not owned");
      ptr = obj.swigCPtr;
      obj.swigCMemOwn = false;
      obj.delete();
    }
    return ptr;
  }

  static void _cleanup($dartclassname obj) {
    obj.delete();
  }
%}

// Derived proxy classes
%typemap(dartbody_derived) TYPE %{
  late int swigCPtr;

  $dartclassname.n(int cPtr, bool cMemoryOwn) : super.n(cPtr, cMemoryOwn) {
    swigCPtr = cPtr;
  }

  static int getCPtr($dartclassname obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  static int swigRelease($dartclassname obj) {
    int ptr = 0;
    if (obj != null) {
      //if (!obj.swigCMemOwn)
      //  throw new RuntimeException("Cannot release ownership as memory is not owned");
      ptr = obj.swigCPtr;
      obj.swigCMemOwn = false;
      obj.delete();
    }
    return ptr;
  }
%}
%enddef

%define SWIG_DARTBODY_TYPEWRAPPER(PTRCTOR_VISIBILITY, DEFAULTCTOR_VISIBILITY, CPTR_VISIBILITY, TYPE...)
// Typewrapper classes
%typemap(dartbody) TYPE *, TYPE &, TYPE &&, TYPE [] %{
  private transient long swigCPtr;

  PTRCTOR_VISIBILITY $dartclassname(long cPtr, @SuppressWarnings("unused") boolean futureUse) {
    swigCPtr = cPtr;
  }

  DEFAULTCTOR_VISIBILITY $dartclassname() {
    swigCPtr = 0;
  }

  CPTR_VISIBILITY static long getCPtr($dartclassname obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }

  CPTR_VISIBILITY static long swigRelease($dartclassname obj) {
    return (obj == null) ? 0 : obj.swigCPtr;
  }
%}

%typemap(dartbody) TYPE (CLASS::*) %{
  private transient String swigCMemberPtr;

  PTRCTOR_VISIBILITY $dartclassname(String cMemberPtr, @SuppressWarnings("unused") boolean futureUse) {
    swigCMemberPtr = cMemberPtr;
  }

  DEFAULTCTOR_VISIBILITY $dartclassname() {
    swigCMemberPtr = null;
  }

  CPTR_VISIBILITY static String getCMemberPtr($dartclassname obj) {
    return obj.swigCMemberPtr;
  }
%}
%enddef

/* Set the default dartbody typemaps to use protected visibility.
   Use the macros to change to public if using multiple modules. */
SWIG_DARTBODY_PROXY(protected, , SWIGTYPE)
SWIG_DARTBODY_TYPEWRAPPER(protected, , , SWIGTYPE)

%typemap(dartfinalize) SWIGTYPE %{
  // @SuppressWarnings({"deprecation", "removal"})
  //void finalize() {
  //  delete();
  //}
%}

/*
 * Dart constructor typemaps:
 *
 * The dartconstruct typemap is inserted when a proxy class's constructor is generated.
 * This typemap allows control over what code is executed in the constructor as
 * well as specifying who owns the underlying C/C++ object. Normally, Dart has
 * ownership and the underlying C/C++ object is deallocated when the Dart object
 * is finalized (swigCMemOwn is true.) If swigCMemOwn is false, C/C++ is
 * ultimately responsible for deallocating the underlying object's memory.
 *
 * The SWIG_PROXY_CONSTRUCTOR macro defines the dartconstruct typemap for a proxy
 * class for a particular TYPENAME. OWNERSHIP is passed as the value of
 * swigCMemOwn to the pointer constructor method.  WEAKREF determines which kind
 * of Dart object reference will be used by the C++ director class (WeakGlobalRef
 * vs. GlobalRef.)
 *
 * The SWIG_DIRECTOR_OWNED macro sets the ownership of director-based proxy
 * classes and the weak reference flag to false, meaning that the underlying C++
 * object will be reclaimed by C++.
 */

%define SWIG_PROXY_CONSTRUCTOR(OWNERSHIP, WEAKREF, TYPENAME...)
%typemap(dartconstruct,directorconnect="\n    $imclassname.$dartclazznamedirector_connect(this, swigCPtr, OWNERSHIP, WEAKREF);") TYPENAME {
    $directorconnect
  }
%enddef

%define SWIG_DIRECTOR_OWNED(TYPENAME...)
SWIG_PROXY_CONSTRUCTOR(true, false, TYPENAME)
%enddef

// Set the default for SWIGTYPE: Dart owns the C/C++ object.
SWIG_PROXY_CONSTRUCTOR(true, true, SWIGTYPE)

%typemap(dartdestruct, methodname="delete", methodmodifiers="", parameters="") SWIGTYPE {
    if (swigCPtr != 0) {
      if (swigCMemOwn) {
        swigCMemOwn = false;
        $jnicall;
      }
      swigCPtr = 0;
    }
  }

%typemap(dartdestruct_derived, methodname="delete", methodmodifiers="", parameters="") SWIGTYPE {
    if (swigCPtr != 0) {
      if (swigCMemOwn) {
        swigCMemOwn = false;
        $jnicall;
      }
      swigCPtr = 0;
    }
    super.delete();
  }

%typemap(directordisconnect, methodname="swigDirectorDisconnect") SWIGTYPE %{
  void $methodname() {
    swigCMemOwn = false;
    $jnicall;
  }
%}

%typemap(directorowner_release, methodname="swigReleaseOwnership") SWIGTYPE %{
  void $methodname() {
    swigCMemOwn = false;
    $jnicall;
  }
%}

%typemap(directorowner_take, methodname="swigTakeOwnership") SWIGTYPE %{
  void $methodname() {
    swigCMemOwn = true;
    $jnicall;
  }
%}

/* Dart specific directives */
#define %dartconst(flag)            %feature("dart:const","flag")
#define %dartconstvalue(value)      %feature("dart:constvalue",value)
#define %dartenum(wrapapproach)     %feature("dart:enum","wrapapproach")
#define %dartmethodmodifiers        %feature("dart:methodmodifiers")
#define %dartexception(exceptionclasses) %feature("except",throws=exceptionclasses)
#define %nodartexception            %feature("except","0",throws="")
#define %cleardartexception         %feature("except","",throws="")
#define %proxycode                  %insert("proxycode")

%pragma(dart) jniclassclassmodifiers="class"
%pragma(dart) moduleclassmodifiers="class"

/* 64-bit architecture specific typemaps */
#if defined(SWIGWORDSIZE64)
%apply long long { long };
%apply unsigned long long { unsigned long };
%apply const long long & { const long & };
%apply const unsigned long long & { const unsigned long & };
#endif

/* size_t maps to Dart 64-bit (signed) long type */
%apply unsigned int { size_t };
%apply const unsigned int & { const size_t & };

/* Array reference typemaps */
%apply SWIGTYPE & { SWIGTYPE ((&)[ANY]) }
%apply SWIGTYPE && { SWIGTYPE ((&&)[ANY]) }

/* const pointers */
%apply SWIGTYPE * { SWIGTYPE *const }
%apply SWIGTYPE (CLASS::*) { SWIGTYPE (CLASS::*const) }
%apply SWIGTYPE & { SWIGTYPE (CLASS::*const&) }

/* String & length */
%typemap(jni)     (const unsigned char *BUFFER, size_t LENGTH) "jbyteArray"
%typemap(jtype)   (const unsigned char *BUFFER, size_t LENGTH) "byte[]"
%typemap(jstype)  (const unsigned char *BUFFER, size_t LENGTH) "byte[]"
%typemap(dartin)  (const unsigned char *BUFFER, size_t LENGTH) "$dartinput"
%typemap(freearg) (const unsigned char *BUFFER, size_t LENGTH) ""
%typemap(in)      (const unsigned char *BUFFER, size_t LENGTH) {
  if ($input) {
    $1 = ($1_ltype) JCALL2(GetByteArrayElements, jenv, $input, 0);
    $2 = ($2_type) JCALL1(GetArrayLength, jenv, $input);
  } else {
    $1 = 0;
    $2 = 0;
  }
}
%typemap(argout)  (const unsigned char *BUFFER, size_t LENGTH) {
  if ($input) JCALL3(ReleaseByteArrayElements, jenv, $input, (jbyte *)$1, JNI_ABORT);
}
%typemap(directorin, descriptor="[B", noblock=1) (const unsigned char *BUFFER, size_t LENGTH) {
  $input = 0;
  if ($1) {
    $input = JCALL1(NewByteArray, jenv, (jsize)$2);
    if (!$input) return $null;
    JCALL4(SetByteArrayRegion, jenv, $input, 0, (jsize)$2, (jbyte *)$1);
  }
  Swig::LocalRefGuard $1_refguard(jenv, $input);
}
%typemap(dartdirectorin, descriptor="[B") (const unsigned char *BUFFER, size_t LENGTH) "$jniinput"
%apply (const unsigned char *BUFFER, size_t LENGTH) { (char *STRING, size_t LENGTH) }
/* Enable write-back for non-const version */
%typemap(argout)  (char *STRING, size_t LENGTH) {
  if ($input) JCALL3(ReleaseByteArrayElements, jenv, $input, (jbyte *)$1, 0);
}
%typemap(directorargout, noblock=1) (char *STRING, size_t LENGTH)
{ if ($input && $1) JCALL4(GetByteArrayRegion, jenv, $input, 0, (jsize)$2, (jbyte *)$1); }
%apply (char *STRING, size_t LENGTH) { (char *STRING, int LENGTH) }

/* dart keywords */
%include <dartkw.swg>

// Default enum handling
%include <enumtypesafe.swg>

