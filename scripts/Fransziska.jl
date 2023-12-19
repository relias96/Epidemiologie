using DrWatson
@quickactivate "Epidemiologie"

using DynamicalSystems
using CairoMakie

function eom(u, p, n)
    b,d,c,alpha, beta, a_s, a_i,m , e = p
    S,I,P = u
    dS = b*S - (d + c*(S+I))*S - beta*S*I - a_s*S*P
    dI = beta*S*I - (d+c*(S+I))*I - alpha*I - a_i*I*P
    dP = e*(a_s*S + a_i*I)*P -m*P
    return SVector(dS, dI, dP)
end

u0 = [1.0,1.0,1.0]
p0 = (0.5, 0.2, 0.1, 0.6, 0.2, 0.2, 2.0, 0.3,0.1)





function plotTimeseries(system, t=100; title)
    fig = Figure()
    ax = Axis(fig[1,1], title = title)
    data ,time = trajectory(system, t)
    lines!(ax, time,data[:,1], label="S")
    lines!(ax, time, data[:,2],label="I")
    lines!(ax, time, data[:,3], label ="P")
    axislegend(ax)
    display(fig)
end

function plotOrbitdiagramm()
    fig = Figure()
    ax = Axis(fig[1,1])
    p_values = 1:0.001:4

    i = 1
    plane = (2, 20.0)
    tf = 1000.0
    p_index = 1

    output = produce_orbitdiagram(ds, plane, i, p_index, p_values; tfinal = tf, Ttr = 000.0, direction = -1, printparams = false)
    for (j, p) in enumerate(p_values)
        scatter!(ax, p .* ones(length(output[j])), output[j], lw = 0, marker = "o", ms = 0.2, color = "black")
    end
    display(fig)
end
#plotOrbitdiagramm()
for i in 0.01:0.01:0.5
    p0 = (1.5, 0.12, 0.1, 0.5, 0.75, 0.23, 2, 0.3, 0.1)
    u0 = [1.0,1.0,1.0]
    ds = CoupledODEs(eom, u0, p0)
    plotTimeseries(ds,200, title=string(i))
end