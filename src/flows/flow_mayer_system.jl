# --------------------------------------------------------------------------------------------
# Mayer
# --------------------------------------------------------------------------------------------
struct Mayer f::Function end

# Flow from Mayer system
Flow(Σu::Mayer) = Flow(PseudoHamiltonian((x, p, u) -> p'*Σu.f(x,u)));