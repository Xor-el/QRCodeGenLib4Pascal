{ * ************************************************************************ * }
{ *                           QRCodeGenLib Library                           * }
{ *                       Author - Ugochukwu Mmaduekwe                       * }
{ *              Github Repository <https://github.com/Xor-el>               * }
{ *                                                                          * }
{ *  Distributed under the MIT software license, see the accompanying file   * }
{ *                                 LICENSE                                  * }
{ *         or visit http://www.opensource.org/licenses/mit-license.         * }
{ *                                                                          * }
{ * ************************************************************************ * }

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)

// FPC 3.0.0 and Above
{$IF FPC_FULLVERSION < 30000}
   {$MESSAGE ERROR 'This Library requires FreePascal 3.0.0 or higher.'}
{$IFEND}

{$IFDEF ENDIAN_BIG}
   {$MESSAGE FATAL 'This Library does not support "Big Endian" processors yet.'}
{$ENDIF}

{========================= Framework Selection ================================}

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

{========================= Compiler Mode & Optimizations ======================}

{$MODE DELPHI}
{$MACRO ON}
{$NOTES OFF}

(*
{$OPTIMIZATION LEVEL3}
{$OPTIMIZATION PEEPHOLE}
{$OPTIMIZATION REGVAR}
{$OPTIMIZATION LOOPUNROLL}
{$OPTIMIZATION STRENGTH}
{$OPTIMIZATION CSE}
{$OPTIMIZATION DFA}
{$IFDEF CPUI386}  {$OPTIMIZATION USEEBP} {$ENDIF}
*)
