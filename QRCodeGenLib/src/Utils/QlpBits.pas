unit QlpBits;

{$I ..\Include\QRCodeGenLib.inc}

interface

type
  TBits = class sealed(TObject)

  public

    /// <summary>
    /// Calculates Arithmetic shift right.
    /// </summary>
    /// <param name="AValue">Int32 value to compute 'Asr' on.</param>
    /// <param name="AShiftBits">Byte, number of bits to shift value to.</param>
    /// <returns>Shifted value.</returns>
    /// <remarks>
    /// Emulated Implementation was gotten from FreePascal sources
    /// </remarks>

    class function Asr32(AValue: Int32; AShiftBits: Byte): Int32;
      static; inline;

    /// <summary>
    /// Calculates Arithmetic shift right.
    /// </summary>
    /// <param name="AValue">Int64 value to compute 'Asr' on.</param>
    /// <param name="AShiftBits">Byte, number of bits to shift value to.</param>
    /// <returns>Shifted value.</returns>
    /// <remarks>
    /// Emulated Implementation was gotten from FreePascal sources
    /// </remarks>

    class function Asr64(AValue: Int64; AShiftBits: Byte): Int64;
      static; inline;

  end;

implementation

{ TBits }

class function TBits.Asr32(AValue: Int32; AShiftBits: Byte): Int32;

begin
{$IFDEF FPC}
  Result := SarLongInt(AValue, AShiftBits);
{$ELSE}
  Result := Int32(UInt32(UInt32(UInt32(AValue) shr (AShiftBits and 31)) or
    (UInt32(Int32(UInt32(0 - UInt32(UInt32(AValue) shr 31)) and
    UInt32(Int32(0 - (Ord((AShiftBits and 31) <> 0) { and 1 } )))))
    shl (32 - (AShiftBits and 31)))));
{$ENDIF FPC}
end;

class function TBits.Asr64(AValue: Int64; AShiftBits: Byte): Int64;
begin
{$IFDEF FPC}
  Result := SarInt64(AValue, AShiftBits);
{$ELSE}
  Result := Int64(UInt64(UInt64(UInt64(AValue) shr (AShiftBits and 63)) or
    (UInt64(Int64(UInt64(0 - UInt64(UInt64(AValue) shr 63)) and
    UInt64(Int64(0 - (Ord((AShiftBits and 63) <> 0) { and 1 } )))))
    shl (64 - (AShiftBits and 63)))));
{$ENDIF FPC}
end;

end.
