(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *         Copyright INRIA, CNRS and contributors             *)
(* <O___,, * (see version control and CREDITS file for authors & dates) *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

(** Declaration of uninterpretation functions (i.e. printing rules)
    for notations *)

open Names
open Constrexpr
open Glob_term
open Notation_term

val notation_entry_eq : notation_entry -> notation_entry -> bool
(** Equality on [notation_entry]. *)

val notation_with_optional_scope_eq : notation_with_optional_scope -> notation_with_optional_scope -> bool

val notation_eq : notation -> notation -> bool
(** Equality on [notation]. *)

val interpretation_eq : interpretation -> interpretation -> bool
(** Equality on [interpretation]. *)

val notation_entry_level_eq : notation_entry_level -> notation_entry_level -> bool
(** Equality on [notation_entry_level]. *)

type level = notation_entry_level * entry_relative_level list
(** The "signature" of a rule: its level together with the levels of its subentries *)

val level_eq : level -> level -> bool
(** Equality on [level]. *)

val entry_relative_level_eq : entry_relative_level -> entry_relative_level -> bool
(** Equality on [entry_relative_level]. *)

(** Binds a notation in a given scope to an interpretation *)
type 'a interp_rule_gen =
  | NotationRule of Constrexpr.specific_notation
  | AbbrevRule of 'a

type interp_rule = KerName.t interp_rule_gen

val remove_uninterpretation : interp_rule -> interpretation -> unit
val declare_uninterpretation : ?also_in_cases_pattern:bool -> interp_rule -> interpretation -> unit

type notation_applicative_status =
  | AppBoundedNotation of int
  | AppUnboundedNotation
  | NotAppNotation

type notation_rule = interp_rule * interpretation * notation_applicative_status

(** Return printing key *)
type key
val glob_prim_constr_key : 'a Glob_term.glob_constr_g -> Names.GlobRef.t option
val glob_constr_keys : glob_constr -> key list
val cases_pattern_key : cases_pattern -> key
val notation_constr_key : Notation_term.notation_constr -> key * notation_applicative_status

(** Return the possible notations for a given term *)
val uninterp_notations : 'a glob_constr_g -> notation_rule list
val uninterp_cases_pattern_notations : 'a cases_pattern_g -> notation_rule list
val uninterp_ind_pattern_notations : inductive -> notation_rule list

(** State protection *)
val with_notation_uninterpretation_protection : ('a -> 'b) -> 'a -> 'b

(** Miscellaneous *)
type notation_use =
  | OnlyPrinting
  | OnlyParsing
  | ParsingAndPrinting
