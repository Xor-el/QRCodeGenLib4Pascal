{ *********************************************************************************** }
{ *                              QRCodeGenLib Library                               * }
{ *                 Copyright (c) 2018 - 2019 Ugochukwu Mmaduekwe                   * }
{ *                 Github Repository <https://github.com/Xor-el>                   * }

{ *  Distributed under the MIT software license, see the accompanying file LICENSE  * }
{ *          or visit http://www.opensource.org/licenses/mit-license.php.           * }

{ * ******************************************************************************* * }

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)


{---------------------------- Compiler Family Switch --------------------------}
{$IFDEF FPC}
  {$I QRCodeGenLibFPC.inc} // FPC-specific settings
{$ELSE}
  {$DEFINE DELPHI}
  {$I ../../QRCodeGenLib/src/Include/QRCodeGenLibDelphi.inc} // Delphi-specific settings
{$ENDIF}

{-------------------------- Common Compiler Settings --------------------------}
{$SCOPEDENUMS ON}
{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}
{$POINTERMATH ON}
{$WARNINGS OFF}
{$HINTS OFF}

(* &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& *)
