{ *********************************************************************************** }
{ *                              QRCodeGenLib Library                               * }
{ *                 Copyright (c) 2018 - 2019 Ugochukwu Mmaduekwe                   * }
{ *                 Github Repository <https://github.com/Xor-el>                   * }

{ *  Distributed under the MIT software license, see the accompanying file LICENSE  * }
{ *          or visit http://www.opensource.org/licenses/mit-license.php.           * }

{ * ******************************************************************************* * }

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)

{$IFDEF FPC}
  {$IFDEF ENDIAN_BIG}
     {$MESSAGE FATAL 'This Library does not support "Big Endian" processors yet.'}
  {$ENDIF}

  // FPC 3.0.0 and Above
  {$IF FPC_FULLVERSION < 30000}
     {$MESSAGE ERROR 'This Library requires FreePascal 3.0.0 or higher.'}
  {$IFEND}

  {$DEFINE Framework_FCL} // enable to force FCL mode
  {$IFDEF Framework_FCL}
     {$UNDEF LCL}
     {$DEFINE FCL}
  {$ELSE}
     {$DEFINE LCL}
  {$ENDIF}

  {$IFDEF LCL}
     {$DEFINE VCL_OR_LCL}
  {$ENDIF LCL}

  {$MODE DELPHI}
  {$MACRO ON}
  {$NOTES OFF}
  {$OPTIMIZATION LEVEL3}
  {$OPTIMIZATION PEEPHOLE}
  {$OPTIMIZATION REGVAR}
  {$OPTIMIZATION LOOPUNROLL}
  {$OPTIMIZATION STRENGTH}
  {$OPTIMIZATION CSE}
  {$OPTIMIZATION DFA}
  {$IFDEF CPUI386}  {$OPTIMIZATION USEEBP} {$ENDIF}
  {$IFDEF CPUX86_64} {$OPTIMIZATION USERBP} {$ENDIF}
{$ENDIF}

