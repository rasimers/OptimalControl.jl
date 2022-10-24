include("../src/ControlToolbox.jl"); # nécessaire tant que pas un vrai package
import .ControlToolbox: plot , plot! # nécessaire tant que include et using relatif
using .ControlToolbox
using Plots

# ocp solution to use a close init to the solution
N  = 1001
U⁺ = range(6.0, stop=-6.0, length=N); # solution
U⁺ = U⁺[1:end-1];

# ocp description
t0 = 0.0                # t0 is fixed
tf = 1.0                # tf is fixed
x0 = [-1.0; 0.0]        # the initial condition is fixed
xf = [ 0.0; 0.0]        # the target
A  = [0.0 1.0
      0.0 0.0]
B  = [0.0; 1.0]
f(x, u) = A*x+B*u[1];  # dynamics
L(x, u) = 0.5*u[1]^2   # integrand of the Lagrange cost

# ocp definition
ocp = OCP(L, f, t0, x0, tf, xf, 2, 1, :autonomous)

# ocp print
display(ocp)

# initial iterate
U_init = U⁺-1e0*ones(N-1); U_init = [ [U_init[i]] for i=1:N-1 ]

# resolution
sol = solve(ocp, :bfgs, :backtracking, init=U_init, grid_size=N)

# plot solution
ps = plot(sol, size=(800, 400))

# plot target
point_style = (color=:black, seriestype=:scatter, markersize=3, markerstrokewidth=0, label="")
plot!(ps[1], [tf], [xf[1]]; point_style...)
plot!(ps[1], [tf], [xf[2]]; point_style...)