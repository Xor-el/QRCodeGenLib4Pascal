unit QlpBitBuffer;

{$I ..\Include\QRCodeGenLib.inc}

interface

uses
  QlpBits,
  QlpArrayUtils,
  QlpQRCodeGenLibTypes;

resourcestring
  SInvalidDataContent = 'Data is not a whole number of bytes';
  SValueOutOfRange = 'Value out of range';
  SLastWordError = 'Last word must have low bits clear';
  SMaximumLengthReached = 'Maximum length reached';
  SBitBufferNotInitialized = 'BitBuffer not initialized';

type

  /// <summary>
  /// An appendable sequence of bits (0s and 1s). Mainly used by <see cref="QlpQrSegment">
  /// TQrSegment</see>.
  /// </summary>
  TBitBuffer = record
  strict private
  var
    FData: TQRCodeGenLibInt32Array;
    FBitLength: Int32;
    FBitBufferInitialized: Boolean;

    function GetData: TQRCodeGenLibInt32Array; inline;
    function GetBitLength: Int32; inline;

    /// <summary>
    /// method to check if <c>TBitBuffer</c> record is initialized or not.
    /// </summary>
    /// <exception cref="EInvalidOperationQRCodeGenLibException">
    /// if <c>TBitBuffer</c> is not initialized.
    /// </exception>
    procedure CheckBitBufferState(); inline;

  public

    /// <summary>
    /// Constructs an empty bit buffer (length 0).
    /// </summary>
    class function Create(): TBitBuffer; static;

    /// <summary>
    /// Returns the length of this sequence, which is a non-negative value.
    /// </summary>
    /// <returns>
    /// the length of this sequence
    /// </returns>
    function GetBit(AIndex: Int32): Int32; inline;

    /// <summary>
    /// Returns an array representing this buffer's bits packed into bytes in
    /// big endian. The current bit length must be a multiple of 8.
    /// </summary>
    /// <returns>
    /// a new byte array representing this bit sequence
    /// </returns>
    function GetBytes(): TQRCodeGenLibByteArray; inline;

    /// <summary>
    /// Appends the specified number of low-order bits of the specified value
    /// to this buffer. Requires 0 ≤ len ≤ 31 and 0 ≤ val &lt; 2 <sup>len</sup>
    /// .
    /// </summary>
    /// <param name="AValue">
    /// the value to append
    /// </param>
    /// <param name="ALength">
    /// the number of low-order bits in the value to take
    /// </param>
    /// <exception cref="QlpQRCodeGenLibTypes|EArgumentOutOfRangeQRCodeGenLibException">
    /// if the value or number of bits is out of range
    /// </exception>
    /// <exception cref="QlpQRCodeGenLibTypes|EInvalidOperationQRCodeGenLibException">
    /// if appending the data would make <c>BitLength</c> exceed
    /// System.High(Int32)
    /// </exception>
    procedure AppendBits(AValue, ALength: Int32); overload;

    procedure AppendBits(const AValues: TQRCodeGenLibInt32Array;
      ALength: Int32); overload;

    property Data: TQRCodeGenLibInt32Array read GetData;
    property BitLength: Int32 read GetBitLength;

  end;

implementation

{ TBitBuffer }

procedure TBitBuffer.CheckBitBufferState;
begin
  if not FBitBufferInitialized then
  begin
    raise EInvalidOperationQRCodeGenLibException.CreateRes
      (@SBitBufferNotInitialized);
  end;
end;

class function TBitBuffer.Create(): TBitBuffer;
begin
  Result := Default(TBitBuffer);
  System.SetLength(Result.FData, 64);
  Result.FBitLength := 0;
  Result.FBitBufferInitialized := True;
end;

procedure TBitBuffer.AppendBits(AValue, ALength: Int32);
var
  LRemain: Int32;
