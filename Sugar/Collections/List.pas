﻿namespace RemObjects.Sugar.Collections;

{$HIDE W0} //supress case-mismatch errors

interface

uses
  RemObjects.Sugar;

type  
  List<T> = public class mapped to {$IF COOPER}java.util.ArrayList<T>{$ELSEIF ECHOES}System.Collections.Generic.List<T>{$ELSEIF NOUGAT}Foundation.NSMutableArray where T is class;{$ENDIF}
  private
    method SetItem(&Index: Integer; Value: T);
  public
    constructor; mapped to constructor();
    constructor(Items: List<T>);
    constructor(anArray: array of T);

    method &Add(anItem: T);
    method AddRange(Items: List<T>);
    method Clear;
    method Contains(anItem: T): Boolean;

    method Exists(Match: Predicate<T>): Boolean;
    method FindIndex(Match: Predicate<T>): Integer;
    method FindIndex(StartIndex: Integer; Match: Predicate<T>): Integer;
    method FindIndex(StartIndex: Integer; aCount: Integer; Match: Predicate<T>): Integer;

    method Find(Match: Predicate<T>): T;
    method FindAll(Match: Predicate<T>): List<T>;
    method TrueForAll(Match: Predicate<T>): Boolean;
    method ForEach(Action: Action<T>): Boolean;

    method IndexOf(anItem: T): Integer; 
    method Insert(&Index: Integer; anItem: T);
    method LastIndexOf(anItem: T): Integer;

    method &Remove(anItem: T): Boolean;
    method RemoveAt(&Index: Integer);
    method RemoveRange(&Index: Integer; aCount: Integer);

    method ToArray: array of T;

    property Count: Integer read {$IF COOPER}mapped.Size{$ELSEIF ECHOES}mapped.Count{$ELSEIF NOUGAT}mapped.Count{$ENDIF};
    property Item[i: Integer]: T read mapped[i] write SetItem; default;
  end;

  Predicate<T> = public block (Obj: T): Boolean;
  Action<T> = public block (Obj: T);


implementation

constructor List<T>(Items: List<T>);
begin
  if Items = nil then
    raise new SugarArgumentNullException("Items");

  {$IF COOPER}
  result := new java.util.ArrayList<T>(Items);
  {$ELSEIF ECHOES}
  exit new System.Collections.Generic.List<T>(Items);
  {$ELSEIF NOUGAT}
  result := new Foundation.NSMutableArray withArray(Items);
  {$ENDIF}
end;

constructor List<T>(anArray: array of T);
begin
  if anArray = nil then
    raise new SugarArgumentNullException("anArray");

  {$IF COOPER}
  result := new java.util.ArrayList<T>(java.util.Arrays.asList(anArray));
  {$ELSEIF ECHOES}
  exit new System.Collections.Generic.List<T>(anArray);
  {$ELSEIF NOUGAT}
  result := new Foundation.NSMutableArray;
  for i: Integer := 0 to length(anArray) - 1 do
    result.Add(anArray[i]);
  {$ENDIF}
end;

method List<T>.Add(anItem: T);
begin
  if anItem = nil then
    raise new SugarArgumentNullException("Item");

  {$IF COOPER OR ECHOES}
  mapped.Add(anItem);
  {$ELSEIF NOUGAT}
  mapped.addObject(anItem);
  {$ENDIF}
end;

method List<T>.SetItem(&Index: Integer; Value: T);
begin
  if Value = nil then
    raise new SugarArgumentNullException("Value");
  
  mapped[&Index] := Value;
end;

method List<T>.AddRange(Items: List<T>);
begin
  if Items = nil then
    raise new SugarArgumentNullException("Items");

  {$IF COOPER}
  mapped.AddAll(Items);
  {$ELSEIF ECHOES}
  mapped.AddRange(Items);
  {$ELSEIF NOUGAT}
  mapped.addObjectsFromArray(Items);
  {$ENDIF}
end;

method List<T>.Clear;
begin
  {$IF COOPER}
  mapped.Clear;
  {$ELSEIF ECHOES}
  mapped.Clear;
  {$ELSEIF NOUGAT}
  mapped.RemoveAllObjects;
  {$ENDIF}
end;

method List<T>.Contains(anItem: T): Boolean;
begin
  {$IF COOPER}
  exit mapped.Contains(anItem);
  {$ELSEIF ECHOES}
  exit mapped.Contains(anItem);
  {$ELSEIF NOUGAT}
  exit mapped.ContainsObject(anItem);
  {$ENDIF}
end;

method List<T>.Exists(Match: Predicate<T>): Boolean;
begin
  exit self.FindIndex(Match) <> -1;
end;

method List<T>.FindIndex(Match: Predicate<T>): Integer;
begin
  exit self.FindIndex(0, Count, Match);
end;

method List<T>.FindIndex(StartIndex: Integer; Match: Predicate<T>): Integer;
begin
  exit self.FindIndex(StartIndex, Count - StartIndex, Match);
