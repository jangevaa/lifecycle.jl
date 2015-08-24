module FishABM

using DataFrames, Distributions, Gadfly, ProgressMeter

export
  # Types
  AgentAssumptions,
  EnvironmentAssumptions,
  StockAssumptions,
  StockDB,

  # agent_stock_interaction.jl functions
  spawn!,
  graduate!,

  # agents.jl functions
  AgentDB,
  kill!,
  localmove,
  move!,
  injectagents!,

  # simulationResults.jl functions
  convertToStringArray,
  simulationSummary,

  # stock.jl functions
  harvest!,
  ageadults!,

  # utilities.jl functions
  pad_environment!,
  plot_agents,
  plot_stock,
  plot_stock_k,
  writeOutAgentPlots,

  # simulate.jl functions
  simulate

include("types.jl")
include("utilities.jl")
include("agents.jl")
include("stock.jl")
include("agent_stock_interaction.jl")
include("simulate.jl")
include("simulationResults.jl")

end # module
