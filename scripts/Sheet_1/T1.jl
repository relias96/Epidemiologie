using DrWatson
@quickactivate "Epidemiologie"

using XLSX
using DataFrames,Plots
using CurveFit

function get_R0(λ; γ=0.125)
    return λ / γ + 1
end

open(datadir("sims", "T1.txt"),"w+") do io
    for country in ["Germany", "Italy", "China"]
        df = DataFrame(XLSX.readtable(joinpath(datadir("exp_raw", "T1"),"COVID-19_selected-data.xlsx"),country))
        cases::Vector{Int32} = df[:,:cases]
        p = plot(cases, label=country, seriestype=:scatter)
        e = exp_fit(1:length(cases), cases)
        println(io, country * "\t : λ = " * string(e[2]) * "   ⇒  R0 = " * string(get_R0(e[2])))
        xrange = 0:0.001:length(cases)
        f = e[1]*exp.(e[2]* xrange)
        plot!(p, xrange, f, title=country, label="exp-fit")
        display(p)
        save(joinpath(plotsdir("T1"), country*".png"), p)
    end
end
