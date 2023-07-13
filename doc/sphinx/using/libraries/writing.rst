Writing Coq libraries and plugins
===================================

This section presents the part of the Coq language that is useful only
to library and plugin authors.  A tutorial for writing Coq plugins is
available in the Coq repository in `doc/plugin_tutorial
<https://github.com/coq/coq/tree/master/doc/plugin_tutorial>`_.

Deprecating library objects or tactics
--------------------------------------

You may use the following :term:`attribute` to deprecate a notation,
tactic, definition, axiom or theorem.  When renaming a definition or theorem, you can introduce a
deprecated compatibility alias using :cmd:`Notation (abbreviation)`
(see :ref:`the example below <compatibility-alias>`).

.. attr:: deprecated ( {? since = @string , } {? note = @string } )
   :name: deprecated

   At least one of :n:`since` or :n:`note` must be present.  If both
   are present, either one may appear first and they must be separated
   by a comma. If they are present, they will be used in the warning
   message, and :n:`since` will also be used in the warning name and
   categories.

   This attribute is supported by the following commands: :cmd:`Ltac`,
   :cmd:`Tactic Notation`, :cmd:`Notation`, :cmd:`Infix`, :cmd:`Ltac2`,
   :cmd:`Ltac2 Notation`, :cmd:`Ltac2 external`.

   It can trigger the following warnings:

   .. warn:: Tactic @qualid is deprecated since @string__since. @string__note
             Tactic Notation @qualid is deprecated since @string__since. @string__note
             Notation @string is deprecated since @string__since. @string__note
             Ltac2 definition @qualid is deprecated since @string__since. @string__note
             Ltac2 alias @qualid is deprecated since @string__since. @string__note
             Ltac2 notation {+ @ltac2_scope } is deprecated since @string__since. @string__note

      :n:`@qualid` or :n:`@string` is the notation,
      :n:`@string__since` is the version number, :n:`@string__note` is
      the note (usually explains the replacement).

.. note::

   Coq and its standard library follow this deprecation policy:

   * it should always be possible for a project written in Coq to be
     compatible with two successive major versions,
   * features must be deprecated in one major version before removal,
   * Coq developers should provide an estimate of the required effort
     to fix a project with respect to a given change,
   * breaking changes should be clearly documented in the public
     release notes, along with recommendations on how to fix a project
     if it breaks.

   See :cite:`Zimmermann19`, Section 3.6.3, for more details.

.. example:: Deprecating a tactic.

   .. coqtop:: all abort warn

      #[deprecated(since="mylib 0.9", note="Use idtac instead.")]
      Ltac foo := idtac.
      Goal True.
      Proof.
      now foo.

.. _compatibility-alias:

.. example:: Introducing a compatibility alias

   Let's say your library initially contained:

   .. coqtop:: in

      Definition foo x := S x.

   and you want to rename `foo` into `bar`, but you want to avoid breaking
   your users' code without advanced notice.  To do so, replace the previous
   code by the following:

   .. coqtop:: in reset

      Definition bar x := S x.
      #[deprecated(since="mylib 1.2", note="Use bar instead.")]
      Notation foo := bar (only parsing).

   Then, the following code still works, but emits a warning:

   .. coqtop:: all warn

      Check (foo 0).