begin
  CheckBitBufferState();
  if ((ALength < 0) or (ALength > 31) or (TBits.Asr32(AValue, ALength) <> 0))
  then
  begin
    raise EArgumentOutOfRangeQRCodeGenLibException.CreateRes(@SValueOutOfRange);
  end;

  if (ALength > (System.High(Int32) - FBitLength)) then
  begin
    raise EInvalidOperationQRCodeGenLibException.CreateRes
      (@SMaximumLengthReached);
  end;

  if ((FBitLength + ALength + 1) > (System.Length(FData) shl 5)) then
  begin
    FData := TArrayUtils.CopyOf(FData, System.Length(FData) * 2);
  end;
{$IFDEF DEBUG}
  System.Assert((FBitLength + ALength) <= System.Length(FData) shl 5);
{$ENDIF DEBUG}
  LRemain := 32 - (FBitLength and $1F);
{$IFDEF DEBUG}
  System.Assert((1 <= LRemain) and (LRemain <= 32));
{$ENDIF DEBUG}
  if (LRemain < ALength) then
  begin
    FData[TBits.Asr32(FBitLength, 5)] := FData[TBits.Asr32(FBitLength, 5)] or
      TBits.Asr32(AValue, (ALength - LRemain));
    FBitLength := FBitLength + LRemain;
{$IFDEF DEBUG}
    System.Assert((FBitLength and $1F) = 0);
{$ENDIF DEBUG}
    ALength := ALength - LRemain;
    AValue := AValue and ((1 shl ALength) - 1);
    LRemain := 32;
  end;
  FData[TBits.Asr32(FBitLength, 5)] := FData[TBits.Asr32(FBitLength, 5)] or
    (AValue shl (LRemain - ALength));
  FBitLength := FBitLength + ALength;
end;

procedure TBitBuffer.AppendBits(const AValues: TQRCodeGenLibInt32Array;
  ALength: Int32);
var
  LWholeWords, LTailBits, LShift, LWord, LIdx: Int32;
begin
  CheckBitBufferState();
  if (ALength = 0) then
  begin
    Exit;
  end;
  if ((ALength < 0) or (ALength > System.Length(AValues) * Int64(32))) then
  begin
    raise EArgumentOutOfRangeQRCodeGenLibException.CreateRes(@SValueOutOfRange);
  end;
  LWholeWords := ALength shr 5;
  LTailBits := ALength and 31;
  if ((LTailBits > 0) and ((AValues[LWholeWords] shl LTailBits) <> 0)) then
  begin
    raise EArgumentInvalidQRCodeGenLibException.CreateRes(@SLastWordError);
  end;

  if (ALength > (System.High(Int32) - FBitLength)) then
  begin
    raise EInvalidOperationQRCodeGenLibException.CreateRes
      (@SMaximumLengthReached);
  end;

  while ((FBitLength + ALength) > (System.Length(FData) * 32)) do
  begin
    FData := TArrayUtils.CopyOf(FData, System.Length(FData) * 2);
  end;

  LShift := FBitLength and 31;
  if (LShift = 0) then
  begin
    System.Move(AValues[0], FData[FBitLength shr 5], ((ALength + 31) shr 5) *
      System.SizeOf(Int32));
    FBitLength := FBitLength + ALength;
  end
  else
  begin
    for LIdx := 0 to System.Pred(LWholeWords) do
    begin
      LWord := AValues[LIdx];
      FData[TBits.Asr32(FBitLength, 5)] := FData[TBits.Asr32(FBitLength, 5)] or
        (LWord shr LShift);
      FBitLength := FBitLength + 32;
      FData[TBits.Asr32(FBitLength, 5)] := LWord shl (32 - LShift);
    end;
    if (LTailBits > 0) then
    begin
      AppendBits(AValues[LWholeWords] shr (32 - LTailBits), LTailBits);
    end;
  end;
end;

function TBitBuffer.GetBit(AIndex: Int32): Int32;
begin
  CheckBitBufferState();
  if ((AIndex < 0) or (AIndex >= FBitLength)) then
  begin
    raise EIndexOutOfRangeQRCodeGenLibException.Create('');
  end;
  Result := (TBits.Asr32(FData[TBits.Asr32(AIndex, 5)], not(AIndex))) and 1;
end;

function TBitBuffer.GetBitLength: Int32;
begin
  CheckBitBufferState();
  Result := FBitLength;
end;

function TBitBuffer.GetBytes: TQRCodeGenLibByteArray;
var
  LIdx: Int32;
begin
  CheckBitBufferState();
  if ((FBitLength and 7) <> 0) then
  begin
    raise EInvalidOperationQRCodeGenLibException.CreateRes
      (@SInvalidDataContent);
  end;
  System.SetLength(Result, FBitLength shr 3);
  for LIdx := 0 to System.Pred(System.Length(Result)) do
  begin
    Result[LIdx] := Byte(TBits.Asr32(FData[TBits.Asr32(LIdx, 2)],
      ((not LIdx) shl 3)));
  end;
end;

function TBitBuffer.GetData: TQRCodeGenLibInt32Array;
begin
  CheckBitBufferState();
  Result := System.Copy(FData);
end;

end.
