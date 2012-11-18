﻿namespace RemObjects.Oxygene.Sugar;

interface

type

  {$IF COOPER}
  Math = public class mapped to java.lang.Math
  public
    //const PI: Double = 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679;
    //const E: Double =  2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274;
    class method Abs(d: Double): Double; mapped to abs(d);
    class method Acos(d: Double): Double; mapped to acos(d);
    class method Asin(d: Double): Double; mapped to asin(d);
    class method Atan(d: Double): Double; mapped to atan(d);
    class method Atan2(x,y: Double): Double; mapped to atan2(x,y);
    class method Ceiling(a: Double): Double; mapped to ceil(a);
    class method Cos(d: Double): Double; mapped to cos(d);
    class method Cosh(d: Double): Double; mapped to cosh(d);
    class method Exp(d: Double): Double; mapped to exp(d);
    class method Floor(d: Double): Double; mapped to floor(d);   
    class method IEEERemainder(x, y: Double): Double; mapped to IEEEremainder(x, y); 
    class method Log(d: Double): Double; mapped to log(d);
    class method Log10(d: Double): Double; mapped to log10(d);
    class method Max(a,b: Double): Double; mapped to max(a,b);   
    class method Min(a,b: Double): Double; mapped to min(a,b);
    class method Pow(x, y: Double): Double; mapped to pow(x,y);
    class method Round(a: Double): Double; mapped to round(a);
    class method RoundToInt(a: Double): Integer;
    class method Sign(d: Double): Integer;
    class method Sin(d: Double): Double; mapped to sin(d);
    class method Sinh(d: Double): Double; mapped to sinh(d);
    class method Sqrt(d: Double): Double; mapped to sqrt(d);
    class method Tan(d: Double): Double; mapped to tan(d);
    class method Tanh(d: Double): Double; mapped to tanh(d);
    class method Truncate(d: Double): Double;
  {$ENDIF}
  {$IF ECHOES}
  Math = public class mapped to System.Math
  public
    //const PI: Double = 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679;
    //const E: Double =  2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274;
    class method Abs(d: Double): Double; mapped to Abs(d);
    class method Acos(d: Double): Double; mapped to Acos(d);
    class method Asin(d: Double): Double; mapped to Asin(d);
    class method Atan(d: Double): Double; mapped to Atan(d);
    class method Atan2(x,y: Double): Double; mapped to Atan2(x,y);
    class method Ceiling(d: Double): Double; mapped to Ceiling(d);
    class method Cos(d: Double): Double; mapped to Cos(d);
    class method Cosh(d: Double): Double; mapped to Cosh(d);
    class method Exp(d: Double): Double; mapped to Exp(d);
    class method Floor(d: Double): Double; mapped to Floor(d);
    class method IEEERemainder(x, y: Double): Double; mapped to IEEERemainder(x, y); 
    class method Log(d: Double): Double; mapped to Log(d);
    class method Log10(d: Double): Double; mapped to Log10(d);
    class method Max(a,b: Double): Double; mapped to Max(a,b);   
    class method Min(a,b: Double): Double; mapped to Min(a,b);
    class method Pow(x, y: Double): Double; mapped to Pow(x,y);
    class method Round(a: Double): Double; mapped to Round(a);
    class method RoundToInt(a: Double): Integer;
    class method Sign(d: Double): Integer; mapped to Sign(d);
    class method Sin(d: Double): Double; mapped to Sin(d);
    class method Sinh(d: Double): Double; mapped to Sinh(d);
    class method Sqrt(d: Double): Double; mapped to Sqrt(d);
    class method Tan(d: Double): Double; mapped to Tan(d);
    class method Tanh(d: Double): Double; mapped to Tanh(d);
    class method Truncate(d: Double): Double; mapped to Truncate(d);
  {$ENDIF}
  {$IF NOUGAT}
  Math = public class
  public    
    const PI: Double = 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679;
    const E: Double =  2.7182818284590452353602874713526624977572470936999595749669676277240766303535475945713821785251664274;
    class method Abs(value: Double): Double;
    class method Acos(d: Double): Double;
    class method Asin(d: Double): Double;
    class method Atan(d: Double): Double;
    class method Atan2(x,y: Double): Double;
    class method Ceiling(d: Double): Double;
    class method Cos(d: Double): Double;
    class method Cosh(d: Double): Double;
    class method Exp(d: Double): Double;
    class method Floor(d: Double): Double;
    class method IEEERemainder(x, y: Double): Double; 
    class method Log(a: Double): Double;
    class method Log10(a: Double): Double;
    class method Max(a,b: Double): Double;    
    class method Min(a,b: Double): Double;
    class method Pow(x, y: Double): Double;
    class method Round(a: Double): Double;
    class method RoundToInt(a: Double): Integer;
    class method Sign(d: Double): Integer;
    class method Sin(x: Double): Double;
    class method Sinh(x: Double): Double;
    class method Sqrt(d: Double): Double;
    class method Tan(d: Double): Double;
    class method Tanh(d: Double): Double;
    class method Truncate(d: Double): Double;
  {$ENDIF}
  end;

