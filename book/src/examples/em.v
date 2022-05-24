Theorem em_irr:
  forall A: Prop, ~~(A \/ ~A).
Proof.
  unfold not.
  intros.
  apply H.
  right.
  intros.
  apply H.
  left.
  exact H0.
Qed.
