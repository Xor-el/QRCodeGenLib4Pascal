{ *********************************************************************************** }
{ *                              QRCodeGenLib Library                               * }
{ *                 Copyright (c) 2018 - 2019 Ugochukwu Mmaduekwe                   * }
{ *                 Github Repository <https://github.com/Xor-el>                   * }

{ *  Distributed under the MIT software license, see the accompanying file LICENSE  * }
{ *          or visit http://www.opensource.org/licenses/mit-license.php.           * }

{ * ******************************************************************************* * }

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)

{$IFDEF DELPHI}
  {$DEFINITIONINFO ON}       // IDE navigation; no binary impact
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

  {$IF CompilerVersion < 24.0}
    {$MESSAGE ERROR 'This Library requires Delphi XE3 or higher.'}
  {$IFEND}
{$ENDIF}

