(***********************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team    *)
(* <O___,, *        INRIA-Rocquencourt  &  LRI-CNRS-Orsay              *)
(*   \VV/  *************************************************************)
(*    //   *      This file is distributed under the terms of the      *)
(*         *       GNU Lesser General Public License Version 2.1       *)
(***********************************************************************)

(*i $Id$ i*)

(*i*)
open Names
open Term
open Tacmach
open Tacexpr
open Rawterm
(*i*)

type inversion_status = Dep of constr option | NoDep

val inv_gen :
  bool -> inversion_kind -> inversion_status ->
    case_intro_pattern_expr -> quantified_hypothesis -> tactic
val invIn_gen :
  inversion_kind -> case_intro_pattern_expr -> identifier list -> 
    quantified_hypothesis -> tactic

val inv_clause :
  inversion_kind -> case_intro_pattern_expr -> identifier list ->
    quantified_hypothesis -> tactic

val inv : inversion_kind -> case_intro_pattern_expr ->
  quantified_hypothesis -> tactic

val dinv : inversion_kind -> constr option -> case_intro_pattern_expr ->
  quantified_hypothesis -> tactic

val half_inv_tac : identifier -> tactic
val inv_tac : identifier -> tactic
val inv_clear_tac : identifier -> tactic
val half_dinv_tac : identifier -> tactic
val dinv_tac : identifier -> tactic
val dinv_clear_tac : identifier -> tactic