end;

method List<T>.FindIndex(StartIndex: Integer; aCount: Integer; Match: Predicate<T>): Integer;
begin
    if StartIndex > Count then
    raise new SugarArgumentOutOfRangeException(ErrorMessage.ARG_OUT_OF_RANGE_ERROR, "StartIndex");

  if (aCount < 0) or (StartIndex > Count - aCount) then
    raise new SugarArgumentOutOfRangeException(ErrorMessage.ARG_OUT_OF_RANGE_ERROR, "Count");

  if Match = nil then
    raise new SugarArgumentNullException("Match");

  var Length := StartIndex + aCount; 

  for i: Int32 := StartIndex to Length - 1 do
    if Match(mapped[i]) then
      exit i;

  exit -1;
end;

method List<T>.Find(Match: Predicate<T>): T;
begin
  if Match = nil then
    raise new SugarArgumentNullException("Match");

  for i: Integer := 0 to Count-1 do begin
    if Match(mapped[i]) then
      exit mapped[i];
  end;

  exit &default(T);
end;

method List<T>.FindAll(Match: Predicate<T>): List<T>;
begin
  if Match = nil then
    raise new SugarArgumentNullException("Match");

  result := new List<T>();
  for i: Integer := 0 to Count-1 do begin
    if Match(mapped[i]) then
      result.Add(mapped[i]);
  end;
end;

method List<T>.TrueForAll(Match: Predicate<T>): Boolean;
begin
  if Match = nil then
    raise new SugarArgumentNullException("Match");

  for i: Integer := 0 to self.Count-1 do begin
    if not Match(mapped[i]) then
      exit false;
  end;

  exit true;
end;

method List<T>.ForEach(Action: Action<T>): Boolean;
begin
  if Action = nil then
    raise new SugarArgumentNullException("Action");

  for i: Integer := 0 to Count-1 do
    Action(mapped[i]);
end;

method List<T>.IndexOf(anItem: T): Integer;
begin
  {$IF COOPER}
  exit mapped.IndexOf(anItem);
  {$ELSEIF ECHOES}
  exit mapped.IndexOf(anItem);
  {$ELSEIF NOUGAT}
  var lIndex := mapped.indexOfObject(anItem);
  exit if lIndex = NSNotFound then -1 else lIndex;
  {$ENDIF}
end;

method List<T>.Insert(&Index: Integer; anItem: T);
begin
  if anItem = nil then
    raise new SugarArgumentNullException("Item");

  {$IF COOPER}
  mapped.Add(&Index, anItem);
  {$ELSEIF ECHOES}
  mapped.Insert(&Index, anItem);
  {$ELSEIF NOUGAT}
  mapped.insertObject(anItem) atIndex(&Index);
  {$ENDIF}
end;

method List<T>.LastIndexOf(anItem: T): Integer;
begin
  {$IF COOPER}
  exit mapped.LastIndexOf(anItem);
  {$ELSEIF ECHOES}
  exit mapped.LastIndexOf(anItem);
  {$ELSEIF NOUGAT}
  var lIndex := mapped.indexOfObjectWithOptions(Foundation.NSEnumerationReverse) passingTest((x,y,z) -> x = id(anItem));
  exit if lIndex = NSNotFound then -1 else lIndex;
  {$ENDIF}
end;

method List<T>.Remove(anItem: T): Boolean;
begin
  {$IF COOPER}
  exit mapped.Remove(Object(anItem));
  {$ELSEIF ECHOES}
  exit mapped.Remove(anItem);
  {$ELSEIF NOUGAT}
  var lIndex := IndexOf(anItem);
  if lIndex <> -1 then begin
    RemoveAt(lIndex);
    exit true;
  end;
  
  exit false;
  {$ENDIF}
end;

method List<T>.RemoveAt(&Index: Integer);
begin
  {$IF COOPER}
  mapped.remove(&Index);
  {$ELSEIF ECHOES}
  mapped.RemoveAt(&Index);
  {$ELSEIF NOUGAT}
  mapped.removeObjectAtIndex(&Index);
  {$ENDIF}
end;

method List<T>.RemoveRange(&Index: Integer; aCount: Integer);
begin
  {$IF COOPER}
  mapped.subList(&Index, &Index+aCount).clear;
  {$ELSEIF ECHOES}
  mapped.RemoveRange(&Index, aCount);
  {$ELSEIF NOUGAT}
  mapped.removeObjectsInRange(Foundation.NSMakeRange(&Index, aCount));
  {$ENDIF}
end;

method List<T>.ToArray: array of T;
begin
  {$IF COOPER}
  exit mapped.toArray(new T[0]);
  {$ELSEIF ECHOES}
  exit mapped.ToArray;
  {$ELSEIF NOUGAT}
  result := new T[mapped.count];
  for i: Integer := 0 to mapped.count - 1 do
    result[i] := mapped.objectAtIndex(i);
  {$ENDIF}
end;

end.