implementation

{$HIDE W0}

{$IF COOPER}
class method Math.Truncate(d: Double): Double;
begin
  exit iif(d < 0, mapped.ceil(d), mapped.floor(d));
end;
{$ENDIF}

{$IF COOPER or ECHOES}
class method Math.RoundToInt(a: Double): Integer;
begin
  exit Integer(mapped.Round(a));
end;
{$ENDIF}

{$IF COOPER or NOUGAT}
class method Math.Sign(d: Double): Integer;
begin
  if d > 0 then exit 1;
  if d < 0 then exit -1;
  exit 0;
end;
{$ENDIF}

{$IF NOUGAT}
class method Math.Pow(x, y: Double): Double;
begin
  exit rtl.Math.pow(x,y);  
end;

class method Math.Acos(d: Double): Double;
begin
  exit rtl.Math.acos(d);   
end;

class method Math.Cos(d: Double): Double;
begin
  exit rtl.Math.cos(d);   
end;

class method Math.Ceiling(d: Double): Double;
begin
  exit rtl.Math.ceil(d);   
end;

class method Math.Cosh(d: Double): Double;
begin
  exit rtl.Math.cosh(d);   
end;

class method Math.Asin(d: Double): Double;
begin
  exit rtl.Math.asin(d);   
end;

class method Math.Atan(d: Double): Double;
begin
  exit rtl.Math.atan(d);   
end;

class method Math.Atan2(x,y: Double): Double;
begin
  exit rtl.Math.atan2(x,y);   
end;

class method Math.Abs(value: Double): Double;
begin
  exit rtl.Math.fabs(value);   
end;

class method Math.Exp(d: Double): Double;
begin
  exit rtl.Math.exp(d);   
end;

class method Math.Floor(d: Double): Double;
begin
  exit rtl.Math.floor(d);   
end;

class method Math.IEEERemainder(x,y: Double): Double;
begin
  exit rtl.Math.remainder(x,y);   
end;

class method Math.Log(a: Double): Double;
begin
  exit rtl.Math.log(a);   
end;

class method Math.Log10(a: Double): Double;
begin
  exit rtl.Math.log10(a);   
end;

class method Math.Max(a,b: Double): Double;
begin
  exit iif(a > b, a, b);   
end;

class method Math.Min(a,b: Double): Double;
begin
  exit iif(a < b, a, b);   
end;

class method Math.Round(a: Double): Double;
begin
  exit rtl.Math.round(a);   
end;

class method Math.RoundToInt(a: Double): Integer;
begin
  exit Integer(rtl.Math.round(a));   
end;

class method Math.Sin(x: Double): Double;
begin
  exit rtl.Math.sin(x);  
end;

class method Math.Sinh(x: Double): Double;
begin
  exit rtl.Math.sinh(x);  
end;

class method Math.Sqrt(d: Double): Double;
begin
  exit rtl.Math.sqrt(d);  
end;

class method Math.Tan(d: Double): Double;
begin
  exit rtl.Math.tan(d);  
end;

class method Math.Tanh(d: Double): Double;
begin
  exit rtl.Math.tanh(d);  
end;

class method Math.Truncate(d: Double): Double;
begin
  exit rtl.Math.trunc(d);  
end;
{$ENDIF}

end.