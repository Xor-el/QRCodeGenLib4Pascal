{ *********************************************************************************** }
{ *                              QRCodeGenLib Library                               * }
{ *                          Author - Ugochukwu Mmaduekwe                           * }
{ *                 Github Repository <https://github.com/Xor-el>                   * }

{ *  Distributed under the MIT software license, see the accompanying file LICENSE  * }
{ *          or visit http://www.opensource.org/licenses/mit-license.php.           * }

{ * ******************************************************************************* * }

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)

{========================= Compiler Specific Settings =========================}

{$IFDEF FPC}
  {$I QRCodeGenLibFPC.inc}
{$ELSE}
   // Delphi XE3 and Above
  {$IF CompilerVersion < 24.0}
    {$MESSAGE ERROR 'This Library requires Delphi XE3 or higher.'}
  {$IFEND}

  {$DEFINE DELPHI}

  {$DEFINITIONINFO ON} // Enable code browsing (Ctrl+Click)
  {$STRINGCHECKS OFF}
  {$WARN DUPLICATE_CTOR_DTOR OFF}

  {.$DEFINE Framework_FMX} // enable to force FMX mode
  {$IFDEF Framework_FMX}
     {$UNDEF VCL}
     {$DEFINE FMX}
  {$ELSE}
     {$DEFINE VCL}
  {$ENDIF}

  {$IFDEF VCL}
     {$DEFINE VCL_OR_LCL}
  {$ENDIF VCL}

  // XE and Above
  {$IF CompilerVersion >= 22.0}
     {$DEFINE DELPHIXE_UP}
  {$IFEND}

{$ENDIF}

{========================== Common Compiler Settings ==========================}

{$HINTS OFF}
{$WARNINGS OFF}
{$RANGECHECKS OFF}
{$OVERFLOWCHECKS OFF}
{$SCOPEDENUMS ON}
{$POINTERMATH ON}

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)
