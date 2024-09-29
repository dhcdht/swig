/* -----------------------------------------------------------------------------
 * enumtypesafe.swg
 *
 * Include this file in order for C/C++ enums to be wrapped by the so called
 * typesafe enum pattern. Each enum has an equivalent Java class named after the
 * enum and each enum item is a static instance of this class.
 * ----------------------------------------------------------------------------- */

// const enum SWIGTYPE & typemaps
%typemap(jni) const enum SWIGTYPE & "jint"
%typemap(jtype) const enum SWIGTYPE & "int"
%typemap(jstype) const enum SWIGTYPE & "$*dartclassname"

%typemap(in) const enum SWIGTYPE & ($*1_ltype temp)
%{ temp = ($*1_ltype)$input; 
   $1 = &temp; %}
%typemap(out) const enum SWIGTYPE &  %{ $result = (jint)*$1; %}

%typemap(directorout,warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const enum SWIGTYPE &
%{ static $*1_ltype temp = ($*1_ltype)$input; 
   $result = &temp; %}
%typemap(directorin, descriptor="L$packagepath/$*dartclassname;") const enum SWIGTYPE & "$input = (jint)$1;"
%typemap(dartdirectorin) const enum SWIGTYPE & "$*dartclassname.swigToEnum($jniinput)"
%typemap(dartdirectorout) const enum SWIGTYPE & "($dartcall).swigValue()"

%typecheck(SWIG_TYPECHECK_POINTER) const enum SWIGTYPE & ""

%typemap(throws) const enum SWIGTYPE &
%{ (void)$1;
   SWIG_DartThrowException(jenv, SWIG_DartRuntimeException, "C++ $1_type exception thrown"); %}

%typemap(dartin) const enum SWIGTYPE & "$dartinput.swigValue()"
%typemap(dartout) const enum SWIGTYPE & {
    return $*dartclassname.swigToEnum($jnicall);
  }

// enum SWIGTYPE typemaps
%typemap(jni) enum SWIGTYPE "jint"
%typemap(jtype) enum SWIGTYPE "int"
%typemap(jstype) enum SWIGTYPE "$dartclassname"

%typemap(in) enum SWIGTYPE  %{ $1 = ($1_ltype)$input; %}
%typemap(out) enum SWIGTYPE  %{ $result = (jint)$1; %}

%typemap(directorout) enum SWIGTYPE  %{ $result = ($1_ltype)$input; %}
%typemap(directorin, descriptor="L$packagepath/$dartclassname;") enum SWIGTYPE "$input = (jint) $1;"
%typemap(dartdirectorin) enum SWIGTYPE "$dartclassname.swigToEnum($jniinput)"
%typemap(dartdirectorout) enum SWIGTYPE "($dartcall).swigValue()"

%typecheck(SWIG_TYPECHECK_POINTER) enum SWIGTYPE ""

%typemap(throws) enum SWIGTYPE
%{ (void)$1;
   SWIG_DartThrowException(jenv, SWIG_DartRuntimeException, "C++ $1_type exception thrown"); %}

%typemap(dartin) enum SWIGTYPE "$dartinput.swigValue()"
%typemap(dartout) enum SWIGTYPE {
    return $dartclassname.swigToEnum($jnicall);
  }

// '$static' will be replaced with either 'static' or nothing depending on whether the enum is an inner Java class or not
%typemap(dartclassmodifiers) enum SWIGTYPE "public final $static class"
%typemap(dartbase)           enum SWIGTYPE ""
%typemap(dartcode)           enum SWIGTYPE ""
%typemap(dartimports)        enum SWIGTYPE ""
%typemap(dartinterfaces)     enum SWIGTYPE ""

/*
 * The swigToEnum method is used to find the Java enum from a C++ enum integer value. The default one here takes 
 * advantage of the fact that most enums do not have initial values specified, so the lookup is fast. If initial
 * values are specified then a lengthy linear search through all possible enums might occur. Specific typemaps could be
 * written to possibly optimise this lookup by taking advantage of characteristics peculiar to the targeted enum.
 * The special variable, $enumvalues, is replaced with a comma separated list of all the enum values.
 */
%typemap(dartbody) enum SWIGTYPE %{
  public final int swigValue() {
    return swigValue;
  }

  public String toString() {
    return swigName;
  }

  public static $dartclassname swigToEnum(int swigValue) {
    if (swigValue < swigValues.length && swigValue >= 0 && swigValues[swigValue].swigValue == swigValue)
      return swigValues[swigValue];
    for (int i = 0; i < swigValues.length; i++)
      if (swigValues[i].swigValue == swigValue)
        return swigValues[i];
    throw new IllegalArgumentException("No enum " + $dartclassname.class + " with value " + swigValue);
  }

  private $dartclassname(String swigName) {
    this.swigName = swigName;
    this.swigValue = swigNext++;
  }

  private $dartclassname(String swigName, int swigValue) {
    this.swigName = swigName;
    this.swigValue = swigValue;
    swigNext = swigValue+1;
  }

  private $dartclassname(String swigName, $dartclassname swigEnum) {
    this.swigName = swigName;
    this.swigValue = swigEnum.swigValue;
    swigNext = this.swigValue+1;
  }

  private static $dartclassname[] swigValues = { $enumvalues };
  private static int swigNext = 0;
  private final int swigValue;
  private final String swigName;
%}

%dartenum(typesafe);

