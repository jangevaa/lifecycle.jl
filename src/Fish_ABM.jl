module Fish_ABM

using DataFrames, Distributions, Gadfly

include("types.jl")
include("agents.jl")
include("stock.jl")
include("agent_stock_interaction.jl")
include("simulate.jl")

end # module
