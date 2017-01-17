start(q000). /* start state */

final(q100). /* accepted state */
final(q110). /* accepted state */
final(q101). /* accepted state */
final(q111). /* accepted state */

delta(q000, '0', q000). /* δ: q000 ∙ 0 -> q000 */
delta(q000, '1', q001). /* δ: q000 ∙ 1 -> q001 */

delta(q001, '0', q010). /* δ: q001 ∙ 0 -> q010 */
delta(q001, '1', q011). /* δ: q001 ∙ 1 -> q011 */

delta(q010, '0', q100). /* δ: q010 ∙ 0 -> q100 */
delta(q010, '1', q101). /* δ: q010 ∙ 1 -> q101 */

delta(q011, '0', q110). /* δ: q011 ∙ 0 -> q110 */
delta(q011, '1', q111). /* δ: q011 ∙ 1 -> q111 */

delta(q100, '0', q000). /* δ: q100 ∙ 0 -> q000 */
delta(q100, '1', q001). /* δ: q100 ∙ 1 -> q001 */

delta(q101, '0', q010). /* δ: q101 ∙ 0 -> q010 */
delta(q101, '1', q011). /* δ: q101 ∙ 1 -> q011 */

delta(q110, '0', q100). /* δ: q110 ∙ 0 -> q100 */
delta(q110, '1', q101). /* δ: q110 ∙ 1 -> q101 */

delta(q111, '0', q110). /* δ: q111 ∙ 0 -> q110 */
delta(q111, '1', q111). /* δ: q111 ∙ 1 -> q111 */

use_prolog_flag(double_quotes, chars).

/*
 * delta_hat predicate turns a string or atom into
 * a list of chars and validates the dfa with
 * delta_hat(List, Q0).
 */
delta_hat(String) :-
	start(Q0),
	delta_hat(String, Q0).

delta_hat(Atom) :-
	start(Q0),
	atom_chars(Atom, Chars),
	delta_hat(Chars, Q0).
/*
 * base case of delta_hat, ?- final(Q).
 */
delta_hat([], Q) :- final(Q).

/*
 * recursive delta_hat definition applies delta on
 * every character in the list keeping track of the
 * current automaton state.
 * { W ε {0,1}* | {0,1}*1{0,1}² }
 */
delta_hat([Head | Tail], Q) :-
	delta(Q, Head, Q_next),
	delta_hat(Tail, Q_next).
