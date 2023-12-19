using DrWatson
@quickactivate "Epidemiologie"

using DynamicalSystems
using CairoMakie

function eom(u, p, n) # here `n` is "time", but we don't use it.
    N, M  = u # system state
    r_N, r_M, K = p # system parameters
    dN = N * exp(r_N*(1-(N+M)/K))
    dM = M * exp(r_M*(1-(N+M)/K))
    return SVector(dN, dM)
end

u0 = [1.0,1.0]
p0 = [3,3.001, 50]
system = DeterministicIteratedMap(eom, u0, p0)


#data ,time = trajectory(system, 10000)
#plot(time[end-100:1:end],data[:,1][end-100:1:end], label="1")
#plot!(time[end-100:1:end], data[:,2][end-100:1:end],label="2")

p_values = 1:0.001:4
output = orbitdiagram(system, 1, 1, p_values)

fig = Figure()
ax = Axis(fig[1,1])
for (j, p) in enumerate(p_values)
    scatter!(ax, p .* ones(length(output[j])), output[j], lw = 0, marker = "o", ms = 0.2, color = "black")
end
display(fig)